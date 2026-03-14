import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/department_option.dart';
import '../../domain/entities/university_option.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/user_status.dart';
import '../../domain/usecases/register_params.dart';

class AuthLocalDataSource {
  static const _authTokenKey = 'auth_token';

  Future<User> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (!email.contains('@')) {
      throw Exception('Geçersiz e-posta adresi.');
    }

    return User(
      id: '1',
      fullName: 'Test Kullanıcı',
      email: email,
      status: UserStatus.highSchool,
    );
  }

  Future<User> register(RegisterParams params) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return User(
      id: '1',
      fullName: params.fullName,
      email: params.email,
      status: params.status,
    );
  }

  Future<List<UniversityOption>> getUniversities() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return const [
      UniversityOption(id: '1', name: 'Boğaziçi Üniversitesi'),
      UniversityOption(id: '2', name: 'ODTÜ'),
      UniversityOption(id: '3', name: 'İTÜ'),
      UniversityOption(id: '4', name: 'Koç Üniversitesi'),
      UniversityOption(id: '5', name: 'Bilkent Üniversitesi'),
      UniversityOption(id: '6', name: 'Hacettepe Üniversitesi'),
      UniversityOption(id: '7', name: 'Sabancı Üniversitesi'),
      UniversityOption(id: '8', name: 'Ankara Üniversitesi'),
      UniversityOption(id: '9', name: 'Ege Üniversitesi'),
      UniversityOption(id: '10', name: 'İstanbul Üniversitesi'),
    ];
  }

  Future<List<DepartmentOption>> getDepartments(String universityId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      DepartmentOption(id: '1', name: 'Bilgisayar Müh.', universityId: universityId),
      DepartmentOption(id: '2', name: 'Elektrik-Elektronik Müh.', universityId: universityId),
      DepartmentOption(id: '3', name: 'Makine Müh.', universityId: universityId),
      DepartmentOption(id: '4', name: 'Endüstri Müh.', universityId: universityId),
      DepartmentOption(id: '5', name: 'İşletme', universityId: universityId),
      DepartmentOption(id: '6', name: 'Hukuk', universityId: universityId),
      DepartmentOption(id: '7', name: 'Tıp', universityId: universityId),
      DepartmentOption(id: '8', name: 'Psikoloji', universityId: universityId),
      DepartmentOption(id: '9', name: 'Mimarlık', universityId: universityId),
      DepartmentOption(id: '10', name: 'Matematik', universityId: universityId),
    ];
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_authTokenKey) != null;
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_authTokenKey, token);
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_authTokenKey);
  }
}
