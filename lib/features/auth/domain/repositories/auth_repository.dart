import '../../../../core/utils/failures.dart';
import '../../../../core/utils/result.dart';
import '../entities/department_option.dart';
import '../entities/university_option.dart';
import '../entities/user.dart';
import '../usecases/register_params.dart';

abstract class AuthRepository {
  Future<Result<User, Failure>> login({
    required String email,
    required String password,
  });

  Future<Result<User, Failure>> register({
    required RegisterParams params,
  });

  Future<Result<List<UniversityOption>, Failure>> getUniversities();

  Future<Result<List<DepartmentOption>, Failure>> getDepartments(
    String universityId,
  );

  Future<bool> isLoggedIn();

  Future<void> saveAuthToken(String token);

  Future<void> logout();
}
