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
