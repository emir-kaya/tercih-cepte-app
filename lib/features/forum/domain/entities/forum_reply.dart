import 'package:equatable/equatable.dart';

class ForumReply extends Equatable {
  final String id;
  final String topicId;
  final String authorName;
  final String authorRole;
  final String content;
  final DateTime createdAt;
  final int likeCount;
  final bool isLiked;

  const ForumReply({
    required this.id,
    required this.topicId,
    required this.authorName,
    required this.authorRole,
    required this.content,
    required this.createdAt,
    required this.likeCount,
    this.isLiked = false,
  });

  @override
  List<Object?> get props => [
        id,
        topicId,
        authorName,
        authorRole,
        content,
        createdAt,
        likeCount,
        isLiked,
      ];
}
