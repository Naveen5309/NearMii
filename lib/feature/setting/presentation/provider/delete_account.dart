import 'package:NearMii/feature/auth/data/data_source/auth_data_source.dart';
import 'package:NearMii/feature/auth/data/repositories/auth_repo_implementation.dart';
import 'package:NearMii/feature/auth/domain/usecases/get_auth.dart';
import 'package:NearMii/feature/auth/presentation/provider/states/auth_states.dart';
import 'package:NearMii/feature/setting/presentation/provider/state_notifier/setting_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define a Provider for AuthDataSource
final authDataProvider =
    Provider.autoDispose<AuthDataSource>((ref) => AuthDataSourceImpl());

// Define a Provider for AuthRepository
final authRepoProvider = Provider.autoDispose<AuthRepository>((ref) {
  final dataSource = ref.watch(authDataProvider);
  return AuthRepoImpl(dataSource: dataSource);
});

// Define a Provider for AuthUseCase
final authUseCaseProvider = Provider.autoDispose<AuthUseCase>((ref) {
  final repository = ref.watch(authRepoProvider);
  return AuthUseCaseImpl(repository: repository);
});

// Define a StateNotifierProvider for SignupNotifier
final deleteAccountProvider =
    StateNotifierProvider.autoDispose<SettingNotifier, AuthState>((ref) {
  final authUseCase = ref.watch(authUseCaseProvider);
  return SettingNotifier(authUseCase: authUseCase);
});

final isCurrentPasswordVisible =
    StateProvider.autoDispose<bool>((ref) => false, name: "currentPassword");
