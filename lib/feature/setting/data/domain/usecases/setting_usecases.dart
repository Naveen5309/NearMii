import 'package:NearMii/core/error/failure.dart';
import 'package:NearMii/core/utils/dartz/either.dart';
import 'package:NearMii/feature/setting/data/repossitories/setting_repo.dart';

abstract class SettingUsecases {
  Future<Either<Failure, dynamic>> callContactUs(
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
}
