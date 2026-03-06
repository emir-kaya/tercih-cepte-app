import '../../../../core/utils/failures.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/forum_reply.dart';
import '../../domain/entities/forum_topic.dart';
import '../../domain/repositories/forum_repository.dart';
import '../datasources/forum_local_datasource.dart';

class ForumRepositoryImpl implements ForumRepository {
  final ForumLocalDataSource localDataSource;

  ForumRepositoryImpl({required this.localDataSource});

  @override
  Future<Result<List<ForumTopic>, Failure>> getTopics() async {
    try {
      final localData = await localDataSource.getTopics();
      return Success(localData);
    } catch (e) {
      return const Error(ServerFailure('Forum konuları yüklenirken bir hata oluştu.'));
    }
  }

  @override
  Future<Result<List<ForumReply>, Failure>> getRepliesForTopic(String topicId) async {
    try {
      final localData = await localDataSource.getRepliesForTopic(topicId);
      return Success(localData);
    } catch (e) {
      return const Error(ServerFailure('Yanıtlar yüklenirken bir hata oluştu.'));
    }
  }
}
