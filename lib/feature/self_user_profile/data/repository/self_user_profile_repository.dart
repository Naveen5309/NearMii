import 'package:NearMii/core/error/failure.dart';
import 'package:NearMii/core/utils/dartz/either.dart';
import 'package:NearMii/feature/self_user_profile/data/data_source/self_user_profile_data_source.dart';

abstract class SelfUserProfileRepository {
  Future<Either<Failure, dynamic>> isUpdateSocialLink(
      {required Map<String, dynamic> body});
  Future<Either<Failure, dynamic>> isHideAllLinks(
      {required Map<String, dynamic> body});
  Future<Either<Failure, dynamic>> isGetSelfPlatform(
      {required Map<String, dynamic> body});
}

class SelfUserProfileRepoImpl implements SelfUserProfileRepository {
  final SelfUserProfileDataSource dataSource;

  SelfUserProfileRepoImpl({required this.dataSource});

  @override
  Future<Either<Failure, dynamic>> isUpdateSocialLink(
      {required Map<String, dynamic> body}) async {
    try {
      final data = await dataSource.updateSocialLink(body: body);

      if (data.status == "success") {
        return Right(data.data);
      } else {
        return Left(ServerFailure(message: data.message ?? ""));
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> isHideAllLinks(
      {required Map<String, dynamic> body}) async {
    try {
      final data = await dataSource.updateSocialLink(body: body);

      if (data.status == "success") {
        return Right(data.data);
      } else {
        return Left(ServerFailure(message: data.message ?? ""));
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> isGetSelfPlatform(
      {required Map<String, dynamic> body}) async {
    try {
      final data = await dataSource.updateSocialLink(body: body);

      if (data.status == "success") {
        return Right(data.data);
      } else {
        return Left(ServerFailure(message: data.message ?? ""));
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
