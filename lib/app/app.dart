import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/constants/app_constants.dart';
import '../core/locale/locale_cubit.dart';
import '../core/theme/app_theme.dart';
import '../core/theme/theme_cubit.dart';
import '../l10n/app_localizations.dart';
import 'router/app_router.dart';

class TercihCepteApp extends StatelessWidget {
  const TercihCepteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => LocaleCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return BlocBuilder<LocaleCubit, Locale>(
            builder: (context, locale) {
              return MaterialApp.router(
                title: AppConstants.appName,
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeMode,
                locale: locale,
                localizationsDelegates: L10n.localizationsDelegates,
                supportedLocales: L10n.supportedLocales,
                routerConfig: AppRouter.router,
              );
            },
          );
        },
      ),
    );
  }
}
