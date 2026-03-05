import '../../../../core/utils/result.dart';
import '../../../../core/utils/failures.dart';
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
}
