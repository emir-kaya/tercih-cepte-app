import '../../domain/entities/forum_topic.dart';

class ForumTopicModel extends ForumTopic {
  const ForumTopicModel({
    required super.id,
    required super.title,
    required super.universityName,
    required super.authorName,
    required super.authorRole,
    required super.replyCount,
    required super.viewCount,
    required super.lastActivityDate,
    required super.tags,
  });

  factory ForumTopicModel.fromJson(Map<String, dynamic> json) {
    return ForumTopicModel(
      id: json['id'] as String,
      title: json['title'] as String,
      universityName: json['universityName'] as String,
      authorName: json['authorName'] as String,
      authorRole: json['authorRole'] as String,
      replyCount: json['replyCount'] as int,
      viewCount: json['viewCount'] as int,
      lastActivityDate: DateTime.parse(json['lastActivityDate'] as String),
      tags: List<String>.from(json['tags'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'universityName': universityName,
      'authorName': authorName,
      'authorRole': authorRole,
      'replyCount': replyCount,
      'viewCount': viewCount,
      'lastActivityDate': lastActivityDate.toIso8601String(),
      'tags': tags,
    };
  }
}
