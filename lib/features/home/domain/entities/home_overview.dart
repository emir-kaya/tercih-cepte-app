import 'package:equatable/equatable.dart';
import 'featured_university.dart';
import 'dashboard_stats.dart';

class HomeOverview extends Equatable {
  final DashboardStats stats;
  final List<FeaturedUniversity> featuredUniversities;

  const HomeOverview({
    required this.stats,
    required this.featuredUniversities,
  });

  @override
  List<Object?> get props => [stats, featuredUniversities];
}
