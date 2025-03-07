import 'package:NearMii/feature/auth/data/models/add_platform_response_model.dart';
import 'package:NearMii/feature/auth/data/models/complete_profile_response_model.dart';
import 'package:NearMii/feature/auth/data/models/edit_profile_model.dart';
import 'package:NearMii/feature/auth/data/models/get_platform_model.dart';
import 'package:NearMii/feature/auth/data/models/new_get_platform_model.dart';
import 'package:NearMii/feature/auth/data/models/user_register_response_model.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/utils/dartz/either.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repo_implementation.dart';

abstract class AuthUseCase {
  Future<Either<Failure, UserModel?>> callLogin({
    required Map<String, dynamic> body,
    required bool isSocial,
  });

  Future<Either<Failure, UserRegisterData?>> signUp({
    required Map<String, dynamic> body,
  });

  Future<Either<Failure, dynamic>> forgotPassword(
      {required Map<String, dynamic> body});

  Future<Either<Failure, AddPlatformData>> addPlatformApi(
      {required Map<String, dynamic> body});

  Future<Either<Failure, CompleteProfileData>> completeProfile(
      {required Map<String, dynamic> body, required String imagePath});

  Future<Either<Failure, dynamic>> otpVerify(
      {required Map<String, dynamic> body});

  Future<Either<Failure, dynamic>> resetPassword(
      {required Map<String, dynamic> body});

  Future<Either<Failure, dynamic>> getPlatform(
      {required Map<String, dynamic> body});

  Future<Either<Failure, dynamic>> logOut();

  Future<Either<Failure, dynamic>> changePassword(
      {required Map<String, dynamic> body});

  Future<Either<Failure, EditProfileModel>> editProfile(
      {required Map<String, dynamic> body, required String imagePath});
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

//SIGN UP
  @override
  Future<Either<Failure, UserRegisterData?>> signUp({
    required Map<String, dynamic> body,
  }) async {
    final result = await repository.signUp(body: body);
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
  Future<Either<Failure, AddPlatformData>> addPlatformApi(
      {required Map<String, dynamic> body}) async {
    final result = await repository.addPlatform(body: body);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }

  @override
  Future<Either<Failure, CompleteProfileData>> completeProfile(
      {required Map<String, dynamic> body, required String imagePath}) async {
    final result =
        await repository.completeProfile(body: body, imagePath: imagePath);
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
  Future<Either<Failure, List<PlatformCatagory>>> getPlatform(
      {required Map<String, dynamic> body}) async {
    final result = await repository.getPlatform(body: body);
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

  @override
  Future<Either<Failure, dynamic>> changePassword(
      {required Map<String, dynamic> body}) async {
    final result = await repository.changePassword(body: body);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }

  @override
  Future<Either<Failure, EditProfileModel>> editProfile(
      {required Map<String, dynamic> body, required String imagePath}) async {
    final result =
        await repository.editProfile(body: body, imagePath: imagePath);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
