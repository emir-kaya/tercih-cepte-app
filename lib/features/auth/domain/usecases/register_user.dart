import '../../../../core/utils/failures.dart';
import '../../../../core/utils/result.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';
import 'register_params.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<Result<User, Failure>> call(RegisterParams params) {
    return repository.register(params: params);
  }
}
