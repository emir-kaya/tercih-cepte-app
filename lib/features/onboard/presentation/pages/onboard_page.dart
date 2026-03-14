import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/router/route_paths.dart';
import '../../../../core/locale/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/onboard_page_data.dart';
import '../widgets/onboard_bottom_bar.dart';
import '../widgets/onboard_dots_indicator.dart';
import '../widgets/onboard_page_view.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  final _pageController = PageController();
  int _currentIndex = 0;

  List<OnboardPageData> _getPages(L10n t) => [
    OnboardPageData(
      title: t.onboardTitle1,
      description: t.onboardDesc1,
      icon: Icons.school_rounded,
      gradientColors: [AppColors.primary, AppColors.primaryDark],
    ),
    OnboardPageData(
      title: t.onboardTitle2,
      description: t.onboardDesc2,
      icon: Icons.forum_rounded,
      gradientColors: [AppColors.accent, AppColors.accentDark],
    ),
    OnboardPageData(
      title: t.onboardTitle3,
      description: t.onboardDesc3,
      icon: Icons.auto_awesome_rounded,
      gradientColors: [AppColors.info, const Color(0xFF1D4ED8)],
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete', true);
    if (mounted) context.go(RoutePaths.auth);
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final colors = context.appColors;
    final pages = _getPages(context.l10n);

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Page view
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                onPageChanged: (index) => setState(() => _currentIndex = index),
                itemBuilder: (context, index) {
                  return OnboardPageView(data: pages[index]);
                },
              ),
            ),

            // Dots
            OnboardDotsIndicator(
              count: pages.length,
              currentIndex: _currentIndex,
            ),
            const SizedBox(height: AppSpacing.xl),

            // Bottom bar
            OnboardBottomBar(
              currentIndex: _currentIndex,
              totalPages: pages.length,
              onNext: _nextPage,
              onSkip: _completeOnboarding,
              onGetStarted: _completeOnboarding,
            ),
            SizedBox(height: bottomPadding + AppSpacing.l),
          ],
        ),
      ),
    );
  }
}
