import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of L10n
/// returned by `L10n.of(context)`.
///
/// Applications need to include `L10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: L10n.localizationsDelegates,
///   supportedLocales: L10n.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the L10n.supportedLocales
/// property.
abstract class L10n {
  L10n(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L10n of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n)!;
  }

  static const LocalizationsDelegate<L10n> delegate = _L10nDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr'),
  ];

  /// App title
  ///
  /// In tr, this message translates to:
  /// **'Üniversite Tercih Asistanı'**
  String get appName;

  /// Generic error message
  ///
  /// In tr, this message translates to:
  /// **'Bir hata oluştu. Lütfen tekrar deneyin.'**
  String get defaultErrorMessage;

  /// Retry button
  ///
  /// In tr, this message translates to:
  /// **'Tekrar Dene'**
  String get retry;

  /// Bottom nav home label
  ///
  /// In tr, this message translates to:
  /// **'Ana Sayfa'**
  String get navHome;

  /// Bottom nav forum label
  ///
  /// In tr, this message translates to:
  /// **'Forum'**
  String get navForum;

  /// Bottom nav profile label
  ///
  /// In tr, this message translates to:
  /// **'Profil'**
  String get navProfile;

  /// Home header greeting
  ///
  /// In tr, this message translates to:
  /// **'Merhaba, {name} 👋'**
  String homeGreeting(String name);

  /// Home header subtitle
  ///
  /// In tr, this message translates to:
  /// **'Bugün hedefine bir adım daha yaklaş.'**
  String get homeSubtitle;

  /// Home search field placeholder
  ///
  /// In tr, this message translates to:
  /// **'Üniversite, bölüm, ders ara...'**
  String get homeSearchHint;

  /// Dashboard section title
  ///
  /// In tr, this message translates to:
  /// **'Sisteme Bakış'**
  String get homeSystemOverview;

  /// Dashboard university card title
  ///
  /// In tr, this message translates to:
  /// **'Üniversite'**
  String get homeUniversity;

  /// Dashboard department card title
  ///
  /// In tr, this message translates to:
  /// **'Bölüm'**
  String get homeDepartment;

  /// Featured universities section title
  ///
  /// In tr, this message translates to:
  /// **'Öne Çıkan Üniversiteler'**
  String get homeFeaturedUniversities;

  /// Profile page title
  ///
  /// In tr, this message translates to:
  /// **'Profil'**
  String get profileTitle;

  /// Profile user name (mock)
  ///
  /// In tr, this message translates to:
  /// **'Emir Kaya'**
  String get profileName;

  /// Profile user role (mock)
  ///
  /// In tr, this message translates to:
  /// **'12. Sınıf Öğrencisi'**
  String get profileRole;

  /// Wizard action title
  ///
  /// In tr, this message translates to:
  /// **'Tercih Sihirbazı'**
  String get profileWizardTitle;

  /// Wizard action subtitle
  ///
  /// In tr, this message translates to:
  /// **'Sana en uygun bölümü birlikte keşfedelim'**
  String get profileWizardSubtitle;

  /// Settings section title
  ///
  /// In tr, this message translates to:
  /// **'Uygulama Ayarları'**
  String get settingsAppSettings;

  /// Theme setting label
  ///
  /// In tr, this message translates to:
  /// **'Tema'**
  String get settingsTheme;

  /// Language setting label
  ///
  /// In tr, this message translates to:
  /// **'Uygulama Dili'**
  String get settingsLanguage;

  /// Notifications setting label
  ///
  /// In tr, this message translates to:
  /// **'Bildirimler'**
  String get settingsNotifications;

  /// Account section title
  ///
  /// In tr, this message translates to:
  /// **'Hesap'**
  String get settingsAccount;

  /// Edit profile setting
  ///
  /// In tr, this message translates to:
  /// **'Profilimi Düzenle'**
  String get settingsEditProfile;

  /// Logout setting
  ///
  /// In tr, this message translates to:
  /// **'Çıkış Yap'**
  String get settingsLogout;

  /// Turkish language name
  ///
  /// In tr, this message translates to:
  /// **'Türkçe'**
  String get languageTurkish;

  /// English language name
  ///
  /// In tr, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// Splash screen title
  ///
  /// In tr, this message translates to:
  /// **'TERCİH CEPTE'**
  String get splashTitle;

  /// Splash screen subtitle
  ///
  /// In tr, this message translates to:
  /// **'Geleceğine hazır mısın?'**
  String get splashSubtitle;

  /// Splash screen bottom text
  ///
  /// In tr, this message translates to:
  /// **'Üniversite yolculuğunuzda yanınızdayız'**
  String get splashBottomText;

  /// Onboard page 1 title
  ///
  /// In tr, this message translates to:
  /// **'Üniversiteni Keşfet'**
  String get onboardTitle1;

  /// Onboard page 1 description
  ///
  /// In tr, this message translates to:
  /// **'Türkiye\'deki tüm üniversiteleri detaylı bilgileriyle incele. Puan aralıkları, bölümler ve akademik kadro bilgilerine kolayca ulaş.'**
  String get onboardDesc1;

  /// Onboard page 2 title
  ///
  /// In tr, this message translates to:
  /// **'Topluluğa Katıl'**
  String get onboardTitle2;

  /// Onboard page 2 description
  ///
  /// In tr, this message translates to:
  /// **'Forum alanında diğer öğrencilerle deneyimlerini paylaş. Sorularını sor, tavsiyeler al ve tercih sürecinde yalnız kalma.'**
  String get onboardDesc2;

  /// Onboard page 3 title
  ///
  /// In tr, this message translates to:
  /// **'Doğru Tercih Yap'**
  String get onboardTitle3;

  /// Onboard page 3 description
  ///
  /// In tr, this message translates to:
  /// **'Tercih sihirbazı ile sana en uygun bölümleri keşfet. Veriye dayalı önerilerle geleceğine güvenle adım at.'**
  String get onboardDesc3;

  /// Onboard skip button
  ///
  /// In tr, this message translates to:
  /// **'Atla'**
  String get onboardSkip;

  /// Onboard get started button
  ///
  /// In tr, this message translates to:
  /// **'Başlayalım'**
  String get onboardGetStarted;

  /// Forum page title
  ///
  /// In tr, this message translates to:
  /// **'Forum'**
  String get forumTitle;

  /// Forum page subtitle
  ///
  /// In tr, this message translates to:
  /// **'Tartış, sor, keşfet'**
  String get forumSubtitle;

  /// Forum search hint
  ///
  /// In tr, this message translates to:
  /// **'Konu, üniversite veya etiket ara...'**
  String get forumSearchHint;

  /// New topic button
  ///
  /// In tr, this message translates to:
  /// **'Yeni Konu'**
  String get forumNewTopic;

  /// No topics title
  ///
  /// In tr, this message translates to:
  /// **'Henüz Konu Yok'**
  String get forumNoTopics;

  /// No topics message
  ///
  /// In tr, this message translates to:
  /// **'İlk tartışmayı sen başlat!'**
  String get forumNoTopicsMessage;

  /// Topic detail appbar title
  ///
  /// In tr, this message translates to:
  /// **'Konu Detayı'**
  String get forumTopicDetail;

  /// Replies section title
  ///
  /// In tr, this message translates to:
  /// **'Yanıtlar'**
  String get forumReplies;

  /// No replies message
  ///
  /// In tr, this message translates to:
  /// **'Henüz yanıt yok. İlk yanıtlayan sen ol!'**
  String get forumNoReplies;

  /// Write reply button/header
  ///
  /// In tr, this message translates to:
  /// **'Yanıt Yaz'**
  String get forumWriteReply;

  /// Reply button
  ///
  /// In tr, this message translates to:
  /// **'Yanıtla'**
  String get forumReply;

  /// Reply text field hint
  ///
  /// In tr, this message translates to:
  /// **'Yanıtınızı yazın...'**
  String get forumReplyHint;

  /// Replying to indicator
  ///
  /// In tr, this message translates to:
  /// **'{name} adlı kullanıcıya yanıt'**
  String forumReplyingTo(String name);

  /// Send button
  ///
  /// In tr, this message translates to:
  /// **'Gönder'**
  String get forumSend;

  /// Reply sent toast
  ///
  /// In tr, this message translates to:
  /// **'Yanıtınız gönderildi!'**
  String get forumReplySent;

  /// Share topic button
  ///
  /// In tr, this message translates to:
  /// **'Konuyu Paylaş'**
  String get forumShareTopic;

  /// Create topic title label
  ///
  /// In tr, this message translates to:
  /// **'Başlık'**
  String get forumCreateTitle;

  /// Create topic title hint
  ///
  /// In tr, this message translates to:
  /// **'Konunun başlığını yazın...'**
  String get forumCreateTitleHint;

  /// Create topic university label
  ///
  /// In tr, this message translates to:
  /// **'Üniversite'**
  String get forumCreateUniversity;

  /// Create topic university dropdown hint
  ///
  /// In tr, this message translates to:
  /// **'Üniversite seçin'**
  String get forumCreateUniversityHint;

  /// Create topic content label
  ///
  /// In tr, this message translates to:
  /// **'İçerik'**
  String get forumCreateContent;

  /// Create topic content hint
  ///
  /// In tr, this message translates to:
  /// **'Düşüncelerinizi, sorularınızı detaylı bir şekilde yazın...'**
  String get forumCreateContentHint;

  /// Create topic tags label
  ///
  /// In tr, this message translates to:
  /// **'Etiketler'**
  String get forumCreateTags;

  /// Create topic tags helper
  ///
  /// In tr, this message translates to:
  /// **'(isteğe bağlı, en fazla 5)'**
  String get forumCreateTagsHelper;

  /// Create topic tag hint
  ///
  /// In tr, this message translates to:
  /// **'Etiket yazın...'**
  String get forumCreateTagHint;

  /// Minutes ago
  ///
  /// In tr, this message translates to:
  /// **'{minutes}d önce'**
  String timeMinutesAgo(int minutes);

  /// Hours ago
  ///
  /// In tr, this message translates to:
  /// **'{hours}sa önce'**
  String timeHoursAgo(int hours);

  /// Minutes short
  ///
  /// In tr, this message translates to:
  /// **'{minutes}d'**
  String timeMinutesShort(int minutes);

  /// Hours short
  ///
  /// In tr, this message translates to:
  /// **'{hours}s'**
  String timeHoursShort(int hours);

  /// Days short
  ///
  /// In tr, this message translates to:
  /// **'{days}g'**
  String timeDaysShort(int days);

  /// Recent searches section title
  ///
  /// In tr, this message translates to:
  /// **'Son Aramalar'**
  String get searchTitle;

  /// Search hint
  ///
  /// In tr, this message translates to:
  /// **'Üniversite, bölüm, ders ara...'**
  String get searchHint;

  /// About section title
  ///
  /// In tr, this message translates to:
  /// **'Hakkında'**
  String get universityAbout;

  /// Rector label
  ///
  /// In tr, this message translates to:
  /// **'Rektör'**
  String get universityRector;

  /// Faculty count label
  ///
  /// In tr, this message translates to:
  /// **'Fakülte / MYO'**
  String get universityFacultyCount;

  /// Department count label
  ///
  /// In tr, this message translates to:
  /// **'Bölüm / Program'**
  String get universityDepartmentCount;

  /// Faculty stat label
  ///
  /// In tr, this message translates to:
  /// **'Fakülte'**
  String get universityFaculty;

  /// Department stat label
  ///
  /// In tr, this message translates to:
  /// **'Bölüm'**
  String get universityDepartment;

  /// Established year label
  ///
  /// In tr, this message translates to:
  /// **'Kuruluş'**
  String get universityEstablished;

  /// Academic staff section title
  ///
  /// In tr, this message translates to:
  /// **'Akademik Kadro'**
  String get academicStaff;

  /// Total staff count
  ///
  /// In tr, this message translates to:
  /// **'Toplam {total}'**
  String academicTotal(String total);

  /// Professor title
  ///
  /// In tr, this message translates to:
  /// **'Profesör'**
  String get academicProfessor;

  /// Associate professor title
  ///
  /// In tr, this message translates to:
  /// **'Doçent'**
  String get academicAssocProf;

  /// Doctor title
  ///
  /// In tr, this message translates to:
  /// **'Doktor'**
  String get academicDoctor;

  /// Research assistant title
  ///
  /// In tr, this message translates to:
  /// **'Ar. Gör.'**
  String get academicResearchAsst;

  /// Lecturer title
  ///
  /// In tr, this message translates to:
  /// **'Öğr. Gör.'**
  String get academicLecturer;

  /// Contact section title
  ///
  /// In tr, this message translates to:
  /// **'İletişim'**
  String get contactTitle;

  /// Website label
  ///
  /// In tr, this message translates to:
  /// **'Web Sitesi'**
  String get contactWebsite;

  /// Email label
  ///
  /// In tr, this message translates to:
  /// **'E-posta'**
  String get contactEmail;

  /// Phone label
  ///
  /// In tr, this message translates to:
  /// **'Telefon'**
  String get contactPhone;

  /// Address label
  ///
  /// In tr, this message translates to:
  /// **'Adres'**
  String get contactAddress;

  /// Error state title
  ///
  /// In tr, this message translates to:
  /// **'Bir Hata Oluştu'**
  String get errorTitle;

  /// State university type
  ///
  /// In tr, this message translates to:
  /// **'Devlet'**
  String get universityTypeState;

  /// Foundation university type
  ///
  /// In tr, this message translates to:
  /// **'Vakıf'**
  String get universityTypeFoundation;

  /// Candidate role
  ///
  /// In tr, this message translates to:
  /// **'Aday'**
  String get roleCandidate;

  /// Student role
  ///
  /// In tr, this message translates to:
  /// **'Öğrenci'**
  String get roleStudent;

  /// Graduate role
  ///
  /// In tr, this message translates to:
  /// **'Mezun'**
  String get roleGraduate;

  /// Auth welcome title
  ///
  /// In tr, this message translates to:
  /// **'Hoş Geldiniz'**
  String get authWelcome;

  /// Auth welcome subtitle
  ///
  /// In tr, this message translates to:
  /// **'Hesabınıza giriş yapın'**
  String get authWelcomeSubtitle;

  /// Login page title
  ///
  /// In tr, this message translates to:
  /// **'Giriş Yap'**
  String get authLoginTitle;

  /// Register page title
  ///
  /// In tr, this message translates to:
  /// **'Kayıt Ol'**
  String get authRegisterTitle;

  /// Email field label
  ///
  /// In tr, this message translates to:
  /// **'E-posta'**
  String get authEmail;

  /// Email field hint
  ///
  /// In tr, this message translates to:
  /// **'ornek@email.com'**
  String get authEmailHint;

  /// Password field label
  ///
  /// In tr, this message translates to:
  /// **'Şifre'**
  String get authPassword;

  /// Password field hint
  ///
  /// In tr, this message translates to:
  /// **'Şifrenizi girin'**
  String get authPasswordHint;

  /// Confirm password field label
  ///
  /// In tr, this message translates to:
  /// **'Şifre Tekrar'**
  String get authConfirmPassword;

  /// Confirm password field hint
  ///
  /// In tr, this message translates to:
  /// **'Şifrenizi tekrar girin'**
  String get authConfirmPasswordHint;

  /// Full name field label
  ///
  /// In tr, this message translates to:
  /// **'Ad Soyad'**
  String get authFullName;

  /// Full name field hint
  ///
  /// In tr, this message translates to:
  /// **'Adınızı ve soyadınızı girin'**
  String get authFullNameHint;

  /// Login button text
  ///
  /// In tr, this message translates to:
  /// **'Giriş Yap'**
  String get authLoginButton;

  /// Register button text
  ///
  /// In tr, this message translates to:
  /// **'Kayıt Ol'**
  String get authRegisterButton;

  /// No account prompt
  ///
  /// In tr, this message translates to:
  /// **'Hesabınız yok mu?'**
  String get authNoAccount;

  /// Have account prompt
  ///
  /// In tr, this message translates to:
  /// **'Zaten hesabınız var mı?'**
  String get authHaveAccount;

  /// Select status title
  ///
  /// In tr, this message translates to:
  /// **'Durumunuzu Seçin'**
  String get authSelectStatus;

  /// High school student option
  ///
  /// In tr, this message translates to:
  /// **'Lise Öğrencisi'**
  String get authHighSchool;

  /// High school student description
  ///
  /// In tr, this message translates to:
  /// **'Üniversite sınavına hazırlanan lise öğrencisi'**
  String get authHighSchoolDesc;

  /// University student option
  ///
  /// In tr, this message translates to:
  /// **'Üniversite Öğrencisi'**
  String get authUniversity;

  /// University student description
  ///
  /// In tr, this message translates to:
  /// **'Halen bir üniversitede okuyan öğrenci'**
  String get authUniversityDesc;

  /// Graduate option
  ///
  /// In tr, this message translates to:
  /// **'Mezun'**
  String get authGraduate;

  /// Graduate description
  ///
  /// In tr, this message translates to:
  /// **'Üniversiteden mezun olmuş'**
  String get authGraduateDesc;

  /// Select grade title
  ///
  /// In tr, this message translates to:
  /// **'Sınıfınızı Seçin'**
  String get authSelectGrade;

  /// Select university title
  ///
  /// In tr, this message translates to:
  /// **'Üniversitenizi Seçin'**
  String get authSelectUniversity;

  /// Select department title
  ///
  /// In tr, this message translates to:
  /// **'Bölümünüzü Seçin'**
  String get authSelectDepartment;

  /// Grade label with number
  ///
  /// In tr, this message translates to:
  /// **'{grade}. Sınıf'**
  String authGrade(int grade);

  /// Stepper credentials label
  ///
  /// In tr, this message translates to:
  /// **'Bilgiler'**
  String get authStepCredentials;

  /// Stepper status label
  ///
  /// In tr, this message translates to:
  /// **'Durum'**
  String get authStepStatus;

  /// Stepper details label
  ///
  /// In tr, this message translates to:
  /// **'Detaylar'**
  String get authStepDetails;

  /// Next/continue button
  ///
  /// In tr, this message translates to:
  /// **'Devam'**
  String get authNext;

  /// Back button
  ///
  /// In tr, this message translates to:
  /// **'Geri'**
  String get authBack;

  /// Login error message
  ///
  /// In tr, this message translates to:
  /// **'E-posta veya şifre hatalı'**
  String get authLoginError;

  /// Register error message
  ///
  /// In tr, this message translates to:
  /// **'Kayıt sırasında bir hata oluştu'**
  String get authRegisterError;

  /// Required field validation
  ///
  /// In tr, this message translates to:
  /// **'Bu alan zorunludur'**
  String get authFieldRequired;

  /// Invalid email validation
  ///
  /// In tr, this message translates to:
  /// **'Geçerli bir e-posta adresi girin'**
  String get authInvalidEmail;

  /// Password too short validation
  ///
  /// In tr, this message translates to:
  /// **'Şifre en az 6 karakter olmalıdır'**
  String get authPasswordTooShort;

  /// Passwords not matching validation
  ///
  /// In tr, this message translates to:
  /// **'Şifreler eşleşmiyor'**
  String get authPasswordsNotMatch;

  /// Or divider text
  ///
  /// In tr, this message translates to:
  /// **'veya'**
  String get authOrDivider;

  /// Guest login button
  ///
  /// In tr, this message translates to:
  /// **'Misafir olarak devam et'**
  String get authGuestLogin;

  /// Logout confirmation message
  ///
  /// In tr, this message translates to:
  /// **'Hesabınızdan çıkış yapmak istediğinize emin misiniz?'**
  String get settingsLogoutConfirm;

  /// Cancel button
  ///
  /// In tr, this message translates to:
  /// **'İptal'**
  String get settingsCancel;

  /// Like button text
  ///
  /// In tr, this message translates to:
  /// **'Beğen'**
  String get forumLike;

  /// Default user role
  ///
  /// In tr, this message translates to:
  /// **'Kullanıcı'**
  String get roleUser;

  /// Anonymous user
  ///
  /// In tr, this message translates to:
  /// **'Anonim'**
  String get roleAnonymous;
}

class _L10nDelegate extends LocalizationsDelegate<L10n> {
  const _L10nDelegate();

  @override
  Future<L10n> load(Locale locale) {
    return SynchronousFuture<L10n>(lookupL10n(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_L10nDelegate old) => false;
}

L10n lookupL10n(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return L10nEn();
    case 'tr':
      return L10nTr();
  }

  throw FlutterError(
    'L10n.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
