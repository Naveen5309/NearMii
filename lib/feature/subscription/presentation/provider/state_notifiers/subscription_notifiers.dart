import 'dart:async';
import 'dart:io';

import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/helpers/all_getter.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:NearMii/feature/subscription/domain/usecases/subscription_usecases.dart';
import 'package:NearMii/feature/subscription/presentation/provider/states/subscription_states.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:intl/intl.dart';

class SubscriptionNotifiers extends StateNotifier<SubscriptionStates> {
  final SubscriptionUseCases subscriptionUseCase;

  SubscriptionNotifiers({required this.subscriptionUseCase})
      : super(SubscriptionInitial());

  final InAppPurchase _iap = InAppPurchase.instance;

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;

  List<String> ids = [];

  final List<String> _kProductIds = ["membership"];
  final String _kConsumableId = 'consumable';
  List<ProductDetails> products = [];

  initializeSubscription() {
    printLog("Initialize Subscription");
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;

    printLog("purchaseUpdated :-> $purchaseUpdated");
    _subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      printLog("purchaseUpdated :-> $_subscription");
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (Object error) {
      // handle error here.
    });
  }

  void init() async {
    bool isAvailable = await _iap.isAvailable();
    if (isAvailable) {
      await _getProductDetails();
    }
  }

  Future<List<ProductDetails>> _getProductDetails() async {
    try {
      ids = ["membership"];

      ProductDetailsResponse response =
          await _iap.queryProductDetails(ids.toSet());

      printLog("RESPONSE:-> ${response.productDetails}");
      products.clear();
      products.addAll(response.productDetails);
      products.sort((a, b) => a.rawPrice.compareTo(b.rawPrice));
      // printLog("RESPONSE:-> ${products[1].title}");

      for (int a = 0; a < products.length; a++) {
        printLog("PRODUCT LIST:-> ${products[a].title}");
        printLog("PRODUCT LIST PRICE:-> ${products[a].price}");
      }

      // await completeAllProduct();

      return response.productDetails;
    } on Exception catch (e, t) {
      printLog("_getProductDetails>>>>>>${e.toString()}");
      printLog("_getProductDetails>>>>>>${t.toString()}");
      return <ProductDetails>[];
    }
  }

  Future<bool?> buySubscription() async {
    // showLoading(navigatorKey.currentContext!);

    try {
      ProductDetails? productDetails;
      final productDetailsResponse =
          await _iap.queryProductDetails({products[0].id.toString()});
      productDetails = productDetailsResponse.productDetails.firstOrNull;
      if (productDetails != null) {
        final purchaseParam = PurchaseParam(productDetails: productDetails);

        // await completeAllProduct(completeAll: true);
        await _iap.buyNonConsumable(purchaseParam: purchaseParam);
      }
      // logConsole('testing1 BUY SUBS');

      // verifyPurchases();
      return true;
    } on PlatformException catch (e) {
      // changePaymentSheetStatus(false);
      // if (e.code == "storekit_duplicate_product_object") {
      //   completeAllProduct();

      //   if (context.mounted) {
      //     buySubscription(product, context);
      //   }
      // }
      // ignore: unused_catch_stack
    } on Exception catch (e, t) {
      // changePaymentSheetStatus(false);
      return false;
    }
    return null;
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    // IMPORTANT!! Always verify purchase details before delivering the product.
    // if (purchaseDetails.productID == _kConsumableId) {
    //   await ConsumableStore.save(purchaseDetails.purchaseID!);
    //   final List<String> consumables = await ConsumableStore.load();
    //   setState(() {
    //     _purchasePending = false;
    //     _consumables = consumables;
    //   });
    // } else {
    //   setState(() {
    //     _purchases.add(purchaseDetails);
    //     _purchasePending = false;
    //   });
    // }
  }

  void showPendingUI() {}

  void handleError(IAPError error) {}

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }
  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    printLog("purchaseDetails is :-> $purchaseDetailsList");

    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      printLog("purchaseDetails is :-> $purchaseDetails");
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          final bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            unawaited(deliverProduct(purchaseDetails));
          } else {
            _handleInvalidPurchase(purchaseDetails);
            return;
          }
        }
        if (Platform.isAndroid) {
          if (purchaseDetails.productID == _kConsumableId) {
            final InAppPurchaseAndroidPlatformAddition androidAddition =
                _inAppPurchase.getPlatformAddition<
                    InAppPurchaseAndroidPlatformAddition>();
            await androidAddition.consumePurchase(purchaseDetails);
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

  //Report
  Future<void> addSubscription({required String paymentToken}) async {
    state = const SubscriptionApiLoading();
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const SubscriptionApiFailed(
          error: AppString.noInternetConnection,
        );
        return;
      }
      if (await Getters.networkInfo.isSlow) {
        toast(
          msg: AppString.networkSlow,
        );
      }
      Map<String, dynamic> body = {
        "subscriptionPlan": 'monthly',
        "paymentToken": paymentToken,
        "price": "19.99",
        "startDate": DateFormat('yyyy-MM-dd').format(
          DateTime.now(),
        ),
      };

      printLog("body is :->$body");
      final result = await subscriptionUseCase.addSubscription(
        body: body,
      );
      state = result.fold((error) {
        printLog("subscription error:${error.message} ");
        return SubscriptionApiFailed(
          error: error.message,
        );
      }, (result) {
        printLog("result is::$result");

        return const SubscriptionApiSuccess();
      });
    } catch (e) {
      state = SubscriptionApiFailed(
        error: e.toString(),
      );
    }
  }
}
