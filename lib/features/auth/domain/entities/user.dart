import 'package:equatable/equatable.dart';

import 'user_status.dart';

class User extends Equatable {
  final String id;
  final String fullName;
  final String email;
  final UserStatus status;
  final String? universityName;
  final String? departmentName;
  final int? grade;

  const User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.status,
    this.universityName,
    this.departmentName,
    this.grade,
  });

  @override
  List<Object?> get props => [
        id,
        fullName,
        email,
        status,
        universityName,
        departmentName,
        grade,
      ];
}
