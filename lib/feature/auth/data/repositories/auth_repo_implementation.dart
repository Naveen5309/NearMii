import 'dart:developer';

import 'package:NearMii/feature/auth/data/models/get_platform_model.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/utils/dartz/either.dart';
import '../data_source/auth_data_source.dart';
import '../models/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel?>> doLogin(
      {required Map<String, dynamic> body});
  Future<Either<Failure, GetPlatformData>> getPlatform();
}

class AuthRepoImpl implements AuthRepository {
  final AuthDataSource dataSource;

  AuthRepoImpl({required this.dataSource});

  @override
  Future<Either<Failure, UserModel?>> doLogin(
      {required Map<String, dynamic> body}) async {
    try {
      final data = await dataSource.logInUser(body: body);

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
  Future<Either<Failure, GetPlatformData>> getPlatform() async {
    try {
      final data = await dataSource.getPlatformApi();
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
