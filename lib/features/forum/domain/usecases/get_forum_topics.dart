import '../../../../core/utils/failures.dart';
import '../../../../core/utils/result.dart';
import '../entities/forum_topic.dart';
import '../repositories/forum_repository.dart';

class GetForumTopics {
  final ForumRepository repository;

  GetForumTopics(this.repository);

  Future<Result<List<ForumTopic>, Failure>> call() {
    return repository.getTopics();
  }
}
