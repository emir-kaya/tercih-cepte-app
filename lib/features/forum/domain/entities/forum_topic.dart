import 'package:equatable/equatable.dart';

class ForumTopic extends Equatable {
  final String id;
  final String title;
  final String content;
  final String universityName;
  final String authorName;
  final String authorRole; // e.g., "Öğrenci", "Aday"
  final int replyCount;
  final int viewCount;
  final DateTime lastActivityDate;
  final List<String> tags;
  final bool isLiked;
  final bool isSaved;

  const ForumTopic({
    required this.id,
    required this.title,
    required this.content,
    required this.universityName,
    required this.authorName,
    required this.authorRole,
    required this.replyCount,
    required this.viewCount,
    required this.lastActivityDate,
    required this.tags,
    this.isLiked = false,
    this.isSaved = false,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        universityName,
        authorName,
        authorRole,
        replyCount,
        viewCount,
        lastActivityDate,
        tags,
        isLiked,
        isSaved,
      ];
}
