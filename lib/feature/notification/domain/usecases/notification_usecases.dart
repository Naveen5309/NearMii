import 'package:NearMii/core/error/failure.dart';
import 'package:NearMii/core/utils/dartz/either.dart';
import 'package:NearMii/feature/notification/data/repository/notification_repository.dart';

abstract class NotificationUsecases {
  Future<Either<Failure, dynamic>> callNotification(
      {required Map<String, dynamic> body});
}

class NotificationUseCaseImpl implements NotificationUsecases {
  final NotificationRepository repository;

  NotificationUseCaseImpl({required this.repository});

  @override
  Future<Either<Failure, dynamic>> callNotification(
      {required Map<String, dynamic> body}) async {
    final result = await repository.isNotification(body: body);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
