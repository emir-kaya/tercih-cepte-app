import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/di/injector.dart';
import '../../../../../core/locale/l10n_extension.dart';
import '../../../../../core/theme/app_colors_extension.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../core/widgets/app_scaffold.dart';
import '../../../../../core/widgets/app_shimmer.dart';
import '../../../../../core/widgets/state_widgets/error_state.dart';
import '../../../domain/entities/forum_topic.dart';
import '../../bloc/detail/forum_detail_bloc.dart';
import '../../bloc/detail/forum_detail_event.dart';
import '../../bloc/detail/forum_detail_state.dart';
import '../../widgets/detail/forum_post_card.dart';
import '../../widgets/detail/forum_reply_bottom_sheet.dart';
import '../../widgets/detail/forum_reply_card.dart';

class ForumDetailPage extends StatelessWidget {
  static const String routePath = 'detail';
  final ForumTopic topic;

  const ForumDetailPage({
    super.key,
    required this.topic,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final t = context.l10n;

    return BlocProvider(
      create: (context) => getIt<ForumDetailBloc>()..add(LoadForumReplies(topic.id)),
      child: AppScaffold(
        appBar: AppBar(
          backgroundColor: colors.background,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: colors.textMain, size: 20),
            onPressed: () => context.pop(),
          ),
          title: Text(
            t.forumTopicDetail,
            style: AppTypography.h3.copyWith(fontSize: 18, color: colors.textMain),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.more_horiz_rounded, color: colors.textMain),
              onPressed: () {},
            ),
          ],
        ),
        body: BlocBuilder<ForumDetailBloc, ForumDetailState>(
          builder: (context, state) {
            if (state is ForumDetailLoading || state is ForumDetailInitial) {
              return AppShimmer(
                child: CustomScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: AppSpacing.s),
                        child: Container(
                          padding: const EdgeInsets.all(AppSpacing.m),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ShimmerContainer(width: 40, height: 40, borderRadius: 20),
                                  SizedBox(width: AppSpacing.s),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ShimmerContainer(width: 120, height: 16),
                                      SizedBox(height: 4),
                                      ShimmerContainer(width: 80, height: 12),
                                    ],
                                  ),
                                  Spacer(),
                                  ShimmerContainer(width: 50, height: 12),
                                ],
                              ),
                              SizedBox(height: AppSpacing.m),
                              ShimmerContainer(width: double.infinity, height: 24),
                              SizedBox(height: AppSpacing.s),
                              ShimmerContainer(width: 200, height: 16),
                              SizedBox(height: AppSpacing.xl),
                              ShimmerContainer(width: double.infinity, height: 14),
                              SizedBox(height: 6),
                              ShimmerContainer(width: double.infinity, height: 14),
                              SizedBox(height: 6),
                              ShimmerContainer(width: double.infinity, height: 14),
                              SizedBox(height: 6),
                              ShimmerContainer(width: 200, height: 14),
                              SizedBox(height: AppSpacing.xl),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      ShimmerContainer(width: 60, height: 24, borderRadius: 12),
                                      SizedBox(width: AppSpacing.s),
                                      ShimmerContainer(width: 80, height: 24, borderRadius: 12),
                                    ],
                                  ),
                                  ShimmerContainer(width: 30, height: 24, borderRadius: 6),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(AppSpacing.l, AppSpacing.m, AppSpacing.l, AppSpacing.s),
                        child: ShimmerContainer(width: 100, height: 20),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: AppSpacing.s),
                              child: Container(
                                padding: const EdgeInsets.all(AppSpacing.m),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        ShimmerContainer(width: 32, height: 32, borderRadius: 16),
                                        SizedBox(width: AppSpacing.s),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ShimmerContainer(width: 100, height: 16),
                                            SizedBox(height: 4),
                                            ShimmerContainer(width: 60, height: 12),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: AppSpacing.m),
                                    ShimmerContainer(width: double.infinity, height: 14),
                                    SizedBox(height: 6),
                                    ShimmerContainer(width: double.infinity, height: 14),
                                    SizedBox(height: 6),
                                    ShimmerContainer(width: 150, height: 14),
                                  ],
                                ),
                              ),
                            );
                          },
                          childCount: 3,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is ForumDetailError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  child: ErrorState(
                    message: state.message,
                    onRetry: () {
                      context.read<ForumDetailBloc>().add(LoadForumReplies(topic.id));
                    },
                  ),
                ),
              );
            } else if (state is ForumDetailLoaded) {
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: AppSpacing.s),
                      child: ForumPostCard(topic: topic),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(AppSpacing.l, AppSpacing.m, AppSpacing.l, AppSpacing.s),
                      child: Text(
                        t.forumReplies,
                        style: AppTypography.h3.copyWith(fontSize: 16, color: colors.textMain),
                      ),
                    ),
                  ),

                  if (state.replies.isEmpty)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.xl),
                        child: Center(
                          child: Text(
                            t.forumNoReplies,
                            style: AppTypography.bodyMd.copyWith(color: colors.textSubtle),
                          ),
                        ),
                      ),
                    )
                  else
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: index == state.replies.length - 1 ? 100.0 : 0,
                            ),
                            child: ForumReplyCard(reply: state.replies[index]),
                          );
                        },
                        childCount: state.replies.length,
                      ),
                    ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => ForumReplyBottomSheet.show(context),
          backgroundColor: colors.primary,
          icon: const Icon(Icons.reply_rounded, color: Colors.white),
          label: Text(
            t.forumWriteReply,
            style: AppTypography.bodyMd.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          elevation: 4,
        ),
      ),
    );
  }
}
