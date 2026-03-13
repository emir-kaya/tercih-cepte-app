import '../../../../core/utils/failures.dart';
import '../../../../core/utils/result.dart';

abstract class SplashRepository {
  Future<Result<bool, Failure>> checkInitialData();
  Future<bool> isOnboardingCompleted();
  Future<void> setOnboardingCompleted();
}
