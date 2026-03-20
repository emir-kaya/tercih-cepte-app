import '../../../auth/data/datasources/auth_firebase_datasource.dart';
import '../../../auth/domain/entities/user.dart';
import '../../domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final AuthFirebaseDataSource firebaseDataSource;

  ProfileRepositoryImpl({required this.firebaseDataSource});

  @override
  Future<User> getCurrentUserProfile() async {
    final currentUser = firebaseDataSource.currentUser;
    if (currentUser == null) {
      throw Exception('Kullanıcı oturum açmamış');
    }
    return firebaseDataSource.getUserProfile(currentUser.uid);
  }
}
