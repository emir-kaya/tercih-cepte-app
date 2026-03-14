import '../../../../core/utils/failures.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/department_option.dart';
import '../../domain/entities/university_option.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/register_params.dart';
import '../datasources/auth_local_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({required this.localDataSource});

  @override
  Future<Result<User, Failure>> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await localDataSource.login(email, password);
      return Success(user);
    } catch (e) {
      return const Error(ServerFailure('Giriş yapılırken bir hata oluştu.'));
    }
  }

  @override
  Future<Result<User, Failure>> register({
    required RegisterParams params,
  }) async {
    try {
      final user = await localDataSource.register(params);
      return Success(user);
    } catch (e) {
      return const Error(ServerFailure('Kayıt olurken bir hata oluştu.'));
    }
  }

  @override
  Future<Result<List<UniversityOption>, Failure>> getUniversities() async {
    try {
      final universities = await localDataSource.getUniversities();
      return Success(universities);
    } catch (e) {
      return const Error(ServerFailure('Üniversiteler yüklenirken bir hata oluştu.'));
    }
  }

  @override
  Future<Result<List<DepartmentOption>, Failure>> getDepartments(
    String universityId,
  ) async {
    try {
      final departments = await localDataSource.getDepartments(universityId);
      return Success(departments);
    } catch (e) {
      return const Error(ServerFailure('Bölümler yüklenirken bir hata oluştu.'));
    }
  }

  @override
  Future<bool> isLoggedIn() {
    return localDataSource.isLoggedIn();
  }

  @override
  Future<void> saveAuthToken(String token) {
    return localDataSource.saveToken(token);
  }

  @override
  Future<void> logout() {
    return localDataSource.clearToken();
  }
}
