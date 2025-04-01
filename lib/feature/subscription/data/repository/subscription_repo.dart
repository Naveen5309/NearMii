import 'package:NearMii/core/error/failure.dart';
import 'package:NearMii/core/utils/dartz/either.dart';
import 'package:NearMii/feature/subscription/data/data_source/subscription_data_source.dart';

abstract class SubscriptionRepository {
  Future<Either<Failure, dynamic>> addSubscription(
      {required Map<String, dynamic> body});
}

class SubscriptionRepoImpl implements SubscriptionRepository {
  final SubscriptionDataSource dataSource;

  SubscriptionRepoImpl({required this.dataSource});

  @override
  Future<Either<Failure, dynamic>> addSubscription(
      {required Map<String, dynamic> body}) async {
    try {
      final data = await dataSource.addSubscription(body: body);

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
