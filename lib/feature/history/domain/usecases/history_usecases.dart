import 'package:NearMii/core/error/failure.dart';
import 'package:NearMii/core/utils/dartz/either.dart';
import 'package:NearMii/feature/history/data/repository/history_repository.dart';

abstract class HistoryUsecases {
  Future<Either<Failure, dynamic>> callHistory(
      {required Map<String, dynamic> body});
}

class HistoryUseCaseImpl implements HistoryUsecases {
  final HistoryRepository repository;

  HistoryUseCaseImpl({required this.repository});

  @override
  Future<Either<Failure, dynamic>> callHistory(
      {required Map<String, dynamic> body}) async {
    final result = await repository.isHistory(body: body);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
