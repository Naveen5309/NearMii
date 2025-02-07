import 'package:NearMii/feature/auth/data/models/get_platform_model.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/utils/dartz/either.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repo_implementation.dart';

abstract class AuthUseCase {
  Future<Either<Failure, UserModel?>> callLogin(
      {required Map<String, dynamic> body});

  Future<Either<Failure, GetPlatformData>> getPlatform();
}

class AuthUseCaseImpl implements AuthUseCase {
  final AuthRepository repository;

  AuthUseCaseImpl({required this.repository});

  @override
  Future<Either<Failure, UserModel?>> callLogin(
      {required Map<String, dynamic> body}) async {
    final result = await repository.doLogin(body: body);
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
}
