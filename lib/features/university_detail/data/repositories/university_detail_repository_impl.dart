import '../../../../core/utils/failures.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/university_detail.dart';
import '../../domain/repositories/university_detail_repository.dart';
import '../datasources/university_detail_local_datasource.dart';

class UniversityDetailRepositoryImpl implements UniversityDetailRepository {
  final UniversityDetailLocalDataSource localDataSource;

  UniversityDetailRepositoryImpl({required this.localDataSource});

  @override
  Future<Result<UniversityDetail, Failure>> getUniversityDetail(String id) async {
    try {
      final detail = await localDataSource.getUniversityDetail(id);
      return Success(detail);
    } catch (e) {
      return const Error(ServerFailure('Üniversite detayları yüklenirken bir hata oluştu.'));
    }
  }
}
