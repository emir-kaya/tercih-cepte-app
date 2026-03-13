import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/injector.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/state_widgets/error_state.dart';
import '../../domain/entities/university_detail.dart';
import '../bloc/university_detail_bloc.dart';
import '../bloc/university_detail_event.dart';
import '../bloc/university_detail_state.dart';
import '../widgets/about_section.dart';
import '../widgets/academic_staff_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/detail_shimmer.dart';
import '../widgets/hero_header.dart';
import '../widgets/quick_stats.dart';

class UniversityDetailPage extends StatelessWidget {
  final String universityId;
  final String universityName;

  const UniversityDetailPage({
    super.key,
    required this.universityId,
    required this.universityName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UniversityDetailBloc>()
        ..add(LoadUniversityDetail(universityId)),
      child: AppScaffold(
        safeArea: false,
        body: BlocBuilder<UniversityDetailBloc, UniversityDetailState>(
          builder: (context, state) {
            if (state is UniversityDetailLoading || state is UniversityDetailInitial) {
              return const DetailShimmer();
            }

            if (state is UniversityDetailError) {
              return SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    child: ErrorState(
                      message: state.message,
                      onRetry: () {
                        context.read<UniversityDetailBloc>().add(
                              LoadUniversityDetail(universityId),
                            );
                      },
                    ),
                  ),
                ),
              );
            }

            if (state is UniversityDetailLoaded) {
              return _DetailContent(detail: state.detail);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _DetailContent extends StatelessWidget {
  final UniversityDetail detail;

  const _DetailContent({required this.detail});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        HeroHeader(detail: detail),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.m, AppSpacing.l, AppSpacing.m, 0),
            child: QuickStats(detail: detail),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.m, AppSpacing.l, AppSpacing.m, 0),
            child: ContactSection(detail: detail),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.m, AppSpacing.l, AppSpacing.m, 0),
            child: AboutSection(detail: detail),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: AppSpacing.l),
            child: AcademicStaffSection(staff: detail.academicStaff),
          ),
        ),

        const SliverToBoxAdapter(
          child: SizedBox(height: AppSpacing.xxl * 1.5),
        ),
      ],
    );
  }
}
