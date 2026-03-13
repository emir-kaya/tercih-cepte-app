import '../../../../core/utils/failures.dart';
import '../../../../core/utils/result.dart';
import '../entities/university_detail.dart';
import '../repositories/university_detail_repository.dart';

class GetUniversityDetail {
  final UniversityDetailRepository repository;

  GetUniversityDetail(this.repository);

  Future<Result<UniversityDetail, Failure>> call(String id) {
    return repository.getUniversityDetail(id);
  }
}
