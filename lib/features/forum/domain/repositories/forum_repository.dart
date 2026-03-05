import '../../../../core/utils/result.dart';
import '../../../../core/utils/failures.dart';
import '../entities/forum_topic.dart';

abstract class ForumRepository {
  Future<Result<List<ForumTopic>, Failure>> getTopics();
}
