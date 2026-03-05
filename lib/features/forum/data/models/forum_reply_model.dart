import '../../domain/entities/forum_reply.dart';

class ForumReplyModel extends ForumReply {
  const ForumReplyModel({
    required super.id,
    required super.topicId,
    required super.authorName,
    required super.authorRole,
    required super.content,
    required super.createdAt,
    required super.likeCount,
    super.isLiked = false,
  });

  factory ForumReplyModel.fromJson(Map<String, dynamic> json) {
    return ForumReplyModel(
      id: json['id'] as String,
      topicId: json['topicId'] as String,
      authorName: json['authorName'] as String,
      authorRole: json['authorRole'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      likeCount: json['likeCount'] as int,
      isLiked: json['isLiked'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'topicId': topicId,
      'authorName': authorName,
      'authorRole': authorRole,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'likeCount': likeCount,
      'isLiked': isLiked,
    };
  }
}
