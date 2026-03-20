import '../../../../core/utils/failures.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/forum_reply.dart';
import '../../domain/entities/forum_topic.dart';
import '../../domain/repositories/forum_repository.dart';
import '../datasources/forum_firebase_datasource.dart';

class ForumRepositoryImpl implements ForumRepository {
  final ForumFirebaseDataSource firebaseDataSource;

  ForumRepositoryImpl({required this.firebaseDataSource});

  @override
  Future<Result<ForumTopic, Failure>> getTopic(String topicId) async {
    try {
      final topic = await firebaseDataSource.getTopic(topicId);
      return Success(topic);
    } catch (e) {
      return const Error(ServerFailure('Konu yüklenirken bir hata oluştu.'));
    }
  }

  @override
  Future<Result<List<ForumTopic>, Failure>> getTopics() async {
    try {
      final topics = await firebaseDataSource.getTopics();
      return Success(topics);
    } catch (e) {
      return const Error(ServerFailure('Forum konuları yüklenirken bir hata oluştu.'));
    }
  }

  @override
  Future<Result<List<ForumReply>, Failure>> getRepliesForTopic(String topicId) async {
    try {
      final replies = await firebaseDataSource.getRepliesForTopic(topicId);
      return Success(replies);
    } catch (e) {
      return const Error(ServerFailure('Yanıtlar yüklenirken bir hata oluştu.'));
    }
  }

  @override
  Future<Result<String, Failure>> createTopic({
    required String title,
    required String content,
    required String universityName,
    required List<String> tags,
  }) async {
    try {
      final topicId = await firebaseDataSource.createTopic(
        title: title,
        content: content,
        universityName: universityName,
        tags: tags,
      );
      return Success(topicId);
    } catch (e) {
      return const Error(ServerFailure('Konu oluşturulurken bir hata oluştu.'));
    }
  }

  @override
  Future<Result<void, Failure>> addReply({
    required String topicId,
    required String content,
  }) async {
    try {
      await firebaseDataSource.addReply(topicId: topicId, content: content);
      return const Success(null);
    } catch (e) {
      return const Error(ServerFailure('Yanıt gönderilirken bir hata oluştu.'));
    }
  }

  @override
  Future<Result<void, Failure>> toggleTopicLike(String topicId) async {
    try {
      await firebaseDataSource.toggleTopicLike(topicId);
      return const Success(null);
    } catch (e) {
      return const Error(ServerFailure('İşlem sırasında bir hata oluştu.'));
    }
  }

  @override
  Future<Result<void, Failure>> toggleTopicSave(String topicId) async {
    try {
      await firebaseDataSource.toggleTopicSave(topicId);
      return const Success(null);
    } catch (e) {
      return const Error(ServerFailure('İşlem sırasında bir hata oluştu.'));
    }
  }

  @override
  Future<Result<void, Failure>> toggleReplyLike(String topicId, String replyId) async {
    try {
      await firebaseDataSource.toggleReplyLike(topicId, replyId);
      return const Success(null);
    } catch (e) {
      return const Error(ServerFailure('İşlem sırasında bir hata oluştu.'));
    }
  }
}
