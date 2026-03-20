// Auth
import '../../features/auth/data/datasources/auth_firebase_datasource.dart';
import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/check_auth_status.dart';
import '../../features/auth/domain/usecases/get_departments.dart';
import '../../features/auth/domain/usecases/get_universities.dart';
import '../../features/auth/domain/usecases/login_user.dart';
import '../../features/auth/domain/usecases/register_user.dart';
import '../../features/auth/presentation/bloc/login/login_bloc.dart';
import '../../features/auth/presentation/bloc/register/register_bloc.dart';
// Forum
import '../../features/forum/data/datasources/forum_firebase_datasource.dart';
import '../../features/forum/data/repositories/forum_repository_impl.dart';
import '../../features/forum/domain/repositories/forum_repository.dart';
import '../../features/forum/domain/usecases/add_forum_reply.dart';
import '../../features/forum/domain/usecases/create_forum_topic.dart';
import '../../features/forum/domain/usecases/get_forum_replies.dart';
import '../../features/forum/domain/usecases/get_forum_topics.dart';
import '../../features/forum/domain/usecases/toggle_reply_like.dart';
import '../../features/forum/domain/usecases/toggle_topic_like.dart';
import '../../features/forum/domain/usecases/toggle_topic_save.dart';
import '../../features/forum/presentation/bloc/detail/forum_detail_bloc.dart';
import '../../features/forum/presentation/bloc/forum_bloc.dart';
import '../../features/home/data/datasources/home_local_datasource.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/get_home_overview.dart';
import '../../features/home/presentation/bloc/home_bloc.dart';
// Profile
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/presentation/bloc/profile_bloc.dart';
// Splash
import '../../features/splash/data/repositories/splash_repository_impl.dart';
import '../../features/splash/domain/repositories/splash_repository.dart';
import '../../features/splash/domain/usecases/check_initial_data.dart';
import '../../features/splash/presentation/bloc/splash_bloc.dart';
// University Detail
import '../../features/university_detail/data/datasources/university_detail_local_datasource.dart';
import '../../features/university_detail/data/repositories/university_detail_repository_impl.dart';
import '../../features/university_detail/domain/repositories/university_detail_repository.dart';
import '../../features/university_detail/domain/usecases/get_university_detail.dart';
import '../../features/university_detail/presentation/bloc/university_detail_bloc.dart';
// Home
import 'injector.dart';

void registerSplashModules() {
  getIt.registerLazySingleton<SplashRepository>(() => SplashRepositoryImpl());
  getIt.registerLazySingleton(() => CheckInitialData(getIt()));
  getIt.registerFactory(() => SplashBloc(checkInitialData: getIt()));
}

void registerHomeModules() {
  // Data Sources
  getIt.registerLazySingleton<HomeLocalDataSource>(() => HomeLocalDataSource());
  
  // Repositories
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(localDataSource: getIt()),
  );
  
  // Use Cases
  getIt.registerLazySingleton(() => GetHomeOverview(getIt()));
  
  // BLoC
  getIt.registerFactory(() => HomeBloc(getIt()));
}

void registerForumModules() {
  // Data Sources
  getIt.registerLazySingleton<ForumFirebaseDataSource>(
    () => ForumFirebaseDataSource(),
  );

  // Repositories
  getIt.registerLazySingleton<ForumRepository>(
    () => ForumRepositoryImpl(firebaseDataSource: getIt()),
  );

  // Use Cases
  getIt.registerLazySingleton(() => GetForumTopics(getIt()));
  getIt.registerLazySingleton(() => GetForumReplies(getIt()));
  getIt.registerLazySingleton(() => CreateForumTopic(getIt()));
  getIt.registerLazySingleton(() => AddForumReply(getIt()));
  getIt.registerLazySingleton(() => ToggleTopicLike(getIt()));
  getIt.registerLazySingleton(() => ToggleTopicSave(getIt()));
  getIt.registerLazySingleton(() => ToggleReplyLike(getIt()));

  // BLoC
  getIt.registerFactory(() => ForumBloc(
    getForumTopics: getIt(),
    createForumTopic: getIt(),
  ));
  getIt.registerFactory(() => ForumDetailBloc(
    getForumReplies: getIt(),
    addForumReply: getIt(),
    toggleTopicLike: getIt(),
    toggleTopicSave: getIt(),
    toggleReplyLike: getIt(),
    repository: getIt(),
    firebaseDataSource: getIt(),
  ));
}

void registerUniversityDetailModules() {
  // Data Sources
  getIt.registerLazySingleton<UniversityDetailLocalDataSource>(
    () => UniversityDetailLocalDataSource(),
  );

  // Repositories
  getIt.registerLazySingleton<UniversityDetailRepository>(
    () => UniversityDetailRepositoryImpl(localDataSource: getIt()),
  );

  // Use Cases
  getIt.registerLazySingleton(() => GetUniversityDetail(getIt()));

  // BLoC
  getIt.registerFactory(() => UniversityDetailBloc(getIt()));
}

void registerAuthModules() {
  // Data Sources
  getIt.registerLazySingleton<AuthFirebaseDataSource>(
    () => AuthFirebaseDataSource(),
  );
  getIt.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSource());

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      firebaseDataSource: getIt(),
      localDataSource: getIt(),
    ),
  );

  // Use Cases
  getIt.registerLazySingleton(() => LoginUser(getIt()));
  getIt.registerLazySingleton(() => RegisterUser(getIt()));
  getIt.registerLazySingleton(() => GetUniversities(getIt()));
  getIt.registerLazySingleton(() => GetDepartments(getIt()));
  getIt.registerLazySingleton(() => CheckAuthStatus(getIt()));

  // BLoC
  getIt.registerFactory(() => LoginBloc(loginUser: getIt()));
  getIt.registerFactory(() => RegisterBloc(
    registerUser: getIt(),
    getUniversities: getIt(),
    getDepartments: getIt(),
  ));
}

void registerProfileModules() {
  // Repositories
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(firebaseDataSource: getIt()),
  );

  // BLoC
  getIt.registerFactory(() => ProfileBloc(getIt()));
}
