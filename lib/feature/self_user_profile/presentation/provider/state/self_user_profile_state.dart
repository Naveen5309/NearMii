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
  const SelfUserProfileApiLoading();

  @override
  List<Object> get props => [];
}

class SelfUserProfileApiSuccess extends SelfUserProfileState {
  const SelfUserProfileApiSuccess();
  @override
  List<Object> get props => [];
}

class SelfUserProfileApiFailed extends SelfUserProfileState {
  final String error;

  const SelfUserProfileApiFailed({required this.error});

  @override
  List<Object> get props => [error];
}
