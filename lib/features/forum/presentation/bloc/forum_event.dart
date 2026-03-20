import 'package:equatable/equatable.dart';

abstract class ForumEvent extends Equatable {
  const ForumEvent();

  @override
  List<Object> get props => [];
}

class LoadForumData extends ForumEvent {}

class RefreshForumData extends ForumEvent {}

class CreateTopicRequested extends ForumEvent {
  final String title;
  final String content;
  final String universityName;
  final List<String> tags;

  const CreateTopicRequested({
    required this.title,
    required this.content,
    required this.universityName,
    required this.tags,
  });

  @override
  List<Object> get props => [title, content, universityName, tags];
}
