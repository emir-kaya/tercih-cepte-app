import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/forum/domain/entities/forum_topic.dart';
import '../../features/forum/presentation/pages/detail/forum_detail_page.dart';
import '../../features/forum/presentation/pages/forum_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/search/presentation/pages/search_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import 'main_navigation.dart';
import 'route_paths.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final GlobalKey<NavigatorState> _shellNavigatorForumKey = GlobalKey<NavigatorState>(debugLabel: 'shellForum');
final GlobalKey<NavigatorState> _shellNavigatorProfileKey = GlobalKey<NavigatorState>(debugLabel: 'shellProfile');

class AppRouter {
  AppRouter._();

  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RoutePaths.splash,
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        builder: (context, state) => const SplashPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainNavigation(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHomeKey,
            routes: [
              GoRoute(
                path: RoutePaths.home,
                builder: (context, state) => const HomePage(),
                routes: [
                  GoRoute(
                    path: RoutePaths.search,
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => const SearchPage(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorForumKey,
            routes: [
              GoRoute(
                path: RoutePaths.forum,
                builder: (context, state) => const ForumPage(),
                routes: [
                  GoRoute(
                    path: RoutePaths.forumDetail,
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) {
                      final topic = state.extra as ForumTopic;
                      return ForumDetailPage(topic: topic);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorProfileKey,
            routes: [
              GoRoute(
                path: RoutePaths.profile,
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
