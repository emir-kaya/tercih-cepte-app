import '../../../../core/utils/failures.dart';
import '../../../../core/utils/result.dart';
import '../entities/department_option.dart';
import '../repositories/auth_repository.dart';

class GetDepartments {
  final AuthRepository repository;

  GetDepartments(this.repository);

  Future<Result<List<DepartmentOption>, Failure>> call(String universityId) {
    return repository.getDepartments(universityId);
  }
}
