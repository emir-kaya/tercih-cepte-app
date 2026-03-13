import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/router/route_paths.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_spacing.dart';
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

  static const _pages = [
    OnboardPageData(
      title: 'Üniversiteni Keşfet',
      description:
          'Türkiye\'deki tüm üniversiteleri detaylı bilgileriyle incele. '
          'Puan aralıkları, bölümler ve akademik kadro bilgilerine kolayca ulaş.',
      icon: Icons.school_rounded,
      gradientColors: [AppColors.primary, AppColors.primaryDark],
    ),
    OnboardPageData(
      title: 'Topluluğa Katıl',
      description:
          'Forum alanında diğer öğrencilerle deneyimlerini paylaş. '
          'Sorularını sor, tavsiyeler al ve tercih sürecinde yalnız kalma.',
      icon: Icons.forum_rounded,
      gradientColors: [AppColors.accent, AppColors.accentDark],
    ),
    OnboardPageData(
      title: 'Doğru Tercih Yap',
      description:
          'Tercih sihirbazı ile sana en uygun bölümleri keşfet. '
          'Veriye dayalı önerilerle geleceğine güvenle adım at.',
      icon: Icons.auto_awesome_rounded,
      gradientColors: [AppColors.info, Color(0xFF1D4ED8)],
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
    if (mounted) context.go(RoutePaths.home);
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
                itemCount: _pages.length,
                onPageChanged: (index) => setState(() => _currentIndex = index),
                itemBuilder: (context, index) {
                  return OnboardPageView(data: _pages[index]);
                },
              ),
            ),

            // Dots
            OnboardDotsIndicator(
              count: _pages.length,
              currentIndex: _currentIndex,
            ),
            const SizedBox(height: AppSpacing.xl),

            // Bottom bar
            OnboardBottomBar(
              currentIndex: _currentIndex,
              totalPages: _pages.length,
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
