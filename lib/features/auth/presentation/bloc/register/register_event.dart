import 'package:equatable/equatable.dart';

import '../../../domain/entities/user_status.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class RegisterFormChanged extends RegisterEvent {
  final String fullName;
  final String email;
  final String password;
  final String confirmPassword;

  const RegisterFormChanged({
    required this.fullName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [fullName, email, password, confirmPassword];
}

class RegisterStatusSelected extends RegisterEvent {
  final UserStatus status;

  const RegisterStatusSelected(this.status);

  @override
  List<Object?> get props => [status];
}

class RegisterGradeSelected extends RegisterEvent {
  final int grade;

  const RegisterGradeSelected(this.grade);

  @override
  List<Object?> get props => [grade];
}

class RegisterUniversitySelected extends RegisterEvent {
  final String universityId;

  const RegisterUniversitySelected(this.universityId);

  @override
  List<Object?> get props => [universityId];
}

class RegisterDepartmentSelected extends RegisterEvent {
  final String departmentId;

  const RegisterDepartmentSelected(this.departmentId);

  @override
  List<Object?> get props => [departmentId];
}

class RegisterLoadUniversities extends RegisterEvent {
  const RegisterLoadUniversities();
}

class RegisterNextStep extends RegisterEvent {
  const RegisterNextStep();
}

class RegisterPreviousStep extends RegisterEvent {
  const RegisterPreviousStep();
}

class RegisterSubmitted extends RegisterEvent {
  const RegisterSubmitted();
}
