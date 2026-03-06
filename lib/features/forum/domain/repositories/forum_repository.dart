import '../../../../core/utils/failures.dart';
import '../../../../core/utils/result.dart';
import '../entities/forum_reply.dart';
import '../entities/forum_topic.dart';

abstract class ForumRepository {
  Future<Result<List<ForumTopic>, Failure>> getTopics();
  Future<Result<List<ForumReply>, Failure>> getRepliesForTopic(String topicId);
}
