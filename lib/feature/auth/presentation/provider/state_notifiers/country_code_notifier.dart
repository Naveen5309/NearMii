import 'package:NearMii/config/countries.dart';
import 'package:NearMii/feature/auth/presentation/provider/states/country_code_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CountryPickerNotifier extends StateNotifier<CountryPickerState> {
  final searchController = TextEditingController();
  Country country = const Country(
    name: "United States",
    flag: "🇺🇸",
    code: "US",
    dialCode: "+1",
    minLength: 10,
    maxLength: 10,
  );

  void makeInitialCountry(Country country) {
    this.country = country;
    state = const CountryPickerLoading();
  }

  void updateInitialCountry(String code) {
    print("updateInitialCountry====>>>>  $code");

    final myCountry = (code == "+1")
        ? const Country(
            name: "United States",
            flag: "🇺🇸",
            code: "US",
            dialCode: "+1",
            minLength: 10,
            maxLength: 10,
          )
        : allCountries.firstWhere(
            (element) => element.dialCode == code,
            orElse: () => country, // Use the default country if no match found
          );
    country = myCountry;
    state = const CountryPickerLoading();
    // final myCountry = allCountries.firstWhere(
    //     (element) => element.dialCode == code,
    //     orElse: () => country);
    // country = myCountry;
    // state = const CountryPickerLoading();
  }

  CountryPickerNotifier() : super(CountryPickerInitial());

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
