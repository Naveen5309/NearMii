import 'package:NearMii/core/error/failure.dart';
import 'package:NearMii/core/utils/dartz/either.dart';
import 'package:NearMii/feature/self_user_profile/data/repository/self_user_profile_repository.dart';

abstract class SelfUserProfileUsecases {
  Future<Either<Failure, dynamic>> callUpdateSocialProfile(
      {required Map<String, dynamic> body});
  Future<Either<Failure, dynamic>> callHideAllLinks(
      {required Map<String, dynamic> body});
  Future<Either<Failure, dynamic>> callGetSelfPlatform(
      {required Map<String, dynamic> body});
}

class SelfUserProfileUseCaseImpl implements SelfUserProfileUsecases {
  final SelfUserProfileRepository repository;

  SelfUserProfileUseCaseImpl({required this.repository});

  @override
  Future<Either<Failure, dynamic>> callUpdateSocialProfile(
      {required Map<String, dynamic> body}) async {
    final result = await repository.isUpdateSocialLink(body: body);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }

  @override
  Future<Either<Failure, dynamic>> callHideAllLinks(
      {required Map<String, dynamic> body}) async {
    final result = await repository.isUpdateSocialLink(body: body);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }

  @override
  Future<Either<Failure, dynamic>> callGetSelfPlatform(
      {required Map<String, dynamic> body}) async {
    final result = await repository.isUpdateSocialLink(body: body);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
