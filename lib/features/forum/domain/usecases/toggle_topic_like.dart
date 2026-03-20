import '../../../../core/utils/failures.dart';
import '../../../../core/utils/result.dart';
import '../repositories/forum_repository.dart';

class ToggleTopicLike {
  final ForumRepository repository;

  ToggleTopicLike(this.repository);

  Future<Result<void, Failure>> call(String topicId) {
    return repository.toggleTopicLike(topicId);
  }
}
