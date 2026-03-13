// Forum
import '../../features/forum/data/datasources/forum_local_datasource.dart';
import '../../features/forum/data/repositories/forum_repository_impl.dart';
import '../../features/forum/domain/repositories/forum_repository.dart';
import '../../features/forum/domain/usecases/get_forum_replies.dart';
import '../../features/forum/domain/usecases/get_forum_topics.dart';
import '../../features/forum/presentation/bloc/detail/forum_detail_bloc.dart';
import '../../features/forum/presentation/bloc/forum_bloc.dart';
import '../../features/home/data/datasources/home_local_datasource.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/get_home_overview.dart';
import '../../features/home/presentation/bloc/home_bloc.dart';
// Profile
import '../../features/profile/data/datasources/profile_local_datasource.dart';
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
  getIt.registerLazySingleton<ForumLocalDataSource>(() => ForumLocalDataSource());
  
  // Repositories
  getIt.registerLazySingleton<ForumRepository>(
    () => ForumRepositoryImpl(localDataSource: getIt()),
  );
  
  // Use Cases
  getIt.registerLazySingleton(() => GetForumTopics(getIt()));
  getIt.registerLazySingleton(() => GetForumReplies(getIt()));
  
  // BLoC
  getIt.registerFactory(() => ForumBloc(getIt()));
  getIt.registerFactory(() => ForumDetailBloc(getIt()));
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

void registerProfileModules() {
  // Data Sources
  getIt.registerLazySingleton<ProfileLocalDataSource>(() => ProfileLocalDataSource());
  
  // Repositories
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(),
  );
  
  // BLoC
  getIt.registerFactory(() => ProfileBloc(getIt()));
}
