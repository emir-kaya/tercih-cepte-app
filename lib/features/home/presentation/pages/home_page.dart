import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/injector.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/state_widgets/loading_state.dart';
import '../../../../core/widgets/state_widgets/error_state.dart';
import '../../../../core/theme/app_spacing.dart';

import '../widgets/home_shimmer.dart';

import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

import '../widgets/home_header.dart';
import '../widgets/home_featured_universities.dart';
import '../widgets/home_dashboard.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeBloc>()..add(LoadHomeData()),
      child: const AppScaffold(
        body: _HomeContentView(),
      ),
    );
  }
}

class _HomeContentView extends StatelessWidget {
  const _HomeContentView();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<HomeBloc>().add(RefreshHomeData());
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading || state is HomeInitial) {
            return const HomeShimmer();
          }

          if (state is HomeError) {
            return ErrorState(
              message: state.message,
              onRetry: () => context.read<HomeBloc>().add(LoadHomeData()),
            );
          }

          if (state is HomeLoaded) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpacing.m),
                  const HomeHeader(),
                  const SizedBox(height: AppSpacing.l),
                  HomeDashboard(stats: state.overview.stats),
                  const SizedBox(height: AppSpacing.xl),
                  HomeFeaturedUniversities(universities: state.overview.featuredUniversities),
                  const SizedBox(height: AppSpacing.xxl * 1.5), // Extra padding for floating bar
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
