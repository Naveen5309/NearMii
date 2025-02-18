import 'package:NearMii/core/error/failure.dart';
import 'package:NearMii/core/utils/dartz/either.dart';
import 'package:NearMii/feature/history/data/data_source/history_data_source.dart';
import 'package:NearMii/feature/history/data/model/history_model.dart';

abstract class HistoryRepository {
  Future<Either<Failure, List<HistoryModel>?>> isHistory(
      {required Map<String, dynamic> body});
}

class HistoryRepoImpl implements HistoryRepository {
  final HistoryDataSource dataSource;

  HistoryRepoImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<HistoryModel>?>> isHistory(
      {required Map<String, dynamic> body}) async {
    try {
      final data = await dataSource.history(body: body);

      if (data?.status == "success") {
        return Right(data?.data);
      } else {
        return Left(ServerFailure(message: data?.message ?? ""));
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
