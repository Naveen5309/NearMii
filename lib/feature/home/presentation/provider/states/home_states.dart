import 'package:NearMii/config/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

///****** Login States *******************
@immutable
sealed class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeApiLoading extends HomeState {
  final HomeType homeType;
  const HomeApiLoading({required this.homeType});

  @override
  List<Object> get props => [homeType];
}

class HomeApiSuccess extends HomeState {
  final HomeType homeType;

  const HomeApiSuccess({required this.homeType});

  @override
  List<Object> get props => [homeType];
}

class HomeApiFailed extends HomeState {
  final String error;
  final HomeType homeType;

  const HomeApiFailed({
    required this.error,
    required this.homeType,
  });

  @override
  List<Object> get props => [error, homeType];
}

class UpdateLocation extends HomeState {
  final LocationType locationType;
  const UpdateLocation({
    required this.locationType,
  });
  @override
  List<Object> get props => [locationType];
}

class UpdateLocation2 extends HomeState {
  @override
  List<Object> get props => [];
}
