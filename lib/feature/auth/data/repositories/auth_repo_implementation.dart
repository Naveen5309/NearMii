import 'package:NearMii/feature/auth/data/models/add_platform_response_model.dart';
import 'package:NearMii/feature/auth/data/models/complete_profile_response_model.dart';
import 'package:NearMii/feature/auth/data/models/edit_profile_model.dart';
import 'package:NearMii/feature/auth/data/models/new_get_platform_model.dart';
import 'package:NearMii/feature/auth/data/models/user_register_response_model.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/utils/dartz/either.dart';
import '../data_source/auth_data_source.dart';
import '../models/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel?>> doLogin({
    required Map<String, dynamic> body,
    required bool isSocial,
  });

  Future<Either<Failure, UserRegisterData?>> signUp({
    required Map<String, dynamic> body,
  });

  Future<Either<Failure, dynamic>> forgotPassword(
      {required Map<String, dynamic> body});

  Future<Either<Failure, AddPlatformData>> addPlatform(
      {required Map<String, dynamic> body});
  Future<Either<Failure, CompleteProfileData>> completeProfile(
      {required Map<String, dynamic> body, required String imagePath});

  Future<Either<Failure, dynamic>> otpVerify(
      {required Map<String, dynamic> body});
  Future<Either<Failure, dynamic>> resetPassword(
      {required Map<String, dynamic> body});
  Future<Either<Failure, List<PlatformCatagory>>> getPlatform(
      {required Map<String, dynamic> body});
  Future<Either<Failure, dynamic>> logOut();

  Future<Either<Failure, dynamic>> changePassword(
      {required Map<String, dynamic> body});
  Future<Either<Failure, EditProfileModel>> editProfile(
      {required Map<String, dynamic> body, required String imagePath});
}

class AuthRepoImpl implements AuthRepository {
  final AuthDataSource dataSource;

  AuthRepoImpl({required this.dataSource});

  @override
  Future<Either<Failure, UserModel?>> doLogin({
    required Map<String, dynamic> body,
    required bool isSocial,
  }) async {
    try {
      final data = await dataSource.logInUser(body: body, isSocial: isSocial);

      if (data?.status == "success") {
        return Right(data?.data);
      } else {
        return Left(ServerFailure(message: data?.message ?? ""));
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

// ----->>>  SIGN UP   <<<----
  @override
  Future<Either<Failure, UserRegisterData?>> signUp({
    required Map<String, dynamic> body,
  }) async {
    try {
      final data = await dataSource.signUpApi(body: body);

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
  Future<Either<Failure, dynamic>> forgotPassword(
      {required Map<String, dynamic> body}) async {
    try {
      final data = await dataSource.forgotPassword(body: body);

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
  Future<Either<Failure, AddPlatformData>> addPlatform(
      {required Map<String, dynamic> body}) async {
    try {
      final data = await dataSource.addPlatform(body: body);

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
  Future<Either<Failure, CompleteProfileData>> completeProfile(
      {required Map<String, dynamic> body, required String imagePath}) async {
    try {
      final data =
          await dataSource.completeProfile(body: body, imagePath: imagePath);

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
  Future<Either<Failure, dynamic>> otpVerify(
      {required Map<String, dynamic> body}) async {
    try {
      final data = await dataSource.otpVerify(body: body);

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
  Future<Either<Failure, dynamic>> resetPassword(
      {required Map<String, dynamic> body}) async {
    try {
      final data = await dataSource.resetPassword(body: body);

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
  Future<Either<Failure, List<PlatformCatagory>>> getPlatform(
      {required Map<String, dynamic> body}) async {
    try {
      final data = await dataSource.getPlatformApi(body: body);
      if (data?.status == "success") {
        return Right(data?.data);
      } else {
        return Left(ServerFailure(message: data?.message ?? ""));
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

//LOG OUT

  @override
  Future<Either<Failure, dynamic>> logOut() async {
    try {
      final data = await dataSource.logOutApi();
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
  Future<Either<Failure, dynamic>> changePassword(
      {required Map<String, dynamic> body}) async {
    try {
      final data = await dataSource.changePassword(body: body);

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
  Future<Either<Failure, EditProfileModel>> editProfile(
      {required Map<String, dynamic> body, required String imagePath}) async {
    try {
      final data =
          await dataSource.editProfile(body: body, imagePath: imagePath);

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
