import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

///****** Notification States *******************
@immutable
sealed class NotificationState extends Equatable {
  const NotificationState();
}

class NotificationInitial extends NotificationState {
  @override
  List<Object> get props => [];
}

class NotificationApiLoading extends NotificationState {
  const NotificationApiLoading();

  @override
  List<Object> get props => [];
}

class NotificationApiSuccess extends NotificationState {
  const NotificationApiSuccess();
  @override
  List<Object> get props => [];
}

class NotificationApiFailed extends NotificationState {
  final String error;

  const NotificationApiFailed({required this.error});

  @override
  List<Object> get props => [error];
}
