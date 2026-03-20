import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/models/forum_reply_model.dart';
import '../../data/models/forum_topic_model.dart';

class ForumFirebaseDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  ForumFirebaseDataSource({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> get _topicsRef =>
      _firestore.collection('forum_topics');

  String get _currentUid => _auth.currentUser?.uid ?? '';

  Future<List<ForumTopicModel>> getTopics() async {
    final snapshot = await _topicsRef
        .orderBy('lastActivityDate', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      final likedBy = List<String>.from(data['likedBy'] ?? []);
      final savedBy = List<String>.from(data['savedBy'] ?? []);

      return ForumTopicModel(
        id: doc.id,
        title: data['title'] ?? '',
        content: data['content'] ?? '',
        universityName: data['universityName'] ?? '',
        authorName: data['authorName'] ?? '',
        authorRole: data['authorRole'] ?? '',
        replyCount: data['replyCount'] ?? 0,
        viewCount: data['viewCount'] ?? 0,
        lastActivityDate: (data['lastActivityDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
        tags: List<String>.from(data['tags'] ?? []),
        likeCount: likedBy.length,
        isLiked: likedBy.contains(_currentUid),
        isSaved: savedBy.contains(_currentUid),
      );
    }).toList();
  }

  Future<ForumTopicModel> getTopic(String topicId) async {
    final doc = await _topicsRef.doc(topicId).get();
    final data = doc.data();
    if (data == null) throw Exception('Konu bulunamadı');

    final likedBy = List<String>.from(data['likedBy'] ?? []);
    final savedBy = List<String>.from(data['savedBy'] ?? []);

    return ForumTopicModel(
      id: doc.id,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      universityName: data['universityName'] ?? '',
      authorName: data['authorName'] ?? '',
      authorRole: data['authorRole'] ?? '',
      replyCount: data['replyCount'] ?? 0,
      viewCount: data['viewCount'] ?? 0,
      lastActivityDate: (data['lastActivityDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      tags: List<String>.from(data['tags'] ?? []),
      isLiked: likedBy.contains(_currentUid),
      isSaved: savedBy.contains(_currentUid),
    );
  }

  Future<List<ForumReplyModel>> getRepliesForTopic(String topicId) async {
    final snapshot = await _topicsRef
        .doc(topicId)
        .collection('replies')
        .orderBy('createdAt', descending: false)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      final likedBy = List<String>.from(data['likedBy'] ?? []);

      return ForumReplyModel(
        id: doc.id,
        topicId: topicId,
        authorName: data['authorName'] ?? '',
        authorRole: data['authorRole'] ?? '',
        content: data['content'] ?? '',
        createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
        likeCount: likedBy.length,
        isLiked: likedBy.contains(_currentUid),
      );
    }).toList();
  }

  Future<String> createTopic({
    required String title,
    required String content,
    required String universityName,
    required List<String> tags,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('Oturum açmanız gerekiyor');

    final userDoc = await _firestore.collection('users').doc(user.uid).get();
    final userData = userDoc.data();
    final authorRole = _mapStatusToRole(userData?['status'] as String?);

    final docRef = await _topicsRef.add({
      'title': title,
      'content': content,
      'universityName': universityName,
      'authorId': user.uid,
      'authorName': user.displayName ?? 'Anonim',
      'authorRole': authorRole,
      'replyCount': 0,
      'viewCount': 0,
      'tags': tags,
      'likedBy': [],
      'savedBy': [],
      'createdAt': FieldValue.serverTimestamp(),
      'lastActivityDate': FieldValue.serverTimestamp(),
    });

    return docRef.id;
  }

  Future<void> addReply({
    required String topicId,
    required String content,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('Oturum açmanız gerekiyor');

    final userDoc = await _firestore.collection('users').doc(user.uid).get();
    final userData = userDoc.data();
    final authorRole = _mapStatusToRole(userData?['status'] as String?);

    await _topicsRef.doc(topicId).collection('replies').add({
      'authorId': user.uid,
      'authorName': user.displayName ?? 'Anonim',
      'authorRole': authorRole,
      'content': content,
      'likedBy': [],
      'createdAt': FieldValue.serverTimestamp(),
    });

    // Update topic reply count and last activity
    await _topicsRef.doc(topicId).update({
      'replyCount': FieldValue.increment(1),
      'lastActivityDate': FieldValue.serverTimestamp(),
    });
  }

  Future<void> incrementViewCount(String topicId) async {
    await _topicsRef.doc(topicId).update({
      'viewCount': FieldValue.increment(1),
    });
  }

  Future<void> toggleTopicLike(String topicId) async {
    final uid = _currentUid;
    if (uid.isEmpty) return;

    final docRef = _topicsRef.doc(topicId);
    final doc = await docRef.get();
    final likedBy = List<String>.from(doc.data()?['likedBy'] ?? []);

    if (likedBy.contains(uid)) {
      await docRef.update({'likedBy': FieldValue.arrayRemove([uid])});
    } else {
      await docRef.update({'likedBy': FieldValue.arrayUnion([uid])});
    }
  }

  Future<void> toggleTopicSave(String topicId) async {
    final uid = _currentUid;
    if (uid.isEmpty) return;

    final docRef = _topicsRef.doc(topicId);
    final doc = await docRef.get();
    final savedBy = List<String>.from(doc.data()?['savedBy'] ?? []);

    if (savedBy.contains(uid)) {
      await docRef.update({'savedBy': FieldValue.arrayRemove([uid])});
    } else {
      await docRef.update({'savedBy': FieldValue.arrayUnion([uid])});
    }
  }

  Future<void> toggleReplyLike(String topicId, String replyId) async {
    final uid = _currentUid;
    if (uid.isEmpty) return;

    final docRef = _topicsRef.doc(topicId).collection('replies').doc(replyId);
    final doc = await docRef.get();
    final likedBy = List<String>.from(doc.data()?['likedBy'] ?? []);

    if (likedBy.contains(uid)) {
      await docRef.update({'likedBy': FieldValue.arrayRemove([uid])});
    } else {
      await docRef.update({'likedBy': FieldValue.arrayUnion([uid])});
    }
  }

  String _mapStatusToRole(String? status) {
    return switch (status) {
      'highSchool' => 'highSchool',
      'university' => 'university',
      'graduate' => 'graduate',
      _ => 'user',
    };
  }
}
