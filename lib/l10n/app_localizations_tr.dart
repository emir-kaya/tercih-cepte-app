// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class L10nTr extends L10n {
  L10nTr([String locale = 'tr']) : super(locale);

  @override
  String get appName => 'Üniversite Tercih Asistanı';

  @override
  String get defaultErrorMessage => 'Bir hata oluştu. Lütfen tekrar deneyin.';

  @override
  String get retry => 'Tekrar Dene';

  @override
  String get navHome => 'Ana Sayfa';

  @override
  String get navForum => 'Forum';

  @override
  String get navProfile => 'Profil';

  @override
  String homeGreeting(String name) {
    return 'Merhaba, $name 👋';
  }

  @override
  String get homeSubtitle => 'Bugün hedefine bir adım daha yaklaş.';

  @override
  String get homeSearchHint => 'Üniversite, bölüm, ders ara...';

  @override
  String get homeSystemOverview => 'Sisteme Bakış';

  @override
  String get homeUniversity => 'Üniversite';

  @override
  String get homeDepartment => 'Bölüm';

  @override
  String get homeFeaturedUniversities => 'Öne Çıkan Üniversiteler';

  @override
  String get profileTitle => 'Profil';

  @override
  String get profileName => 'Emir Kaya';

  @override
  String get profileRole => '12. Sınıf Öğrencisi';

  @override
  String get profileWizardTitle => 'Tercih Sihirbazı';

  @override
  String get profileWizardSubtitle =>
      'Sana en uygun bölümü birlikte keşfedelim';

  @override
  String get settingsAppSettings => 'Uygulama Ayarları';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsLanguage => 'Uygulama Dili';

  @override
  String get settingsNotifications => 'Bildirimler';

  @override
  String get settingsAccount => 'Hesap';

  @override
  String get settingsEditProfile => 'Profilimi Düzenle';

  @override
  String get settingsLogout => 'Çıkış Yap';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageEnglish => 'English';

  @override
  String get splashTitle => 'TERCİH CEPTE';

  @override
  String get splashSubtitle => 'Geleceğine hazır mısın?';

  @override
  String get splashBottomText => 'Üniversite yolculuğunuzda yanınızdayız';

  @override
  String get onboardTitle1 => 'Üniversiteni Keşfet';

  @override
  String get onboardDesc1 =>
      'Türkiye\'deki tüm üniversiteleri detaylı bilgileriyle incele. Puan aralıkları, bölümler ve akademik kadro bilgilerine kolayca ulaş.';

  @override
  String get onboardTitle2 => 'Topluluğa Katıl';

  @override
  String get onboardDesc2 =>
      'Forum alanında diğer öğrencilerle deneyimlerini paylaş. Sorularını sor, tavsiyeler al ve tercih sürecinde yalnız kalma.';

  @override
  String get onboardTitle3 => 'Doğru Tercih Yap';

  @override
  String get onboardDesc3 =>
      'Tercih sihirbazı ile sana en uygun bölümleri keşfet. Veriye dayalı önerilerle geleceğine güvenle adım at.';

  @override
  String get onboardSkip => 'Atla';

  @override
  String get onboardGetStarted => 'Başlayalım';

  @override
  String get forumTitle => 'Forum';

  @override
  String get forumSubtitle => 'Tartış, sor, keşfet';

  @override
  String get forumSearchHint => 'Konu, üniversite veya etiket ara...';

  @override
  String get forumNewTopic => 'Yeni Konu';

  @override
  String get forumNoTopics => 'Henüz Konu Yok';

  @override
  String get forumNoTopicsMessage => 'İlk tartışmayı sen başlat!';

  @override
  String get forumTopicDetail => 'Konu Detayı';

  @override
  String get forumReplies => 'Yanıtlar';

  @override
  String get forumNoReplies => 'Henüz yanıt yok. İlk yanıtlayan sen ol!';

  @override
  String get forumWriteReply => 'Yanıt Yaz';

  @override
  String get forumReply => 'Yanıtla';

  @override
  String get forumReplyHint => 'Yanıtınızı yazın...';

  @override
  String forumReplyingTo(String name) {
    return '$name adlı kullanıcıya yanıt';
  }

  @override
  String get forumSend => 'Gönder';

  @override
  String get forumReplySent => 'Yanıtınız gönderildi!';

  @override
  String get forumShareTopic => 'Konuyu Paylaş';

  @override
  String get forumCreateTitle => 'Başlık';

  @override
  String get forumCreateTitleHint => 'Konunun başlığını yazın...';

  @override
  String get forumCreateUniversity => 'Üniversite';

  @override
  String get forumCreateUniversityHint => 'Üniversite seçin';

  @override
  String get forumCreateContent => 'İçerik';

  @override
  String get forumCreateContentHint =>
      'Düşüncelerinizi, sorularınızı detaylı bir şekilde yazın...';

  @override
  String get forumCreateTags => 'Etiketler';

  @override
  String get forumCreateTagsHelper => '(isteğe bağlı, en fazla 5)';

  @override
  String get forumCreateTagHint => 'Etiket yazın...';

  @override
  String timeMinutesAgo(int minutes) {
    return '${minutes}d önce';
  }

  @override
  String timeHoursAgo(int hours) {
    return '${hours}sa önce';
  }

  @override
  String timeMinutesShort(int minutes) {
    return '${minutes}d';
  }

  @override
  String timeHoursShort(int hours) {
    return '${hours}s';
  }

  @override
  String timeDaysShort(int days) {
    return '${days}g';
  }

  @override
  String get searchTitle => 'Son Aramalar';

  @override
  String get searchHint => 'Üniversite, bölüm, ders ara...';

  @override
  String get universityAbout => 'Hakkında';

  @override
  String get universityRector => 'Rektör';

  @override
  String get universityFacultyCount => 'Fakülte / MYO';

  @override
  String get universityDepartmentCount => 'Bölüm / Program';

  @override
  String get universityFaculty => 'Fakülte';

  @override
  String get universityDepartment => 'Bölüm';

  @override
  String get universityEstablished => 'Kuruluş';

  @override
  String get academicStaff => 'Akademik Kadro';

  @override
  String academicTotal(String total) {
    return 'Toplam $total';
  }

  @override
  String get academicProfessor => 'Profesör';

  @override
  String get academicAssocProf => 'Doçent';

  @override
  String get academicDoctor => 'Doktor';

  @override
  String get academicResearchAsst => 'Ar. Gör.';

  @override
  String get academicLecturer => 'Öğr. Gör.';

  @override
  String get contactTitle => 'İletişim';

  @override
  String get contactWebsite => 'Web Sitesi';

  @override
  String get contactEmail => 'E-posta';

  @override
  String get contactPhone => 'Telefon';

  @override
  String get contactAddress => 'Adres';

  @override
  String get errorTitle => 'Bir Hata Oluştu';

  @override
  String get universityTypeState => 'Devlet';

  @override
  String get universityTypeFoundation => 'Vakıf';

  @override
  String get roleCandidate => 'Aday';

  @override
  String get roleStudent => 'Öğrenci';

  @override
  String get roleGraduate => 'Mezun';

  @override
  String get authWelcome => 'Hoş Geldiniz';

  @override
  String get authWelcomeSubtitle => 'Hesabınıza giriş yapın';

  @override
  String get authLoginTitle => 'Giriş Yap';

  @override
  String get authRegisterTitle => 'Kayıt Ol';

  @override
  String get authEmail => 'E-posta';

  @override
  String get authEmailHint => 'ornek@email.com';

  @override
  String get authPassword => 'Şifre';

  @override
  String get authPasswordHint => 'Şifrenizi girin';

  @override
  String get authConfirmPassword => 'Şifre Tekrar';

  @override
  String get authConfirmPasswordHint => 'Şifrenizi tekrar girin';

  @override
  String get authFullName => 'Ad Soyad';

  @override
  String get authFullNameHint => 'Adınızı ve soyadınızı girin';

  @override
  String get authLoginButton => 'Giriş Yap';

  @override
  String get authRegisterButton => 'Kayıt Ol';

  @override
  String get authNoAccount => 'Hesabınız yok mu?';

  @override
  String get authHaveAccount => 'Zaten hesabınız var mı?';

  @override
  String get authSelectStatus => 'Durumunuzu Seçin';

  @override
  String get authHighSchool => 'Lise Öğrencisi';

  @override
  String get authHighSchoolDesc =>
      'Üniversite sınavına hazırlanan lise öğrencisi';

  @override
  String get authUniversity => 'Üniversite Öğrencisi';

  @override
  String get authUniversityDesc => 'Halen bir üniversitede okuyan öğrenci';

  @override
  String get authGraduate => 'Mezun';

  @override
  String get authGraduateDesc => 'Üniversiteden mezun olmuş';

  @override
  String get authSelectGrade => 'Sınıfınızı Seçin';

  @override
  String get authSelectUniversity => 'Üniversitenizi Seçin';

  @override
  String get authSelectDepartment => 'Bölümünüzü Seçin';

  @override
  String authGrade(int grade) {
    return '$grade. Sınıf';
  }

  @override
  String get authStepCredentials => 'Bilgiler';

  @override
  String get authStepStatus => 'Durum';

  @override
  String get authStepDetails => 'Detaylar';

  @override
  String get authNext => 'Devam';

  @override
  String get authBack => 'Geri';

  @override
  String get authLoginError => 'E-posta veya şifre hatalı';

  @override
  String get authRegisterError => 'Kayıt sırasında bir hata oluştu';

  @override
  String get authFieldRequired => 'Bu alan zorunludur';

  @override
  String get authInvalidEmail => 'Geçerli bir e-posta adresi girin';

  @override
  String get authPasswordTooShort => 'Şifre en az 6 karakter olmalıdır';

  @override
  String get authPasswordsNotMatch => 'Şifreler eşleşmiyor';

  @override
  String get authOrDivider => 'veya';

  @override
  String get authGuestLogin => 'Misafir olarak devam et';

  @override
  String get settingsLogoutConfirm =>
      'Hesabınızdan çıkış yapmak istediğinize emin misiniz?';

  @override
  String get settingsCancel => 'İptal';

  @override
  String get forumLike => 'Beğen';

  @override
  String get roleUser => 'Kullanıcı';

  @override
  String get roleAnonymous => 'Anonim';
}
