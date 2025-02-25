import 'package:NearMii/config/countries.dart';
import 'package:NearMii/feature/auth/presentation/provider/states/country_code_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CountryPickerNotifier extends StateNotifier<CountryPickerState> {
  final searchController = TextEditingController();

  CountryPickerNotifier() : super(CountryPickerInitial()) {
    getCountries();
  }

  Future<void> getCountries() async {
    state = const CountryPickerLoading();
    if (searchController.text.isNotEmpty) {
      var list = _searchCountryByName(searchController.text);
      state = CountryPickerLoaded(countryList: list);
    } else {
      state = const CountryPickerLoaded(countryList: allCountries);
    }
  }

  List<Country> _searchCountryByName(String query) {
    return allCountries.where((country) {
      return country.name!.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
