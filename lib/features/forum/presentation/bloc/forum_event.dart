import 'package:equatable/equatable.dart';

abstract class ForumEvent extends Equatable {
  const ForumEvent();

  @override
  List<Object> get props => [];
}

class LoadForumData extends ForumEvent {}

class RefreshForumData extends ForumEvent {}
