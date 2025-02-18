import 'package:NearMii/feature/auth/presentation/provider/states/auth_states.dart';
import 'package:NearMii/feature/other_user_profile/data/data_source/other_profile_data_source.dart';
import 'package:NearMii/feature/other_user_profile/data/domain/other_user_profile_usecases.dart';
import 'package:NearMii/feature/other_user_profile/data/repository/other_user_profile_repository.dart';
import 'package:NearMii/feature/other_user_profile/presentation/states/other_user_profile_states.dart';
import 'package:NearMii/feature/other_user_profile/presentation/states_notifier/other_user_profile_notifier.dart';
import 'package:NearMii/feature/setting/data/data_source/setting_data_source.dart';
import 'package:NearMii/feature/setting/data/domain/usecases/setting_usecases.dart';
import 'package:NearMii/feature/setting/data/repossitories/setting_repo.dart';
import 'package:NearMii/feature/setting/presentation/provider/state_notifier/setting_notifier.dart';
import 'package:NearMii/feature/setting/presentation/provider/states/setting_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define a Provider for AuthDataSource
final otherUserProfileDataProvider =
    Provider.autoDispose<OtherUserProfileDataSource>(
        (ref) => OtherUserProfileDataSourceImpl());

// Define a Provider for AuthRepository
final otherUserProfileRepoProvider =
    Provider.autoDispose<OtherUserProfileRepository>((ref) {
  final dataSource = ref.watch(otherUserProfileDataProvider);
  return OtherUserProfileRepoImpl(dataSource: dataSource);
});

// Define a Provider for AuthUseCase
final otherUserProfileUseCaseProvider =
    Provider.autoDispose<OtherUserProfileUsecases>((ref) {
  final repository = ref.watch(otherUserProfileRepoProvider);
  return OtherUserProfileUseCaseImpl(repository: repository);
});

// Define a StateNotifierProvider for SignupNotifier
final otherUserProfile = StateNotifierProvider.autoDispose<
    OtherUserProfileNotifier, OtherUserProfileStates>((ref) {
  final otherUserProfileUseCase = ref.watch(otherUserProfileUseCaseProvider);
  return OtherUserProfileNotifier(
      otherUserProfileUsecases: otherUserProfileUseCase);
});
