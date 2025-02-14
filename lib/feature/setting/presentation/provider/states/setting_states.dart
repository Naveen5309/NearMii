import 'package:NearMii/config/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

///****** Setting States *******************
@immutable
sealed class SettingStates extends Equatable {
  const SettingStates();
}

class SettingInitial extends SettingStates {
  @override
  List<Object> get props => [];
}

class SettingApiLoading extends SettingStates {
  final Setting settingType;

  const SettingApiLoading({
    required this.settingType,
  });

  @override
  List<Object> get props => [settingType];
}

class SettingApiSuccess extends SettingStates {
  final Setting settingType;
  const SettingApiSuccess({
    required this.settingType,
  });
  @override
  List<Object> get props => [settingType];
}

class SettingApiFailed extends SettingStates {
  final String error;
  final Setting settingType;

  const SettingApiFailed({required this.error, required this.settingType});

  @override
  List<Object> get props => [error, settingType];
}
