import '../../../../core/utils/failures.dart';
import '../../../../core/utils/result.dart';
import '../repositories/splash_repository.dart';

class CheckInitialData {
  final SplashRepository repository;

  CheckInitialData(this.repository);

  Future<Result<bool, Failure>> call() async {
    return await repository.checkInitialData();
  }

  Future<bool> isOnboardingCompleted() {
    return repository.isOnboardingCompleted();
  }

  Future<bool> isUserLoggedIn() {
    return repository.isUserLoggedIn();
  }
}
