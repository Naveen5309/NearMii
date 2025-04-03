import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/helpers/all_getter.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:NearMii/feature/subscription/domain/usecases/subscription_usecases.dart';
import 'package:NearMii/feature/subscription/presentation/provider/states/subscription_states.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:intl/intl.dart';

class SubscriptionNotifiers extends StateNotifier<SubscriptionStates> {
  final SubscriptionUseCases subscriptionUseCase;

  final InAppPurchase _iap = InAppPurchase.instance;
  SubscriptionNotifiers({required this.subscriptionUseCase})
      : super(SubscriptionInitial()) {
    _initPurchaseListener();
  }
  List<String> ids = [];

  String transactionID = '';

  bool isSubscriptionLoading = false;

  final String _kConsumableId = 'consumable';
  List<ProductDetails> products = [];

  String subscriptionDaysLeft = '';

  /// Initialize purchase listener
  void _initPurchaseListener() {
    _iap.purchaseStream.listen((List<PurchaseDetails> purchases) {
      for (var purchase in purchases) {
        switch (purchase.status) {
          case PurchaseStatus.pending:
            log("Purchase Pending: ${purchase.productID}");
            isSubscriptionLoading = true;
            // state = SubscriptionPending();
            break;

          case PurchaseStatus.purchased:
            log("Purchase Successful: ${purchase.productID}");
            _verifyPurchaseAndCallAPI(purchase);
            break;

          case PurchaseStatus.error:
            log("Subscription Failed: ${purchase.error?.message}");
            state = const SubscriptionApiFailed(error: "Purchase failed");
            break;

          default:
            log("Unhandled Purchase Status: ${purchase.status}");
        }
      }
    }, onError: (error) {
      log("Purchase Error: $error");
      state = SubscriptionApiFailed(error: "Purchase Error: $error");
    });
  }

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  void init() async {
    bool isAvailable = await _iap.isAvailable();
    if (isAvailable) {
      await _getProductDetails();
    }
  }

  /// Verify purchase and call API
  Future<void> _verifyPurchaseAndCallAPI(PurchaseDetails purchase) async {
    bool isValid = await verifyPurchase(purchase);

    if (isValid) {
      log("Purchase Verified Successfully :-> $purchase");
      log("Transaction ID: ${purchase.purchaseID}");
      log("Purchase Date: ${purchase.transactionDate}");
      log("Product ID: ${purchase.productID}");
      log("Status: ${purchase.status}");

      state = SubscriptionApiSuccess(productId: purchase.productID);

      if (Platform.isAndroid) {
        if (purchase is GooglePlayPurchaseDetails) {
          PurchaseWrapper purchaseWrapper = purchase.billingClientPurchase;

          printLog(
              "purchase wrapper is acknowledge :-> ${purchaseWrapper.isAcknowledged}");

          printLog(
              "purchase wrapper is acknowledge :-> ${purchaseWrapper.originalJson}");

          if (transactionID != purchaseWrapper.purchaseToken) {
            addSubscription(
              paymentToken: purchaseWrapper.purchaseToken,
              orderID: purchase.purchaseID!,
            );
          }
        }
      }
    } else {
      log("Purchase Verification Failed");
      state =
          const SubscriptionApiFailed(error: "Purchase verification failed");
    }
  }

  /// Simulate backend verification
  Future<bool> verifyPurchase(PurchaseDetails purchase) async {
    _iap.completePurchase(purchase);
    return true; // Assume valid for now
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

  /// Complete all pending purchases
  Future<void> completeAllPendingPurchases() async {
    // Restore past purchases
    await _iap.restorePurchases();

    // Listen for restored purchases
    _iap.purchaseStream.listen((List<PurchaseDetails> purchases) async {
      for (var purchase in purchases) {
        if (purchase.status == PurchaseStatus.pending) {
          log("Completing pending purchase: ${purchase.productID}");
          await _iap.completePurchase(purchase);
        }
      }
    });
  }

  //Report
  Future<void> addSubscription({
    required String paymentToken,
    required String orderID,
  }) async {
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
        "endDate": DateFormat('yyyy-MM-dd').format(
          DateTime.now().copyWith(month: DateTime.now().month + 1),
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

        return const SubscriptionApiSuccess(productId: '');
      });
    } catch (e) {
      state = SubscriptionApiFailed(
        error: e.toString(),
      );
    }
  }
}
