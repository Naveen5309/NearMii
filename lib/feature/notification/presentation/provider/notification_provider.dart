import 'package:NearMii/feature/history/data/data_source/history_data_source.dart';
import 'package:NearMii/feature/history/data/repository/history_repository.dart';
import 'package:NearMii/feature/history/domain/usecases/history_usecases.dart';
import 'package:NearMii/feature/history/presentation/provider/state_notifier/history_notifier.dart';
import 'package:NearMii/feature/history/presentation/provider/states/history_state.dart';
import 'package:NearMii/feature/notification/data/data_source/notification_data_source.dart';
import 'package:NearMii/feature/notification/data/repository/notification_repository.dart';
import 'package:NearMii/feature/notification/domain/usecases/notification_usecases.dart';
import 'package:NearMii/feature/notification/presentation/provider/state/notification_state.dart';
import 'package:NearMii/feature/notification/presentation/provider/state_notifier/notification_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define a Provider for HistoryDataSource
final notificationDataProvider = Provider.autoDispose<NotificationDataSource>(
    (ref) => NotificationDataSourceImpl());

// Define a Provider for HistoryRepository
final notificationRepoProvider =
    Provider.autoDispose<NotificationRepository>((ref) {
  final dataSource = ref.watch(notificationDataProvider);
  return NotificationRepoImpl(dataSource: dataSource);
});

// Define a Provider for HistoryUseCase
final notificationUseCaseProvider =
    Provider.autoDispose<NotificationUsecases>((ref) {
  final repository = ref.watch(notificationRepoProvider);
  return NotificationUseCaseImpl(repository: repository);
});

// Define a StateNotifierProvider for HistoryNotifier
final notificationProvider =
    StateNotifierProvider.autoDispose<NotificationNotifier, NotificationState>(
        (ref) {
  final notificationUseCase = ref.watch(notificationUseCaseProvider);
  return NotificationNotifier(notificationUsecases: notificationUseCase);
});
