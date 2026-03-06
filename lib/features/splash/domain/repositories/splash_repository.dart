import '../../../../core/utils/failures.dart';
import '../../../../core/utils/result.dart';

abstract class SplashRepository {
  /// Checks initial application data like force updates, auth state, etc.
  /// Returns a boolean indicating if it requires a force update for the mock.
  Future<Result<bool, Failure>> checkInitialData();
}
