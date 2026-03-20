import '../../../../core/utils/failures.dart';
import '../../../../core/utils/result.dart';
import '../repositories/forum_repository.dart';

class ToggleReplyLike {
  final ForumRepository repository;

  ToggleReplyLike(this.repository);

  Future<Result<void, Failure>> call(String topicId, String replyId) {
    return repository.toggleReplyLike(topicId, replyId);
  }
}
