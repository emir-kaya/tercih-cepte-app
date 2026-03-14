import '../../../../core/utils/failures.dart';
import '../../../../core/utils/result.dart';
import '../entities/university_option.dart';
import '../repositories/auth_repository.dart';

class GetUniversities {
  final AuthRepository repository;

  GetUniversities(this.repository);

  Future<Result<List<UniversityOption>, Failure>> call() {
    return repository.getUniversities();
  }
}
