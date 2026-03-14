import '../../../../core/utils/failures.dart';
import '../../../../core/utils/result.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  Future<Result<User, Failure>> call({
    required String email,
    required String password,
  }) {
    return repository.login(email: email, password: password);
  }
}
