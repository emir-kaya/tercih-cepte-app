import '../../../../core/utils/result.dart';
import '../../../../core/utils/failures.dart';
import '../../domain/repositories/splash_repository.dart';

class SplashRepositoryImpl implements SplashRepository {
  @override
  Future<Result<bool, Failure>> checkInitialData() async {
    try {
      // Simulate network request or local setup delay
      await Future.delayed(const Duration(milliseconds: 1500));
      return const Success(false); // Returning false indicates "no force update needed"
    } catch (e) {
      return Error(ServerFailure(e.toString()));
    }
  }
}
