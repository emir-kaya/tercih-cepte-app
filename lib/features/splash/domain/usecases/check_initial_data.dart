import '../../../../core/utils/result.dart';
import '../../../../core/utils/failures.dart';
import '../repositories/splash_repository.dart';

class CheckInitialData {
  final SplashRepository repository;

  CheckInitialData(this.repository);

  Future<Result<bool, Failure>> call() async {
    return await repository.checkInitialData();
  }
}
