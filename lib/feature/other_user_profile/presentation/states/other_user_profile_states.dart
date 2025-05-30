import 'package:NearMii/config/enums.dart';
import 'package:NearMii/feature/common_widgets/custom_report_tile.dart';
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
  final OtherUserType otherUserType;

  const OtherUserProfileApiLoading({
    required this.otherUserType,
  });

  @override
  List<Object> get props => [otherUserType];
}

class OtherUserProfileApiSuccess extends OtherUserProfileStates {
  final OtherUserType otherUserType;
  final List<CustomReportTile> reasons;

  const OtherUserProfileApiSuccess({
    this.reasons = const [],
    required this.otherUserType,
  });

  @override
  List<Object> get props => [otherUserType];
}

class OtherUserProfileApiFailed extends OtherUserProfileStates {
  final String error;
  final OtherUserType otherUserType;

  const OtherUserProfileApiFailed({
    required this.error,
    required this.otherUserType,
  });

  @override
  List<Object> get props => [error, otherUserType];
}
