import 'package:NearMii/core/error/failure.dart';
import 'package:NearMii/core/utils/dartz/either.dart';
import 'package:NearMii/feature/auth/data/models/get_my_platform_model.dart';
import 'package:NearMii/feature/auth/data/models/new_other_user_social_platform.dart';
import 'package:NearMii/feature/other_user_profile/data/repository/other_user_profile_repository.dart';
import 'package:NearMii/feature/other_user_profile/data/model/other_user_profile_model.dart';

abstract class OtherUserProfileUsecases {
  Future<Either<Failure, OtherUserProfileModel>> callOtherUserProfile(
      {required Map<String, dynamic> body});

  Future<Either<Failure, List<SelfPlatformCatagoryData>>> getOtherPlatformApi(
      {required Map<String, dynamic> body});
  Future<Either<Failure, dynamic>> callReport(
      {required Map<String, dynamic> body});
}

class OtherUserProfileUseCaseImpl implements OtherUserProfileUsecases {
  final OtherUserProfileRepository repository;

  OtherUserProfileUseCaseImpl({required this.repository});

  @override
  Future<Either<Failure, OtherUserProfileModel>> callOtherUserProfile(
      {required Map<String, dynamic> body}) async {
    final result = await repository.otherUserProfile(body: body);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }

  @override
  Future<Either<Failure, List<SelfPlatformCatagoryData>>> getOtherPlatformApi(
      {required Map<String, dynamic> body}) async {
    final result = await repository.getOtherPlatformApi(body: body);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }

  @override
  Future<Either<Failure, dynamic>> callReport(
      {required Map<String, dynamic> body}) async {
    final result = await repository.report(body: body);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
