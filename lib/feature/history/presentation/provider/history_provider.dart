import 'package:NearMii/feature/history/data/data_source/history_data_source.dart';
import 'package:NearMii/feature/history/data/repository/history_repository.dart';
import 'package:NearMii/feature/history/domain/usecases/history_usecases.dart';
import 'package:NearMii/feature/history/presentation/provider/state_notifier/history_notifier.dart';
import 'package:NearMii/feature/history/presentation/provider/states/history_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define a Provider for HistoryDataSource
final historyDataProvider =
    Provider.autoDispose<HistoryDataSource>((ref) => HistoryDataSourceImpl());

// Define a Provider for HistoryRepository
final historyRepoProvider = Provider.autoDispose<HistoryRepository>((ref) {
  final dataSource = ref.watch(historyDataProvider);
  return HistoryRepoImpl(dataSource: dataSource);
});

// Define a Provider for HistoryUseCase
final historyUseCaseProvider = Provider.autoDispose<HistoryUsecases>((ref) {
  final repository = ref.watch(historyRepoProvider);
  return HistoryUseCaseImpl(repository: repository);
});

// Define a StateNotifierProvider for HistoryNotifier
final historyProvider =
    StateNotifierProvider.autoDispose<HistoryNotifier, HistoryState>((ref) {
  final historyUseCase = ref.watch(historyUseCaseProvider);
  return HistoryNotifier(historyUsecases: historyUseCase);
});
