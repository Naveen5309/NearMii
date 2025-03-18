import 'package:NearMii/core/error/failure.dart';
import 'package:NearMii/core/utils/dartz/either.dart';
import 'package:NearMii/feature/setting/data/data_source/setting_data_source.dart';
import 'package:NearMii/feature/setting/data/model/profile_model.dart';

abstract class SettingRepository {
  Future<Either<Failure, dynamic>> contactUs(
      {required Map<String, dynamic> body});

  Future<Either<Failure, dynamic>> isdeleteAccount(
      {required Map<String, dynamic> body});

  Future<Either<Failure, dynamic>> isRadius(
      {required Map<String, dynamic> body});

  Future<Either<Failure, dynamic>> isProfileSummary(
      {required Map<String, dynamic> body});

  Future<Either<Failure, UserProfileModel>> isProfileGet(
      {required Map<String, dynamic> body});
}

class SettingRepoImpl implements SettingRepository {
  final SettingDataSource dataSource;

  SettingRepoImpl({required this.dataSource});

  @override
  Future<Either<Failure, dynamic>> contactUs(
      {required Map<String, dynamic> body}) async {
    try {
      final data = await dataSource.contactUS(body: body);

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
  Future<Either<Failure, dynamic>> isdeleteAccount(
      {required Map<String, dynamic> body}) async {
    try {
      final data = await dataSource.deleteAccount(body: body);

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
  Future<Either<Failure, dynamic>> isRadius(
      {required Map<String, dynamic> body}) async {
    try {
      final data = await dataSource.radius(body: body);

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
  Future<Either<Failure, dynamic>> isProfileSummary(
      {required Map<String, dynamic> body}) async {
    try {
      final data = await dataSource.profileSummary(body: body);

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
  Future<Either<Failure, UserProfileModel>> isProfileGet(
      {required Map<String, dynamic> body}) async {
    try {
      final data = await dataSource.getProfile(body: body);

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
