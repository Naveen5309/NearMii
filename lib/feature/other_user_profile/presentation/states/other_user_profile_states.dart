import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

///****** Other user Profile States *******************
@immutable
sealed class OtherUserProfileStates extends Equatable {
  const OtherUserProfileStates();
}

class OtherUserProfileInitial extends OtherUserProfileStates {
  @override
  List<Object> get props => [];
}

class OtherUserProfileApiLoading extends OtherUserProfileStates {
  const OtherUserProfileApiLoading();

  @override
  List<Object> get props => [];
}

class OtherUserProfileApiSuccess extends OtherUserProfileStates {
  const OtherUserProfileApiSuccess();

  @override
  List<Object> get props => [];
}

class OtherUserProfileApiFailed extends OtherUserProfileStates {
  final String error;

  const OtherUserProfileApiFailed({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
