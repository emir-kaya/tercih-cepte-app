import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injector.dart';
import '../../../../app/router/route_paths.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../bloc/splash_bloc.dart';
import '../bloc/splash_event.dart';
import '../bloc/splash_state.dart';

class SplashPage extends StatefulWidget {
  static const String routePath = '/splash';
  static const String routeName = 'splash';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _pulseController;

  // Staggered animations off _mainController (2500ms)
  late Animation<double> _iconScale;
  late Animation<double> _iconFade;
  late Animation<double> _titleFade;
  late Animation<Offset> _titleSlide;
  late Animation<double> _subtitleFade;
  late Animation<double> _bottomFade;

  // Looping pulse for the ring
  late Animation<double> _pulseScale;
  late Animation<double> _pulseFade;

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    // Main staggered entrance — 2500ms total
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    // Icon: 0%–40%
    _iconScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.4, curve: Curves.elasticOut),
      ),
    );
    _iconFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.25, curve: Curves.easeOut),
      ),
    );

    // Title: 25%–60%
    _titleFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.25, 0.55, curve: Curves.easeOut),
      ),
    );
    _titleSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.25, 0.55, curve: Curves.easeOutCubic),
      ),
    );

    // Subtitle: 45%–75%
    _subtitleFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.45, 0.75, curve: Curves.easeOut),
      ),
    );

    // Bottom loader: 60%–90%
    _bottomFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.6, 0.9, curve: Curves.easeOut),
      ),
    );

    // Looping pulse ring
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );
    _pulseScale = Tween<double>(begin: 1.0, end: 1.6).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeOut),
    );
    _pulseFade = Tween<double>(begin: 0.4, end: 0.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeOut),
    );

    _mainController.forward();
    _pulseController.repeat();
  }

  @override
  void dispose() {
    _mainController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _navigateTo(SplashNavigationTarget target) {
    if (!mounted) return;

    switch (target) {
      case SplashNavigationTarget.onboard:
        context.go(RoutePaths.onboard);
      case SplashNavigationTarget.home:
        context.go(RoutePaths.home);
      default:
        context.go(RoutePaths.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isDark = context.read<ThemeCubit>().isDark;

    // Status bar adapts to splash background
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      ),
    );

    return BlocProvider(
      create: (context) => getIt<SplashBloc>()..add(const SplashStarted()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) async {
          if (!_mainController.isCompleted) {
            try {
              await _mainController.forward().orCancel;
            } on TickerCanceled {
              return;
            }
          }

          if (!mounted) return;

          if (state is SplashNavigationReady) {
            _navigateTo(state.target);
          } else if (state is SplashForceUpdateRequired) {
            debugPrint('Update required: ${state.message}');
          }
        },
        child: Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? const [
                        Color(0xFF07101A),
                        Color(0xFF0C1820),
                        Color(0xFF0A1A1F),
                      ]
                    : [
                        colors.background,
                        const Color(0xFFE0F7FA),
                        const Color(0xFFF0FDFA),
                      ],
              ),
            ),
            child: Stack(
              children: [
                // Floating orbs
                _FloatingOrbs(isDark: isDark),

                // Main content
                SafeArea(
                  child: Column(
                    children: [
                      const Spacer(flex: 3),

                      // Icon with pulse ring
                      _buildIcon(colors, isDark),
                      const SizedBox(height: 32),

                      // Title
                      _buildTitle(colors, isDark),
                      const SizedBox(height: 12),

                      // Subtitle
                      _buildSubtitle(colors, isDark),

                      const Spacer(flex: 3),

                      // Bottom loader
                      _buildBottomLoader(colors, isDark),
                      const SizedBox(height: 48),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(AppColorsExtension colors, bool isDark) {
    return AnimatedBuilder(
      animation: _mainController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _iconFade,
          child: Transform.scale(
            scale: _iconScale.value,
            child: SizedBox(
              width: 120,
              height: 120,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Pulse ring
                  AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _pulseScale.value,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: colors.primaryLight.withValues(alpha: _pulseFade.value),
                              width: 2,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  // Glass circle
                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: isDark
                            ? [
                                colors.primary.withValues(alpha: 0.3),
                                colors.accent.withValues(alpha: 0.2),
                              ]
                            : [
                                colors.primary.withValues(alpha: 0.15),
                                colors.accent.withValues(alpha: 0.1),
                              ],
                      ),
                      border: Border.all(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.15)
                            : colors.primary.withValues(alpha: 0.2),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: colors.primary.withValues(alpha: isDark ? 0.3 : 0.2),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.school_rounded,
                      size: 40,
                      color: isDark ? Colors.white : colors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitle(AppColorsExtension colors, bool isDark) {
    return SlideTransition(
      position: _titleSlide,
      child: FadeTransition(
        opacity: _titleFade,
        child: Column(
          children: [
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: isDark
                    ? [
                        Colors.white,
                        const Color(0xFFB8F0FF),
                        colors.primaryLight,
                      ]
                    : [
                        colors.primaryDark,
                        colors.primary,
                        colors.accent,
                      ],
              ).createShader(bounds),
              child: const Text(
                'TERCİH CEPTE',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 3,
                  color: Colors.white, // ShaderMask requires white base
                  height: 1,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubtitle(AppColorsExtension colors, bool isDark) {
    return FadeTransition(
      opacity: _subtitleFade,
      child: Text(
        'Geleceğine hazır mısın?',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: isDark
              ? Colors.white.withValues(alpha: 0.6)
              : colors.textSubtle,
          letterSpacing: 0.5,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildBottomLoader(AppColorsExtension colors, bool isDark) {
    return FadeTransition(
      opacity: _bottomFade,
      child: Column(
        children: [
          const _DotLoader(),
          const SizedBox(height: 16),
          Text(
            'Üniversite yolculuğunuzda yanınızdayız',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: isDark
                  ? Colors.white.withValues(alpha: 0.35)
                  : colors.textSubtle.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// DOT LOADER — 3 pulsing dots
// ---------------------------------------------------------------------------
class _DotLoader extends StatefulWidget {
  const _DotLoader();

  @override
  State<_DotLoader> createState() => _DotLoaderState();
}

class _DotLoaderState extends State<_DotLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            final delay = index * 0.2;
            final t = (_controller.value - delay).clamp(0.0, 1.0);
            final scale = 0.5 + 0.5 * math.sin(t * math.pi);
            final opacity = 0.3 + 0.7 * math.sin(t * math.pi);

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Transform.scale(
                scale: scale,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.primaryLight.withValues(alpha: opacity),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// FLOATING ORBS — subtle background decoration
// ---------------------------------------------------------------------------
class _FloatingOrbs extends StatefulWidget {
  const _FloatingOrbs({required this.isDark});

  final bool isDark;

  @override
  State<_FloatingOrbs> createState() => _FloatingOrbsState();
}

class _FloatingOrbsState extends State<_FloatingOrbs> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final orbAlpha = widget.isDark ? 1.0 : 0.6;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value * 2 * math.pi;
        return Stack(
          children: [
            Positioned(
              top: 120 + 20 * math.sin(t),
              right: -40 + 15 * math.cos(t),
              child: _orb(160, colors.primary.withValues(alpha: 0.08 * orbAlpha)),
            ),
            Positioned(
              bottom: 200 + 15 * math.cos(t * 0.7),
              left: -60 + 10 * math.sin(t * 0.7),
              child: _orb(200, colors.accent.withValues(alpha: 0.06 * orbAlpha)),
            ),
            Positioned(
              top: 300 + 10 * math.sin(t * 1.3),
              left: 100 + 20 * math.cos(t * 1.3),
              child: _orb(80, colors.info.withValues(alpha: 0.05 * orbAlpha)),
            ),
          ],
        );
      },
    );
  }

  Widget _orb(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: size * 0.6,
            spreadRadius: size * 0.1,
          ),
        ],
      ),
    );
  }
}
