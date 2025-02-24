import 'package:NearMii/feature/home/data/models/home_data_model.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/utils/dartz/either.dart';
import '../data_source/home_data_source.dart';
import '../models/preferance_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, PreferencesModel?>> getPreference();
  Future<Either<Failure, List<HomeData>?>> getHome();
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
  Future<Either<Failure, List<HomeData>?>> getHome() async {
    try {
      final data = await dataSource.getHomeData();
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
