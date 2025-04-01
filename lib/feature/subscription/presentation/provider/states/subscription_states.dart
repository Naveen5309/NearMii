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
  const SubscriptionApiSuccess();
  @override
  List<Object> get props => [];
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
