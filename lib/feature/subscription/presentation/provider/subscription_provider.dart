// Define a Provider for SubscriptionDataSource
import 'package:NearMii/feature/subscription/data/data_source/subscription_data_source.dart';
import 'package:NearMii/feature/subscription/data/repository/subscription_repo.dart';
import 'package:NearMii/feature/subscription/domain/usecases/subscription_usecases.dart';
import 'package:NearMii/feature/subscription/presentation/provider/state_notifiers/subscription_notifiers.dart';
import 'package:NearMii/feature/subscription/presentation/provider/states/subscription_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final subcriptionDataProvider = Provider.autoDispose<SubscriptionDataSource>(
    (ref) => SubscriptionDataSourceImpl());

// Define a Provider for SubscriptionRepository
final subcriptionRepoProvider =
    Provider.autoDispose<SubscriptionRepository>((ref) {
  final dataSource = ref.watch(subcriptionDataProvider);
  return SubscriptionRepoImpl(dataSource: dataSource);
});

// Define a Provider for SubscriptionUseCase
final subcriptionUseCaseProvider =
    Provider.autoDispose<SubscriptionUseCases>((ref) {
  final repository = ref.watch(subcriptionRepoProvider);
  return SubscriptionUseCaseImpl(repository: repository);
});

// Define a StateNotifierProvider for SubscriptionNotifiers
final subscriptionProvider = StateNotifierProvider.autoDispose<
    SubscriptionNotifiers, SubscriptionStates>((ref) {
  final subcriptionUseCase = ref.watch(subcriptionUseCaseProvider);
  return SubscriptionNotifiers(subscriptionUseCase: subcriptionUseCase);
});
