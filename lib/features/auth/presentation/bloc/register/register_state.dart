import 'package:equatable/equatable.dart';

import '../../../domain/entities/department_option.dart';
import '../../../domain/entities/university_option.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/entities/user_status.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

class RegisterFormState extends RegisterState {
  final int currentStep;
  final String fullName;
  final String email;
  final String password;
  final String confirmPassword;
  final UserStatus? selectedStatus;
  final int? selectedGrade;
  final String? selectedUniversityId;
  final String? selectedDepartmentId;
  final List<UniversityOption> universities;
  final List<DepartmentOption> departments;
  final bool isUniversitiesLoading;
  final bool isDepartmentsLoading;
  final bool isSubmitting;
  final String? errorMessage;
  final String? fullNameError;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;

  const RegisterFormState({
    this.currentStep = 0,
    this.fullName = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.selectedStatus,
    this.selectedGrade,
    this.selectedUniversityId,
    this.selectedDepartmentId,
    this.universities = const [],
    this.departments = const [],
    this.isUniversitiesLoading = false,
    this.isDepartmentsLoading = false,
    this.isSubmitting = false,
    this.errorMessage,
    this.fullNameError,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
  });

  RegisterFormState copyWith({
    int? currentStep,
    String? fullName,
    String? email,
    String? password,
    String? confirmPassword,
    UserStatus? selectedStatus,
    int? selectedGrade,
    String? selectedUniversityId,
    String? selectedDepartmentId,
    List<UniversityOption>? universities,
    List<DepartmentOption>? departments,
    bool? isUniversitiesLoading,
    bool? isDepartmentsLoading,
    bool? isSubmitting,
    String? errorMessage,
    String? fullNameError,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    bool clearSelectedStatus = false,
    bool clearSelectedGrade = false,
    bool clearSelectedUniversityId = false,
    bool clearSelectedDepartmentId = false,
    bool clearErrorMessage = false,
    bool clearFullNameError = false,
    bool clearEmailError = false,
    bool clearPasswordError = false,
    bool clearConfirmPasswordError = false,
  }) {
    return RegisterFormState(
      currentStep: currentStep ?? this.currentStep,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      selectedStatus: clearSelectedStatus ? null : (selectedStatus ?? this.selectedStatus),
      selectedGrade: clearSelectedGrade ? null : (selectedGrade ?? this.selectedGrade),
      selectedUniversityId: clearSelectedUniversityId ? null : (selectedUniversityId ?? this.selectedUniversityId),
      selectedDepartmentId: clearSelectedDepartmentId ? null : (selectedDepartmentId ?? this.selectedDepartmentId),
      universities: universities ?? this.universities,
      departments: departments ?? this.departments,
      isUniversitiesLoading: isUniversitiesLoading ?? this.isUniversitiesLoading,
      isDepartmentsLoading: isDepartmentsLoading ?? this.isDepartmentsLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
      fullNameError: clearFullNameError ? null : (fullNameError ?? this.fullNameError),
      emailError: clearEmailError ? null : (emailError ?? this.emailError),
      passwordError: clearPasswordError ? null : (passwordError ?? this.passwordError),
      confirmPasswordError: clearConfirmPasswordError ? null : (confirmPasswordError ?? this.confirmPasswordError),
    );
  }

  @override
  List<Object?> get props => [
        currentStep,
        fullName,
        email,
        password,
        confirmPassword,
        selectedStatus,
        selectedGrade,
        selectedUniversityId,
        selectedDepartmentId,
        universities,
        departments,
        isUniversitiesLoading,
        isDepartmentsLoading,
        isSubmitting,
        errorMessage,
        fullNameError,
        emailError,
        passwordError,
        confirmPasswordError,
      ];
}

class RegisterSuccess extends RegisterState {
  final User user;

  const RegisterSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}
