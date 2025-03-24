import 'package:NearMii/core/error/failure.dart';
import 'package:NearMii/core/utils/dartz/either.dart';
import 'package:NearMii/feature/setting/data/model/profile_model.dart';
import 'package:NearMii/feature/setting/data/repossitories/setting_repo.dart';

abstract class SettingUsecases {
  Future<Either<Failure, dynamic>> callContactUs(
      {required Map<String, dynamic> body});
  Future<Either<Failure, dynamic>> callDeleteAccount(
      {required Map<String, dynamic> body});

  Future<Either<Failure, dynamic>> verifyDeleteAccount(
      {required Map<String, dynamic> body});

  Future<Either<Failure, dynamic>> callRadius(
      {required Map<String, dynamic> body});

  Future<Either<Failure, dynamic>> callProfile(
      {required Map<String, dynamic> body});

  Future<Either<Failure, UserProfileModel>> callGetProfile(
      {required Map<String, dynamic> body});
}

class SettingUseCaseImpl implements SettingUsecases {
  final SettingRepository repository;

  SettingUseCaseImpl({required this.repository});

  @override
  Future<Either<Failure, dynamic>> callContactUs(
      {required Map<String, dynamic> body}) async {
    final result = await repository.contactUs(body: body);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }

  @override
  Future<Either<Failure, dynamic>> callDeleteAccount(
      {required Map<String, dynamic> body}) async {
    final result = await repository.isdeleteAccount(body: body);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }

//VERIFY DELETE ACCOUNT
  @override
  Future<Either<Failure, dynamic>> verifyDeleteAccount(
      {required Map<String, dynamic> body}) async {
    final result = await repository.verifyDeleteAccount(body: body);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }

  @override
  Future<Either<Failure, dynamic>> callRadius(
      {required Map<String, dynamic> body}) async {
    final result = await repository.isRadius(body: body);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }

  @override
  Future<Either<Failure, dynamic>> callProfile(
      {required Map<String, dynamic> body}) async {
    final result = await repository.isProfileSummary(body: body);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }

  @override
  Future<Either<Failure, UserProfileModel>> callGetProfile(
      {required Map<String, dynamic> body}) async {
    final result = await repository.isProfileGet(body: body);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
