import '../../../../core/error/failure.dart';
import '../../../../core/utils/dartz/either.dart';
import '../../data/models/preferance_model.dart';
import '../../data/repositories/home_repo_implementation.dart';

abstract class HomeUseCase {
  Future<Either<Failure, PreferencesModel?>> callGetPreference();
  Future<Either<Failure, dynamic>> callGetHome(
      {required Map<String, dynamic> body});
  Future<Either<Failure, dynamic>> updateCoordinates(
      {required Map<String, dynamic> body});
  Future<Either<Failure, dynamic>> calAddSubscription(
      {required Map<String, dynamic> body});
}

class HomeUseCaseImpl implements HomeUseCase {
  final HomeRepository repository;
  HomeUseCaseImpl({required this.repository});
  @override
  Future<Either<Failure, PreferencesModel?>> callGetPreference() async {
    final result = await repository.getPreference();
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }

  @override
  Future<Either<Failure, dynamic>> callGetHome(
      {required Map<String, dynamic> body}) async {
    final result = await repository.getHome(body: body);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }

  @override
  Future<Either<Failure, dynamic>> updateCoordinates(
      {required Map<String, dynamic> body}) async {
    final result = await repository.updateCoordinates(body: body);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }

  @override
  Future<Either<Failure, dynamic>> calAddSubscription(
      {required Map<String, dynamic> body}) async {
    final result = await repository.addSubscription(body: body);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
