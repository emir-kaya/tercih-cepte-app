import 'package:equatable/equatable.dart';

import '../entities/user_status.dart';

class RegisterParams extends Equatable {
  final String fullName;
  final String email;
  final String password;
  final UserStatus status;
  final String? universityId;
  final String? departmentId;
  final int? grade;

  const RegisterParams({
    required this.fullName,
    required this.email,
    required this.password,
    required this.status,
    this.universityId,
    this.departmentId,
    this.grade,
  });

  @override
  List<Object?> get props => [
        fullName,
        email,
        password,
        status,
        universityId,
        departmentId,
        grade,
      ];
}
