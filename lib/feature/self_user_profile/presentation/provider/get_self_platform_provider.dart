import 'package:NearMii/feature/self_user_profile/data/data_source/self_user_profile_data_source.dart';
import 'package:NearMii/feature/self_user_profile/data/repository/self_user_profile_repository.dart';
import 'package:NearMii/feature/self_user_profile/domain/usecases/self_user_profile_usecases.dart';
import 'package:NearMii/feature/self_user_profile/presentation/provider/state/self_user_profile_state.dart';
import 'package:NearMii/feature/self_user_profile/presentation/provider/state_notifier/self_user_profile_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define a Provider for SelfUserProfileDataSource
final selfUserProfileDataProvider =
    Provider.autoDispose<SelfUserProfileDataSource>(
        (ref) => SelfUserProfileDataSourceImpl());

// Define a Provider for SelfUserProfileRepository
final selfUserProfileRepoProvider =
    Provider.autoDispose<SelfUserProfileRepository>((ref) {
  final dataSource = ref.watch(selfUserProfileDataProvider);
  return SelfUserProfileRepoImpl(dataSource: dataSource);
});

// Define a Provider for SelfUserProfileUseCase
final selfUserProfileUseCaseProvider =
    Provider.autoDispose<SelfUserProfileUsecases>((ref) {
  final repository = ref.watch(selfUserProfileRepoProvider);
  return SelfUserProfileUseCaseImpl(repository: repository);
});

// Define a StateNotifierProvider for SelfUserProfileNotifier
final getSelfPlatformProvider = StateNotifierProvider.autoDispose<
    SelfUserProfileNotifier, SelfUserProfileState>((ref) {
  final selfUserProfileUseCase = ref.watch(selfUserProfileUseCaseProvider);
  return SelfUserProfileNotifier(
      selfUserProfileUsecases: selfUserProfileUseCase);
});
