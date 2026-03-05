import 'package:equatable/equatable.dart';
import '../../domain/entities/forum_topic.dart';

abstract class ForumState extends Equatable {
  const ForumState();

  @override
  List<Object?> get props => [];
}

class ForumInitial extends ForumState {}

class ForumLoading extends ForumState {}

class ForumLoaded extends ForumState {
  final List<ForumTopic> topics;

  const ForumLoaded({required this.topics});

  @override
  List<Object?> get props => [topics];
}

class ForumError extends ForumState {
  final String message;

  const ForumError(this.message);

  @override
  List<Object?> get props => [message];
}
