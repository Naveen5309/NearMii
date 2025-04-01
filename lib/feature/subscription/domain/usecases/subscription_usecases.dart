import 'package:NearMii/core/error/failure.dart';
import 'package:NearMii/core/utils/dartz/either.dart';
import 'package:NearMii/feature/subscription/data/repository/subscription_repo.dart';

abstract class SubscriptionUseCases {
  Future<Either<Failure, dynamic>> addSubscription(
      {required Map<String, dynamic> body});
}

class SubscriptionUseCaseImpl implements SubscriptionUseCases {
  final SubscriptionRepository repository;

  SubscriptionUseCaseImpl({required this.repository});

  @override
  Future<Either<Failure, dynamic>> addSubscription(
      {required Map<String, dynamic> body}) async {
    final result = await repository.addSubscription(body: body);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
