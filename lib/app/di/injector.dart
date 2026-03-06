import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../core/network/dio_client.dart';
import '../../core/network/network_client.dart';
import 'modules.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Core
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton<NetworkClient>(() => DioClient(getIt()));

  // Features
  registerSplashModules();
  registerHomeModules();
  registerForumModules();
  registerProfileModules();
}
