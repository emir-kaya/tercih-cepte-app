import 'package:equatable/equatable.dart';

class DashboardStats extends Equatable {
  final int totalUniversities;
  final int totalDepartments;

  const DashboardStats({
    required this.totalUniversities,
    required this.totalDepartments,
  });

  @override
  List<Object?> get props => [totalUniversities, totalDepartments];
}
