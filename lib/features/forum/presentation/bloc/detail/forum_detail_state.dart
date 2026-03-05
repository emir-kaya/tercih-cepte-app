import 'package:equatable/equatable.dart';
import '../../../domain/entities/forum_reply.dart';

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

  const ForumDetailLoaded(this.replies);

  @override
  List<Object?> get props => [replies];
}

class ForumDetailError extends ForumDetailState {
  final String message;

  const ForumDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
