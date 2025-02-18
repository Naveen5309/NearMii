import 'package:NearMii/core/error/failure.dart';
import 'package:NearMii/core/utils/dartz/either.dart';
import 'package:NearMii/feature/auth/data/models/get_platform_model.dart';
import 'package:NearMii/feature/other_user_profile/data/data_source/other_profile_data_source.dart';
import 'package:NearMii/feature/other_user_profile/other_user_profile_model.dart';

abstract class OtherUserProfileRepository {
  Future<Either<Failure, OtherUserProfileModel>> otherUserProfile(
      {required Map<String, dynamic> body});

  Future<Either<Failure, PlatformData>> getPlatform(
      {required Map<String, dynamic> body});
}

class OtherUserProfileRepoImpl implements OtherUserProfileRepository {
  final OtherUserProfileDataSource dataSource;

  OtherUserProfileRepoImpl({required this.dataSource});

  @override
  Future<Either<Failure, OtherUserProfileModel>> otherUserProfile(
      {required Map<String, dynamic> body}) async {
    try {
      final data = await dataSource.otherUserProfile(body: body);

      if (data?.status == "success") {
        return Right(data?.data);
      } else {
        return Left(ServerFailure(message: data?.message ?? ""));
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PlatformData>> getPlatform(
      {required Map<String, dynamic> body}) async {
    try {
      final response = await dataSource.getPlatformApi();

      if (response == null) {
        return Left(ServerFailure(message: "No response from server"));
      }

      if (response.status == "success" && response.data != null) {
        return Right(response.data!);
      } else {
        return Left(
            ServerFailure(message: response.message ?? "Unknown error"));
      }
    } catch (e) {
      return Left(ServerFailure(message: "Failed to fetch platform data: $e"));
    }
  }
}
