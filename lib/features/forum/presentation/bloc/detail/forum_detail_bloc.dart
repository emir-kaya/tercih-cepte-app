import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/result.dart';
import '../../../data/datasources/forum_firebase_datasource.dart';
import '../../../domain/repositories/forum_repository.dart';
import '../../../domain/usecases/add_forum_reply.dart';
import '../../../domain/usecases/get_forum_replies.dart';
import '../../../domain/usecases/toggle_reply_like.dart';
import '../../../domain/usecases/toggle_topic_like.dart';
import '../../../domain/usecases/toggle_topic_save.dart';
import 'forum_detail_event.dart';
import 'forum_detail_state.dart';

class ForumDetailBloc extends Bloc<ForumDetailEvent, ForumDetailState> {
  final GetForumReplies _getForumReplies;
  final AddForumReply _addForumReply;
  final ToggleTopicLike _toggleTopicLike;
  final ToggleTopicSave _toggleTopicSave;
  final ToggleReplyLike _toggleReplyLike;
  final ForumRepository _repository;
  final ForumFirebaseDataSource _firebaseDataSource;

  ForumDetailBloc({
    required GetForumReplies getForumReplies,
    required AddForumReply addForumReply,
    required ToggleTopicLike toggleTopicLike,
    required ToggleTopicSave toggleTopicSave,
    required ToggleReplyLike toggleReplyLike,
    required ForumRepository repository,
    required ForumFirebaseDataSource firebaseDataSource,
  })  : _getForumReplies = getForumReplies,
        _addForumReply = addForumReply,
        _toggleTopicLike = toggleTopicLike,
        _toggleTopicSave = toggleTopicSave,
        _toggleReplyLike = toggleReplyLike,
        _repository = repository,
        _firebaseDataSource = firebaseDataSource,
        super(const ForumDetailInitial()) {
    on<LoadForumReplies>(_onLoadForumReplies);
    on<AddReplyRequested>(_onAddReply);
    on<ToggleTopicLikeRequested>(_onToggleTopicLike);
    on<ToggleTopicSaveRequested>(_onToggleTopicSave);
    on<ToggleReplyLikeRequested>(_onToggleReplyLike);
  }

  Future<void> _onLoadForumReplies(
    LoadForumReplies event,
    Emitter<ForumDetailState> emit,
  ) async {
    emit(const ForumDetailLoading());
    // Increment view count in background
    _firebaseDataSource.incrementViewCount(event.topicId);
    await _fetchAll(event.topicId, emit);
  }

  Future<void> _onAddReply(
    AddReplyRequested event,
    Emitter<ForumDetailState> emit,
  ) async {
    final result = await _addForumReply(
      topicId: event.topicId,
      content: event.content,
    );

    switch (result) {
      case Error(:final failure):
        emit(ForumDetailError(failure.message));
      case Success():
        emit(const ForumReplyAdded());
        await _fetchAll(event.topicId, emit);
    }
  }

  Future<void> _onToggleTopicLike(
    ToggleTopicLikeRequested event,
    Emitter<ForumDetailState> emit,
  ) async {
    await _toggleTopicLike(event.topicId);
    await _fetchAll(event.topicId, emit);
  }

  Future<void> _onToggleTopicSave(
    ToggleTopicSaveRequested event,
    Emitter<ForumDetailState> emit,
  ) async {
    await _toggleTopicSave(event.topicId);
    await _fetchAll(event.topicId, emit);
  }

  Future<void> _onToggleReplyLike(
    ToggleReplyLikeRequested event,
    Emitter<ForumDetailState> emit,
  ) async {
    await _toggleReplyLike(event.topicId, event.replyId);
    await _fetchReplies(event.topicId, emit);
  }

  Future<void> _fetchAll(String topicId, Emitter<ForumDetailState> emit) async {
    final topicResult = await _repository.getTopic(topicId);
    final repliesResult = await _getForumReplies(topicId);

    repliesResult.fold(
      (failure) => emit(ForumDetailError(failure.message)),
      (replies) {
        topicResult.fold(
          (_) => emit(ForumDetailLoaded(replies, topic: null)),
          (topic) => emit(ForumDetailLoaded(replies, topic: topic)),
        );
      },
    );
  }

  Future<void> _fetchReplies(String topicId, Emitter<ForumDetailState> emit) async {
    final result = await _getForumReplies(topicId);
    final currentTopic = state is ForumDetailLoaded ? (state as ForumDetailLoaded).topic : null;

    result.fold(
      (failure) => emit(ForumDetailError(failure.message)),
      (replies) => emit(ForumDetailLoaded(replies, topic: currentTopic)),
    );
  }
}
