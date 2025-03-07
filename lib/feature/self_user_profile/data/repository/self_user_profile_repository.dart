import 'package:NearMii/core/error/failure.dart';
import 'package:NearMii/core/utils/dartz/either.dart';
import 'package:NearMii/feature/auth/data/models/get_my_platform_model.dart';
import 'package:NearMii/feature/auth/data/models/new_other_user_social_platform.dart';

import 'package:NearMii/feature/self_user_profile/data/data_source/self_user_profile_data_source.dart';

abstract class SelfUserProfileRepository {
  Future<Either<Failure, dynamic>> isUpdateSocialLink(
      {required Map<String, dynamic> body});
  Future<Either<Failure, dynamic>> isHideAllLinks(
      {required Map<String, dynamic> body});

  Future<Either<Failure, dynamic>> hidePlatform(
      {required Map<String, dynamic> body});
  Future<Either<Failure, List<SelfPlatformCatagoryData>>> isGetSelfPlatform(
      {required Map<String, dynamic> body});
  Future<Either<Failure, dynamic>> isDelete(
      {required Map<String, dynamic> body});
  Future<Either<Failure, dynamic>> isGetSocialProfile(
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
      final data = await dataSource.hideAllLinks(body: body);

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
  Future<Either<Failure, dynamic>> hidePlatform(
      {required Map<String, dynamic> body}) async {
    try {
      final data = await dataSource.hidePlatform(body: body);

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
  Future<Either<Failure, List<SelfPlatformCatagoryData>>> isGetSelfPlatform(
      {required Map<String, dynamic> body}) async {
    try {
      final data = await dataSource.getSelfPlatform(body: body);

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
  Future<Either<Failure, dynamic>> isDelete(
      {required Map<String, dynamic> body}) async {
    try {
      final data = await dataSource.delete(body: body);

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
  Future<Either<Failure, dynamic>> isGetSocialProfile(
      {required Map<String, dynamic> body}) async {
    try {
      final data = await dataSource.getSocialProfile(body: body);

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
