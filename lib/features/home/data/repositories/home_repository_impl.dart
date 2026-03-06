import '../../../../core/utils/failures.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/home_overview.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_local_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDataSource localDataSource;

  HomeRepositoryImpl({required this.localDataSource});

  @override
  Future<Result<HomeOverview, Failure>> getHomeOverview() async {
    try {
      final localData = await localDataSource.getHomeOverview();
      return Success(localData);
    } catch (e) {
      return const Error(ServerFailure('Veriler yüklenirken bir hata oluştu.'));
    }
  }
}
