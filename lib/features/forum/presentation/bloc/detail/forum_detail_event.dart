import 'package:equatable/equatable.dart';

abstract class ForumDetailEvent extends Equatable {
  const ForumDetailEvent();

  @override
  List<Object?> get props => [];
}

class LoadForumReplies extends ForumDetailEvent {
  final String topicId;

  const LoadForumReplies(this.topicId);

  @override
  List<Object?> get props => [topicId];
}

class AddReplyRequested extends ForumDetailEvent {
  final String topicId;
  final String content;

  const AddReplyRequested({required this.topicId, required this.content});

  @override
  List<Object?> get props => [topicId, content];
}

class ToggleTopicLikeRequested extends ForumDetailEvent {
  final String topicId;

  const ToggleTopicLikeRequested(this.topicId);

  @override
  List<Object?> get props => [topicId];
}

class ToggleTopicSaveRequested extends ForumDetailEvent {
  final String topicId;

  const ToggleTopicSaveRequested(this.topicId);

  @override
  List<Object?> get props => [topicId];
}

class ToggleReplyLikeRequested extends ForumDetailEvent {
  final String topicId;
  final String replyId;

  const ToggleReplyLikeRequested({required this.topicId, required this.replyId});

  @override
  List<Object?> get props => [topicId, replyId];
}
