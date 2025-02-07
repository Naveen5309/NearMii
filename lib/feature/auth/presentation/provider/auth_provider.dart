import 'package:NearMii/feature/auth/presentation/provider/login_provider.dart';
import 'package:NearMii/feature/auth/presentation/provider/state_notifiers/signup_notifiers.dart';
import 'package:NearMii/feature/auth/presentation/provider/states/auth_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define a StateNotifierProvider for LoginNotifier
final signupProvider =
    StateNotifierProvider.autoDispose<SignupNotifiers, AuthState>((ref) {
  final authUseCase = ref.watch(authUseCaseProvider);
  return SignupNotifiers(authUseCase: authUseCase);
});
