import '../../../../core/utils/failures.dart';
import '../../../../core/utils/result.dart';
import '../repositories/forum_repository.dart';

class CreateForumTopic {
  final ForumRepository repository;

  CreateForumTopic(this.repository);

  Future<Result<String, Failure>> call({
    required String title,
    required String content,
    required String universityName,
    required List<String> tags,
  }) {
    return repository.createTopic(
      title: title,
      content: content,
      universityName: universityName,
      tags: tags,
    );
  }
}
