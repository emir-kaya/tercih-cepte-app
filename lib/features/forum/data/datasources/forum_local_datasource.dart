import '../models/forum_topic_model.dart';
import '../models/forum_reply_model.dart';

class ForumLocalDataSource {
  Future<List<ForumTopicModel>> getTopics() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1000));

    return [
      ForumTopicModel(
        id: '1',
        title: 'Boğaziçi Yurtları Nasıl? Hangisinde kalmalıyım?',
        content: 'Arkadaşlar Boğaziçi Üniversitesi EE kazandım. Ancak yurtlar hakkında çok bilgim yok. Kuzeykampüs mü Güneykampüs mü, hangisi daha iyi? Kilyos\'a düşme ihtimalim nedir? Detaylı bilgi verebilecek olan var mı?',
        universityName: 'Boğaziçi Üniversitesi',
        authorName: 'Ahmet Y.',
        authorRole: 'Aday',
        replyCount: 24,
        viewCount: 156,
        lastActivityDate: DateTime.now().subtract(const Duration(minutes: 5)),
        tags: const ['Yurt', 'Barınma', 'Kampüs'],
        isSaved: true,
      ),
      ForumTopicModel(
        id: '2',
        title: 'ODTÜ Bilgisayar Mühendisliği vs İTÜ Bilgisayar Mühendisliği',
        content: 'ODTÜ bilgisayar ve İTÜ bilgisayar arasında kaldım. Akademik kadro, sosyal yaşam ve mezun ağı olarak hangisini tercih etmeliyim? İTÜ nün merkezi konum avantajı ODTÜnün kampüs yaşantısına ağır basar mı sizce?',
        universityName: 'ODTÜ - İTÜ',
        authorName: 'Canberk K.',
        authorRole: 'Aday',
        replyCount: 56,
        viewCount: 420,
        lastActivityDate: DateTime.now().subtract(const Duration(minutes: 45)),
        tags: const ['Karşılaştırma', 'Bilgisayar', 'Mühendislik'],
        isLiked: true,
      ),
      ForumTopicModel(
        id: '3',
        title: 'Koç Üni Burslu Okumak Zor Mu? Yarı Zamanlı Çalışılabilir mi?',
        content: 'Merhabalar Koç üniversitesinde %100 burslu Endüstri Mühendisliği okuyan biri hem ortalamasını yüksek tutup hem de yarı zamanlı bir işte çalışabilir mi? Yoksa ders yükü buna hiç imkan vermez mi?',
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
        content: 'Bilkent EE 1. sınıfa başlayacağım. Fizik ve Math derslerinin efsanevi zorluğu doğru mu? Yazın önden çalışmalı mıyım yoksa hazırlığı atlamış birinin yapabileceği seviyede mi?',
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

  Future<List<ForumReplyModel>> getRepliesForTopic(String topicId) async {
    await Future.delayed(const Duration(milliseconds: 800));

    // Return dummy replies based on topic id formatting
    return [
      ForumReplyModel(
        id: 'r1',
        topicId: topicId,
        authorName: 'Metehan D.',
        authorRole: 'Öğrenci',
        content: 'Kesinlikle çok mantıklı bir soru. Öncelikle ilk sene için yurt kuraları oluyor. Puanın yetiyorsa...',
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
        likeCount: 14,
        isLiked: true,
      ),
      ForumReplyModel(
        id: 'r2',
        topicId: topicId,
        authorName: 'Selinay K.',
        authorRole: 'Mezun',
        content: 'Kampüs içi yurtların imkanları çok iyi ancak çıkması gerçekten zor olabiliyor. Alternatif olarak özel yurt araştırmanı tavsiye ederim çevredeki.',
        createdAt: DateTime.now().subtract(const Duration(hours: 2, minutes: 30)),
        likeCount: 5,
      ),
      ForumReplyModel(
        id: 'r3',
        topicId: topicId,
        authorName: 'Barış P.',
        authorRole: 'Aday',
        content: 'Ben de aynı konuyu merak ediyordum, takipteyim.',
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
        likeCount: 1,
      ),
    ];
  }
}
