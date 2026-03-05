import '../../domain/entities/dashboard_stats.dart';

class DashboardStatsModel extends DashboardStats {
  const DashboardStatsModel({
    required super.totalUniversities,
    required super.totalDepartments,
  });

  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) {
    return DashboardStatsModel(
      totalUniversities: json['totalUniversities'] as int,
      totalDepartments: json['totalDepartments'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalUniversities': totalUniversities,
      'totalDepartments': totalDepartments,
    };
  }
}
