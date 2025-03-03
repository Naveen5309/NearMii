import 'package:NearMii/config/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

///****** SelfUserProfile States *******************
@immutable
sealed class SelfUserProfileState extends Equatable {
  const SelfUserProfileState();
}

class SelfUserProfileInitial extends SelfUserProfileState {
  @override
  List<Object> get props => [];
}

class SelfUserProfileApiLoading extends SelfUserProfileState {
  final SelfProfileDataType selfProfileDataType;
  const SelfUserProfileApiLoading({required this.selfProfileDataType});

  @override
  List<Object> get props => [selfProfileDataType];
}

class SelfUserProfileApiSuccess extends SelfUserProfileState {
  final SelfProfileDataType selfProfileDataType;
  const SelfUserProfileApiSuccess({required this.selfProfileDataType});
  @override
  List<Object> get props => [selfProfileDataType];
}

class SelfUserProfileApiFailed extends SelfUserProfileState {
  final SelfProfileDataType selfProfileDataType;

  final String error;

  const SelfUserProfileApiFailed(
      {required this.error, required this.selfProfileDataType});

  @override
  List<Object> get props => [error, selfProfileDataType];
}
