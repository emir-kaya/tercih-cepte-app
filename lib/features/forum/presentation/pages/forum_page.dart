import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/injector.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/state_widgets/empty_state.dart';
import '../../../../core/widgets/state_widgets/error_state.dart';
import '../bloc/forum_bloc.dart';
import '../bloc/forum_event.dart';
import '../bloc/forum_state.dart';
import '../widgets/forum_shimmer.dart';
import '../widgets/forum_topic_card.dart';

class ForumPage extends StatelessWidget {
  const ForumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ForumBloc>()..add(LoadForumData()),
      child: const AppScaffold(
        body: _ForumContentView(),
      ),
    );
  }
}

class _ForumContentView extends StatelessWidget {
  const _ForumContentView();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ForumBloc>().add(RefreshForumData());
      },
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(top: AppSpacing.xl, left: AppSpacing.m, right: AppSpacing.m, bottom: AppSpacing.m),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Forum', style: AppTypography.h1),
                  Material(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(100),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.add_rounded, size: 20, color: AppColors.primaryLight),
                            const SizedBox(width: 6),
                            Text(
                              'Yeni Konu',
                              style: AppTypography.label.copyWith(
                                color: AppColors.primaryLight,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
              child: Column(
                children: [
                   TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Konu, üniversite veya bölüm ara...',
                      prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textSubtle),
                      filled: true,
                      fillColor: AppColors.surfaceVariant,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.m),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m).copyWith(bottom: 120), // Bottom padding for Nav Bar
            sliver: BlocBuilder<ForumBloc, ForumState>(
              builder: (context, state) {
                if (state is ForumLoading || state is ForumInitial) {
                  return const SliverFillRemaining(
                    child: ForumShimmer(),
                  );
                }

                if (state is ForumError) {
                  return SliverFillRemaining(
                    child: ErrorState(
                      message: state.message,
                      onRetry: () => context.read<ForumBloc>().add(LoadForumData()),
                    ),
                  );
                }

                if (state is ForumLoaded) {
                  if (state.topics.isEmpty) {
                    return const SliverFillRemaining(
                      child: EmptyState(
                        title: 'Henüz Konu Yok',
                        message: 'İlk tartışmayı sen başlat!',
                        icon: Icons.forum_outlined,
                      ),
                    );
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return ForumTopicCard(topic: state.topics[index]);
                      },
                      childCount: state.topics.length,
                    ),
                  );
                }

                return const SliverFillRemaining(child: SizedBox.shrink());
              },
            ),
          ),
        ],
      ),
    );
  }
}
