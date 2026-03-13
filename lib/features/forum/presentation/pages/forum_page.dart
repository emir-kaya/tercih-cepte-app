import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injector.dart';
import '../../../../app/router/route_paths.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_radius.dart';
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
    final topPadding = MediaQuery.of(context).padding.top;
    final colors = context.appColors;

    return Column(
      children: [
        // Fixed header + search bar
        Container(
          color: colors.background,
          padding: EdgeInsets.only(
            top: topPadding + AppSpacing.m,
            left: AppSpacing.l,
            right: AppSpacing.l,
            bottom: AppSpacing.m,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Forum', style: AppTypography.h1.copyWith(color: colors.textMain)),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        'Tartış, sor, keşfet',
                        style: AppTypography.bodyMd.copyWith(
                          color: colors.textSubtle,
                        ),
                      ),
                    ],
                  ),
                  _buildNewTopicButton(context, colors),
                ],
              ),
              const SizedBox(height: AppSpacing.m),
              _buildSearchBar(colors),
            ],
          ),
        ),

        // Scrollable topic list
        Expanded(
          child: RefreshIndicator(
            color: colors.primary,
            backgroundColor: colors.surface,
            onRefresh: () async {
              context.read<ForumBloc>().add(RefreshForumData());
            },
            child: BlocBuilder<ForumBloc, ForumState>(
              builder: (context, state) {
                if (state is ForumLoading || state is ForumInitial) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSpacing.m),
                    child: ForumShimmer(),
                  );
                }

                if (state is ForumError) {
                  return Center(
                    child: ErrorState(
                      message: state.message,
                      onRetry: () =>
                          context.read<ForumBloc>().add(LoadForumData()),
                    ),
                  );
                }

                if (state is ForumLoaded) {
                  if (state.topics.isEmpty) {
                    return const Center(
                      child: EmptyState(
                        title: 'Henüz Konu Yok',
                        message: 'İlk tartışmayı sen başlat!',
                        icon: Icons.forum_outlined,
                      ),
                    );
                  }

                  return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m)
                        .copyWith(bottom: 120, top: AppSpacing.xs),
                    itemCount: state.topics.length,
                    itemBuilder: (context, index) {
                      return ForumTopicCard(topic: state.topics[index]);
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNewTopicButton(BuildContext context, AppColorsExtension colors) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colors.primary, colors.accent],
        ),
        borderRadius: BorderRadius.circular(AppRadius.md),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.md),
          onTap: () => context.go('${RoutePaths.forum}/${RoutePaths.forumCreate}'),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.edit_rounded, size: 18, color: Colors.white),
                SizedBox(width: 6),
                Text(
                  'Yeni Konu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(AppColorsExtension colors) {
    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: colors.border, width: 0.5),
      ),
      child: TextFormField(
        style: AppTypography.bodyMd.copyWith(color: colors.textMain),
        decoration: InputDecoration(
          hintText: 'Konu, üniversite veya etiket ara...',
          hintStyle: AppTypography.bodyMd.copyWith(color: colors.textSubtle),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 14, right: 10),
            child: Icon(Icons.search_rounded, color: colors.textSubtle, size: 22),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          filled: false,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: AppSpacing.m,
          ),
        ),
      ),
    );
  }
}
