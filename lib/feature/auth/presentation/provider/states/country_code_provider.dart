// Define a StateNotifierProvider for SignupNotifier
import 'package:NearMii/feature/auth/presentation/provider/state_notifiers/country_code_notifier.dart';
import 'package:NearMii/feature/auth/presentation/provider/states/country_code_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final countryPickerProvider = StateNotifierProvider.autoDispose<
    CountryPickerNotifier, CountryPickerState>((ref) {
  return CountryPickerNotifier();
});
