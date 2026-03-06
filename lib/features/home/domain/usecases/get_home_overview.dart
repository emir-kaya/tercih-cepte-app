import '../../../../core/utils/failures.dart';
import '../../../../core/utils/result.dart';
import '../entities/home_overview.dart';
import '../repositories/home_repository.dart';

class GetHomeOverview {
  final HomeRepository repository;

  GetHomeOverview(this.repository);

  Future<Result<HomeOverview, Failure>> call() {
    return repository.getHomeOverview();
  }
}
