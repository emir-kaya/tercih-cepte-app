import '../../../../core/utils/failures.dart';
import '../../../../core/utils/result.dart';
import '../repositories/forum_repository.dart';

class AddForumReply {
  final ForumRepository repository;

  AddForumReply(this.repository);

  Future<Result<void, Failure>> call({
    required String topicId,
    required String content,
  }) {
    return repository.addReply(topicId: topicId, content: content);
  }
}
