import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/constants/app_constants.dart';
import '../core/theme/app_theme.dart';
import '../core/theme/theme_cubit.dart';
import 'router/app_router.dart';

class TercihCepteApp extends StatelessWidget {
  const TercihCepteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
