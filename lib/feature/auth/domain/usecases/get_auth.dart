import 'package:NearMii/feature/auth/data/models/get_platform_model.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/utils/dartz/either.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repo_implementation.dart';

abstract class AuthUseCase {
  Future<Either<Failure, UserModel?>> callLogin({
    required Map<String, dynamic> body,
    required bool isSocial,
  });

  Future<Either<Failure, dynamic>> forgotPassword(
      {required Map<String, dynamic> body});

  Future<Either<Failure, dynamic>> otpVerify(
      {required Map<String, dynamic> body});

  Future<Either<Failure, dynamic>> resetPassword(
      {required Map<String, dynamic> body});

  Future<Either<Failure, GetPlatformData>> getPlatform();

  Future<Either<Failure, dynamic>> logOut();
}

class AuthUseCaseImpl implements AuthUseCase {
  final AuthRepository repository;

  AuthUseCaseImpl({required this.repository});

  @override
  Future<Either<Failure, UserModel?>> callLogin({
    required Map<String, dynamic> body,
    required bool isSocial,
  }) async {
    final result = await repository.doLogin(body: body, isSocial: isSocial);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }

  @override
  Future<Either<Failure, dynamic>> forgotPassword(
      {required Map<String, dynamic> body}) async {
    final result = await repository.forgotPassword(body: body);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }

  @override
  Future<Either<Failure, dynamic>> otpVerify(
      {required Map<String, dynamic> body}) async {
    final result = await repository.otpVerify(body: body);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }

  @override
  Future<Either<Failure, dynamic>> resetPassword(
      {required Map<String, dynamic> body}) async {
    final result = await repository.resetPassword(body: body);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }

  @override
  Future<Either<Failure, GetPlatformData>> getPlatform() async {
    final result = await repository.getPlatform();
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }

//LOGOUT
  @override
  Future<Either<Failure, dynamic>> logOut() async {
    final result = await repository.logOut();
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
