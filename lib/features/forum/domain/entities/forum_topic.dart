import 'package:equatable/equatable.dart';

class ForumTopic extends Equatable {
  final String id;
  final String title;
  final String universityName;
  final String authorName;
  final String authorRole; // e.g., "Öğrenci", "Aday"
  final int replyCount;
  final int viewCount;
  final DateTime lastActivityDate;
  final List<String> tags;

  const ForumTopic({
    required this.id,
    required this.title,
    required this.universityName,
    required this.authorName,
    required this.authorRole,
    required this.replyCount,
    required this.viewCount,
    required this.lastActivityDate,
    required this.tags,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        universityName,
        authorName,
        authorRole,
        replyCount,
        viewCount,
        lastActivityDate,
        tags,
      ];
}
