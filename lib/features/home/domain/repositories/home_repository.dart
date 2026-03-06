import '../../../../core/utils/failures.dart';
import '../../../../core/utils/result.dart';
import '../entities/home_overview.dart';

abstract class HomeRepository {
  Future<Result<HomeOverview, Failure>> getHomeOverview();
}
