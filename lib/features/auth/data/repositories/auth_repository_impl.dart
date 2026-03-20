import 'package:firebase_auth/firebase_auth.dart' as fb;

import '../../../../core/utils/failures.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/department_option.dart';
import '../../domain/entities/university_option.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/register_params.dart';
import '../datasources/auth_firebase_datasource.dart';
import '../datasources/auth_local_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthFirebaseDataSource firebaseDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.firebaseDataSource,
    required this.localDataSource,
  });

  @override
  Future<Result<User, Failure>> login({
    required String email,
    required String password,
  }) async {
    try {
      final fbUser = await firebaseDataSource.login(email, password);
      // Fetch full profile from Firestore
      final user = await firebaseDataSource.getUserProfile(fbUser.uid);
      return Success(user);
    } on fb.FirebaseAuthException catch (e) {
      final message = AuthFirebaseDataSource.firebaseErrorToTurkish(e.code);
      return Error(ServerFailure(message));
    } catch (e) {
      return const Error(ServerFailure('Giriş yapılırken bir hata oluştu.'));
    }
  }

  @override
  Future<Result<User, Failure>> register({
    required RegisterParams params,
  }) async {
    try {
      final fbUser = await firebaseDataSource.register(params);
      return Success(User(
        id: fbUser.uid,
        fullName: params.fullName,
        email: params.email,
        status: params.status,
        grade: params.grade,
      ));
    } on fb.FirebaseAuthException catch (e) {
      final message = AuthFirebaseDataSource.firebaseErrorToTurkish(e.code);
      return Error(ServerFailure(message));
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
  Future<bool> isLoggedIn() async {
    return firebaseDataSource.isLoggedIn();
  }

  @override
  Future<void> saveAuthToken(String token) async {
    // Firebase handles token management internally
  }

  @override
  Future<void> logout() async {
    await firebaseDataSource.logout();
  }
}
