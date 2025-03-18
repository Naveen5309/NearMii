import 'package:NearMii/feature/setting/data/data_source/setting_data_source.dart';
import 'package:NearMii/feature/setting/data/domain/usecases/setting_usecases.dart';
import 'package:NearMii/feature/setting/data/repossitories/setting_repo.dart';
import 'package:NearMii/feature/setting/presentation/provider/state_notifier/setting_notifier.dart';
import 'package:NearMii/feature/setting/presentation/provider/states/setting_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define a Provider for AuthDataSource
final settingDataProvider =
    Provider.autoDispose<SettingDataSource>((ref) => SettingDataSourceImpl());

// Define a Provider for AuthRepository
final settingRepoProvider = Provider.autoDispose<SettingRepository>((ref) {
  final dataSource = ref.watch(settingDataProvider);
  return SettingRepoImpl(dataSource: dataSource);
});

// Define a Provider for AuthUseCase
final settingUseCaseProvider = Provider.autoDispose<SettingUsecases>((ref) {
  final repository = ref.watch(settingRepoProvider);
  return SettingUseCaseImpl(repository: repository);
});

// Define a StateNotifierProvider for SignupNotifier
final contactUsProvider =
    StateNotifierProvider.autoDispose<SettingNotifier, SettingStates>((ref) {
  final settingUseCase = ref.watch(settingUseCaseProvider);
  return SettingNotifier(settingUseCase: settingUseCase);
});
