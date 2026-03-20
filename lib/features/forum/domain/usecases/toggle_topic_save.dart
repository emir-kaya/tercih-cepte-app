import '../../../../core/utils/failures.dart';
import '../../../../core/utils/result.dart';
import '../repositories/forum_repository.dart';

class ToggleTopicSave {
  final ForumRepository repository;

  ToggleTopicSave(this.repository);

  Future<Result<void, Failure>> call(String topicId) {
    return repository.toggleTopicSave(topicId);
  }
}
