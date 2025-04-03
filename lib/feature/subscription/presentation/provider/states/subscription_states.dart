import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

///****** Subscription States *******************
@immutable
sealed class SubscriptionStates extends Equatable {
  const SubscriptionStates();
}

class SubscriptionInitial extends SubscriptionStates {
  @override
  List<Object> get props => [];
}

class SubscriptionApiLoading extends SubscriptionStates {
  const SubscriptionApiLoading();

  @override
  List<Object> get props => [];
}

class SubscriptionApiSuccess extends SubscriptionStates {
  final String productId;
  const SubscriptionApiSuccess({required this.productId});
  @override
  List<Object> get props => [productId];
}

class SubscriptionApiFailed extends SubscriptionStates {
  final String error;

  const SubscriptionApiFailed({
    required this.error,
  });

  @override
  List<Object> get props => [
        error,
      ];
}
