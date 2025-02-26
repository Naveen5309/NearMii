import 'package:NearMii/config/countries.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

///****** Login States *******************
@immutable
sealed class CountryPickerState extends Equatable {
  const CountryPickerState();
}

class CountryPickerInitial extends CountryPickerState {
  @override
  List<Object> get props => [];
}

class CountryPickerLoading extends CountryPickerState {
  const CountryPickerLoading();

  @override
  List<Object> get props => [];
}

class CountryPickerLoaded extends CountryPickerState {
  final List<Country> countryList;
  const CountryPickerLoaded({required this.countryList});

  @override
  List<Object> get props => [countryList];
}

class CountryPickerFailed extends CountryPickerState {
  final String error;

  const CountryPickerFailed({
    required this.error,
  });

  @override
  List<Object> get props => [
        error,
      ];
}
