import '../../../../core/error/failure.dart';
import '../../../../core/utils/dartz/either.dart';
import '../data_source/home_data_source.dart';
import '../models/preferance_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, PreferencesModel?>> getPreference();
  Future<Either<Failure, dynamic>> getHome(
      {required Map<String, dynamic> body});
  Future<Either<Failure, dynamic>> updateCoordinates(
      {required Map<String, dynamic> body});
  Future<Either<Failure, dynamic>> addSubscription(
      {required Map<String, dynamic> body});
}

class HomeRepoImpl implements HomeRepository {
  final HomeDataSource dataSource;

  HomeRepoImpl({required this.dataSource});

  @override
  Future<Either<Failure, PreferencesModel?>> getPreference() async {
    try {
      final data = await dataSource.getPreferences();
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
  Future<Either<Failure, dynamic>> getHome(
      {required Map<String, dynamic> body}) async {
    try {
      final data = await dataSource.getHomeData(body: body);
      if (data?.status == "success") {
        return Right(data?.data);
      } else {
        return Left(ServerFailure(message: data?.message ?? ""));
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

//UPDATE COORDINATES
  @override
  Future<Either<Failure, dynamic>> updateCoordinates(
      {required Map<String, dynamic> body}) async {
    try {
      final data = await dataSource.updateCoordinates(body: body);
      if (data?.status == "success") {
        return Right(data?.data);
      } else {
        return Left(ServerFailure(message: data?.message ?? ""));
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  //UPDATE COORDINATES
  @override
  Future<Either<Failure, dynamic>> addSubscription(
      {required Map<String, dynamic> body}) async {
    try {
      final data = await dataSource.getAddSubscription(body: body);
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
