import 'package:NearMii/feature/other_user_profile/data/data_source/other_profile_data_source.dart';
import 'package:NearMii/feature/other_user_profile/data/domain/other_user_profile_usecases.dart';
import 'package:NearMii/feature/other_user_profile/data/repository/other_user_profile_repository.dart';
import 'package:NearMii/feature/other_user_profile/presentation/states/other_user_profile_states.dart';
import 'package:NearMii/feature/other_user_profile/presentation/states_notifier/other_user_profile_notifier.dart';

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
final reportProvider = StateNotifierProvider.autoDispose<
    OtherUserProfileNotifier, OtherUserProfileStates>((ref) {
  final reportUseCase = ref.watch(otherUserProfileUseCaseProvider);
  return OtherUserProfileNotifier(otherUserProfileUsecases: reportUseCase);
});

final selectedReportIndex =
    StateProvider.autoDispose<int>((ref) => 0, name: "selectedReportIndex");
