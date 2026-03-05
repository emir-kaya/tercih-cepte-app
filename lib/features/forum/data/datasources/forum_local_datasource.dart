import '../models/forum_topic_model.dart';

class ForumLocalDataSource {
  Future<List<ForumTopicModel>> getTopics() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1000));

    return [
      ForumTopicModel(
        id: '1',
        title: 'Boğaziçi Yurtları Nasıl? Hangisinde kalmalıyım?',
        universityName: 'Boğaziçi Üniversitesi',
        authorName: 'Ahmet Y.',
        authorRole: 'Aday',
        replyCount: 24,
        viewCount: 156,
        lastActivityDate: DateTime.now().subtract(const Duration(minutes: 5)),
        tags: const ['Yurt', 'Barınma', 'Kampüs'],
      ),
      ForumTopicModel(
        id: '2',
        title: 'ODTÜ Bilgisayar Mühendisliği vs İTÜ Bilgisayar Mühendisliği',
        universityName: 'ODTÜ - İTÜ',
        authorName: 'Canberk K.',
        authorRole: 'Aday',
        replyCount: 56,
        viewCount: 420,
        lastActivityDate: DateTime.now().subtract(const Duration(minutes: 45)),
        tags: const ['Karşılaştırma', 'Bilgisayar', 'Mühendislik'],
      ),
      ForumTopicModel(
        id: '3',
        title: 'Koç Üni Burslu Okumak Zor Mu? Yarı Zamanlı Çalışılabilir mi?',
        universityName: 'Koç Üniversitesi',
        authorName: 'Merve S.',
        authorRole: 'Öğrenci',
        replyCount: 12,
        viewCount: 89,
        lastActivityDate: DateTime.now().subtract(const Duration(hours: 2)),
        tags: const ['Burs', 'İş İmkanı', 'Kampüs Hayatı'],
      ),
      ForumTopicModel(
        id: '4',
        title: 'Bilkent EE 1. Sınıf Dersleri Çok Mu Zor?',
        universityName: 'Bilkent Üniversitesi',
        authorName: 'Ali T.',
        authorRole: 'Öğrenci',
        replyCount: 8,
        viewCount: 65,
        lastActivityDate: DateTime.now().subtract(const Duration(hours: 5)),
        tags: const ['Akademik', 'Dersler', 'EE'],
      ),
    ];
  }
}
