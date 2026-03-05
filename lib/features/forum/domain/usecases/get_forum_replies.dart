import '../../../../core/utils/result.dart';
import '../../../../core/utils/failures.dart';
import '../entities/forum_reply.dart';
import '../repositories/forum_repository.dart';

class GetForumReplies {
  final ForumRepository repository;

  GetForumReplies(this.repository);

  Future<Result<List<ForumReply>, Failure>> call(String topicId) {
    return repository.getRepliesForTopic(topicId);
  }
}
