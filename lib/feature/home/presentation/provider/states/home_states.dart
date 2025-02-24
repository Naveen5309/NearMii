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
  const HomeApiLoading();

  @override
  List<Object> get props => [];
}

class HomeApiSuccess extends HomeState {
  final LocationType locationType;

  const HomeApiSuccess({required this.locationType});

  @override
  List<Object> get props => [locationType];
}

class HomeApiFailed extends HomeState {
  final String error;
  final LocationType locationType;

  const HomeApiFailed({
    required this.error,
    required this.locationType,
  });

  @override
  List<Object> get props => [error, locationType];
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
