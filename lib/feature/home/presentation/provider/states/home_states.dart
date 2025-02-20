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
  @override
  List<Object> get props => [];
}

class HomeApiSuccess extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeApiFailed extends HomeState {
  final String error;

  const HomeApiFailed({
    required this.error,
  });

  @override
  List<Object> get props => [error];
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
