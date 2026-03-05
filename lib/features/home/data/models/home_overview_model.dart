import '../../domain/entities/home_overview.dart';
import 'dashboard_stats_model.dart';
import 'featured_university_model.dart';

class HomeOverviewModel extends HomeOverview {
  const HomeOverviewModel({
    required DashboardStatsModel stats,
    required List<FeaturedUniversityModel> featuredUniversities,
  }) : super(stats: stats, featuredUniversities: featuredUniversities);

  factory HomeOverviewModel.fromJson(Map<String, dynamic> json) {
    return HomeOverviewModel(
      stats: DashboardStatsModel.fromJson(json['stats'] as Map<String, dynamic>),
      featuredUniversities: (json['featuredUniversities'] as List<dynamic>)
          .map((e) => FeaturedUniversityModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stats': (stats as DashboardStatsModel).toJson(),
      'featuredUniversities': (featuredUniversities as List<FeaturedUniversityModel>)
          .map((e) => e.toJson())
          .toList(),
    };
  }
}
