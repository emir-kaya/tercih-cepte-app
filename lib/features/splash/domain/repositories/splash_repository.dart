import '../../../../core/utils/result.dart';
import '../../../../core/utils/failures.dart';

abstract class SplashRepository {
  /// Checks initial application data like force updates, auth state, etc.
  /// Returns a boolean indicating if it requires a force update for the mock.
  Future<Result<bool, Failure>> checkInitialData();
}
