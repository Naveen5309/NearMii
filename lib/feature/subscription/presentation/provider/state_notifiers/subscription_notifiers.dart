import 'dart:async';

import 'package:NearMii/feature/subscription/domain/usecases/subscription_usecases.dart';
import 'package:NearMii/feature/subscription/presentation/provider/states/subscription_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class SubscriptionNotifiers extends StateNotifier<SubscriptionStates> {
  final SubscriptionUseCases subscriptionUseCase;

  SubscriptionNotifiers({required this.subscriptionUseCase})
      : super(SubscriptionInitial());

  late StreamSubscription<List<PurchaseDetails>> _subscriptions;
  final InAppPurchase _iap = InAppPurchase.instance;

  initializeSubscription() {
    final Stream purchaseUpdated = InAppPurchase.instance.purchaseStream;
    _subscriptions =
        _iap.purchaseStream.listen((List<PurchaseDetails> purchaseDetailsList) {
      // _listenToPurchaseUpdated(purchaseDetailsList);
    }, onError: (error) {
      // Handle errors from the purchase stream
      print("Error in purchase stream: $error");
    });
  }

//   void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
//   purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
//     if (purchaseDetails.status == PurchaseStatus.pending) {
//       _showPendingUI();
//     } else {
//       if (purchaseDetails.status == PurchaseStatus.error) {
//         _handleError(purchaseDetails.error!);
//       } else if (purchaseDetails.status == PurchaseStatus.purchased ||
//                  purchaseDetails.status == PurchaseStatus.restored) {
//         bool valid = await _verifyPurchase(purchaseDetails);
//         if (valid) {
//           _deliverProduct(purchaseDetails);
//         } else {
//           _handleInvalidPurchase(purchaseDetails);
//         }
//       }
//       if (purchaseDetails.pendingCompletePurchase) {
//         await InAppPurchase.instance
//             .completePurchase(purchaseDetails);
//       }
//     }
//   });
// }
}
