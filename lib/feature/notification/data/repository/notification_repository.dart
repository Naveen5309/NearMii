import 'package:NearMii/core/error/failure.dart';
import 'package:NearMii/core/utils/dartz/either.dart';
import 'package:NearMii/feature/history/data/model/history_model.dart';
import 'package:NearMii/feature/notification/data/data_source/notification_data_source.dart';

abstract class NotificationRepository {
  Future<Either<Failure, List<HistoryModel>?>> isNotification(
      {required Map<String, dynamic> body});
}

class NotificationRepoImpl implements NotificationRepository {
  final NotificationDataSource dataSource;

  NotificationRepoImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<HistoryModel>?>> isNotification(
      {required Map<String, dynamic> body}) async {
    try {
      final data = await dataSource.notification(body: body);

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
