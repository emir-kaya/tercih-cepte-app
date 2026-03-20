import 'package:equatable/equatable.dart';
import '../../../domain/entities/forum_reply.dart';
import '../../../domain/entities/forum_topic.dart';

abstract class ForumDetailState extends Equatable {
  const ForumDetailState();

  @override
  List<Object?> get props => [];
}

class ForumDetailInitial extends ForumDetailState {
  const ForumDetailInitial();
}

class ForumDetailLoading extends ForumDetailState {
  const ForumDetailLoading();
}

class ForumDetailLoaded extends ForumDetailState {
  final List<ForumReply> replies;
  final ForumTopic? topic;

  const ForumDetailLoaded(this.replies, {this.topic});

  @override
  List<Object?> get props => [replies, topic];
}

class ForumDetailError extends ForumDetailState {
  final String message;

  const ForumDetailError(this.message);

  @override
  List<Object?> get props => [message];
}

class ForumReplyAdded extends ForumDetailState {
  const ForumReplyAdded();
}
