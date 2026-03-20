// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class L10nEn extends L10n {
  L10nEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'University Selection Assistant';

  @override
  String get defaultErrorMessage => 'An error occurred. Please try again.';

  @override
  String get retry => 'Retry';

  @override
  String get navHome => 'Home';

  @override
  String get navForum => 'Forum';

  @override
  String get navProfile => 'Profile';

  @override
  String homeGreeting(String name) {
    return 'Hello, $name 👋';
  }

  @override
  String get homeSubtitle => 'Take one step closer to your goal today.';

  @override
  String get homeSearchHint => 'Search university, department, course...';

  @override
  String get homeSystemOverview => 'System Overview';

  @override
  String get homeUniversity => 'University';

  @override
  String get homeDepartment => 'Department';

  @override
  String get homeFeaturedUniversities => 'Featured Universities';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileName => 'Emir Kaya';

  @override
  String get profileRole => '12th Grade Student';

  @override
  String get profileWizardTitle => 'Selection Wizard';

  @override
  String get profileWizardSubtitle =>
      'Let\'s discover the best department for you together';

  @override
  String get settingsAppSettings => 'App Settings';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsLanguage => 'App Language';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsAccount => 'Account';

  @override
  String get settingsEditProfile => 'Edit Profile';

  @override
  String get settingsLogout => 'Log Out';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageEnglish => 'English';

  @override
  String get splashTitle => 'TERCİH CEPTE';

  @override
  String get splashSubtitle => 'Are you ready for your future?';

  @override
  String get splashBottomText => 'We\'re with you on your university journey';

  @override
  String get onboardTitle1 => 'Explore Universities';

  @override
  String get onboardDesc1 =>
      'Browse all universities in Turkey with detailed information. Easily access score ranges, departments, and academic staff details.';

  @override
  String get onboardTitle2 => 'Join the Community';

  @override
  String get onboardDesc2 =>
      'Share your experiences with other students in the forum. Ask questions, get advice, and don\'t be alone in the selection process.';

  @override
  String get onboardTitle3 => 'Make the Right Choice';

  @override
  String get onboardDesc3 =>
      'Discover the best departments for you with the selection wizard. Step into your future with confidence through data-driven recommendations.';

  @override
  String get onboardSkip => 'Skip';

  @override
  String get onboardGetStarted => 'Get Started';

  @override
  String get forumTitle => 'Forum';

  @override
  String get forumSubtitle => 'Discuss, ask, explore';

  @override
  String get forumSearchHint => 'Search topic, university or tag...';

  @override
  String get forumNewTopic => 'New Topic';

  @override
  String get forumNoTopics => 'No Topics Yet';

  @override
  String get forumNoTopicsMessage => 'Be the first to start a discussion!';

  @override
  String get forumTopicDetail => 'Topic Detail';

  @override
  String get forumReplies => 'Replies';

  @override
  String get forumNoReplies => 'No replies yet. Be the first to reply!';

  @override
  String get forumWriteReply => 'Write Reply';

  @override
  String get forumReply => 'Reply';

  @override
  String get forumReplyHint => 'Write your reply...';

  @override
  String forumReplyingTo(String name) {
    return 'Replying to $name';
  }

  @override
  String get forumSend => 'Send';

  @override
  String get forumReplySent => 'Your reply has been sent!';

  @override
  String get forumShareTopic => 'Share Topic';

  @override
  String get forumCreateTitle => 'Title';

  @override
  String get forumCreateTitleHint => 'Write the topic title...';

  @override
  String get forumCreateUniversity => 'University';

  @override
  String get forumCreateUniversityHint => 'Select university';

  @override
  String get forumCreateContent => 'Content';

  @override
  String get forumCreateContentHint =>
      'Write your thoughts, questions in detail...';

  @override
  String get forumCreateTags => 'Tags';

  @override
  String get forumCreateTagsHelper => '(optional, up to 5)';

  @override
  String get forumCreateTagHint => 'Write a tag...';

  @override
  String timeMinutesAgo(int minutes) {
    return '${minutes}m ago';
  }

  @override
  String timeHoursAgo(int hours) {
    return '${hours}h ago';
  }

  @override
  String timeMinutesShort(int minutes) {
    return '${minutes}m';
  }

  @override
  String timeHoursShort(int hours) {
    return '${hours}h';
  }

  @override
  String timeDaysShort(int days) {
    return '${days}d';
  }

  @override
  String get searchTitle => 'Recent Searches';

  @override
  String get searchHint => 'Search university, department, course...';

  @override
  String get universityAbout => 'About';

  @override
  String get universityRector => 'Rector';

  @override
  String get universityFacultyCount => 'Faculty / Vocational School';

  @override
  String get universityDepartmentCount => 'Department / Program';

  @override
  String get universityFaculty => 'Faculty';

  @override
  String get universityDepartment => 'Department';

  @override
  String get universityEstablished => 'Established';

  @override
  String get academicStaff => 'Academic Staff';

  @override
  String academicTotal(String total) {
    return 'Total $total';
  }

  @override
  String get academicProfessor => 'Professor';

  @override
  String get academicAssocProf => 'Assoc. Prof.';

  @override
  String get academicDoctor => 'Doctor';

  @override
  String get academicResearchAsst => 'Research Asst.';

  @override
  String get academicLecturer => 'Lecturer';

  @override
  String get contactTitle => 'Contact';

  @override
  String get contactWebsite => 'Website';

  @override
  String get contactEmail => 'Email';

  @override
  String get contactPhone => 'Phone';

  @override
  String get contactAddress => 'Address';

  @override
  String get errorTitle => 'An Error Occurred';

  @override
  String get universityTypeState => 'State';

  @override
  String get universityTypeFoundation => 'Foundation';

  @override
  String get roleCandidate => 'Candidate';

  @override
  String get roleStudent => 'Student';

  @override
  String get roleGraduate => 'Graduate';

  @override
  String get authWelcome => 'Welcome';

  @override
  String get authWelcomeSubtitle => 'Sign in to your account';

  @override
  String get authLoginTitle => 'Sign In';

  @override
  String get authRegisterTitle => 'Sign Up';

  @override
  String get authEmail => 'Email';

  @override
  String get authEmailHint => 'example@email.com';

  @override
  String get authPassword => 'Password';

  @override
  String get authPasswordHint => 'Enter your password';

  @override
  String get authConfirmPassword => 'Confirm Password';

  @override
  String get authConfirmPasswordHint => 'Enter your password again';

  @override
  String get authFullName => 'Full Name';

  @override
  String get authFullNameHint => 'Enter your full name';

  @override
  String get authLoginButton => 'Sign In';

  @override
  String get authRegisterButton => 'Sign Up';

  @override
  String get authNoAccount => 'Don\'t have an account?';

  @override
  String get authHaveAccount => 'Already have an account?';

  @override
  String get authSelectStatus => 'Select Your Status';

  @override
  String get authHighSchool => 'High School Student';

  @override
  String get authHighSchoolDesc =>
      'High school student preparing for university exam';

  @override
  String get authUniversity => 'University Student';

  @override
  String get authUniversityDesc => 'Currently studying at a university';

  @override
  String get authGraduate => 'Graduate';

  @override
  String get authGraduateDesc => 'Graduated from university';

  @override
  String get authSelectGrade => 'Select Your Grade';

  @override
  String get authSelectUniversity => 'Select Your University';

  @override
  String get authSelectDepartment => 'Select Your Department';

  @override
  String authGrade(int grade) {
    return 'Grade $grade';
  }

  @override
  String get authStepCredentials => 'Info';

  @override
  String get authStepStatus => 'Status';

  @override
  String get authStepDetails => 'Details';

  @override
  String get authNext => 'Continue';

  @override
  String get authBack => 'Back';

  @override
  String get authLoginError => 'Invalid email or password';

  @override
  String get authRegisterError => 'An error occurred during registration';

  @override
  String get authFieldRequired => 'This field is required';

  @override
  String get authInvalidEmail => 'Enter a valid email address';

  @override
  String get authPasswordTooShort => 'Password must be at least 6 characters';

  @override
  String get authPasswordsNotMatch => 'Passwords do not match';

  @override
  String get authOrDivider => 'or';

  @override
  String get authGuestLogin => 'Continue as guest';

  @override
  String get settingsLogoutConfirm => 'Are you sure you want to log out?';

  @override
  String get settingsCancel => 'Cancel';

  @override
  String get forumLike => 'Like';

  @override
  String get roleUser => 'User';

  @override
  String get roleAnonymous => 'Anonymous';
}
