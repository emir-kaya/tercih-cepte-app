import '../../../../core/utils/failures.dart';
import '../../../../core/utils/result.dart';
import '../entities/university_detail.dart';

abstract class UniversityDetailRepository {
  Future<Result<UniversityDetail, Failure>> getUniversityDetail(String id);
}
