import '../../../../core/utils/failures.dart';
import '../../../../core/utils/result.dart';
import '../entities/forum_reply.dart';
import '../entities/forum_topic.dart';

abstract class ForumRepository {
  Future<Result<ForumTopic, Failure>> getTopic(String topicId);
  Future<Result<List<ForumTopic>, Failure>> getTopics();
  Future<Result<List<ForumReply>, Failure>> getRepliesForTopic(String topicId);
  Future<Result<String, Failure>> createTopic({
    required String title,
    required String content,
    required String universityName,
    required List<String> tags,
  });
  Future<Result<void, Failure>> addReply({
    required String topicId,
    required String content,
  });
  Future<Result<void, Failure>> toggleTopicLike(String topicId);
  Future<Result<void, Failure>> toggleTopicSave(String topicId);
  Future<Result<void, Failure>> toggleReplyLike(String topicId, String replyId);
}
