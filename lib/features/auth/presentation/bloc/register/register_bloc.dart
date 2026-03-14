import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/result.dart';
import '../../../domain/entities/user_status.dart';
import '../../../domain/usecases/get_departments.dart';
import '../../../domain/usecases/get_universities.dart';
import '../../../domain/usecases/register_params.dart';
import '../../../domain/usecases/register_user.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUser _registerUser;
  final GetUniversities _getUniversities;
  final GetDepartments _getDepartments;

  RegisterBloc({
    required RegisterUser registerUser,
    required GetUniversities getUniversities,
    required GetDepartments getDepartments,
  })  : _registerUser = registerUser,
        _getUniversities = getUniversities,
        _getDepartments = getDepartments,
        super(const RegisterFormState()) {
    on<RegisterFormChanged>(_onFormChanged);
    on<RegisterStatusSelected>(_onStatusSelected);
    on<RegisterGradeSelected>(_onGradeSelected);
    on<RegisterUniversitySelected>(_onUniversitySelected);
    on<RegisterDepartmentSelected>(_onDepartmentSelected);
    on<RegisterLoadUniversities>(_onLoadUniversities);
    on<RegisterNextStep>(_onNextStep);
    on<RegisterPreviousStep>(_onPreviousStep);
    on<RegisterSubmitted>(_onSubmitted);
  }

  void _onFormChanged(
    RegisterFormChanged event,
    Emitter<RegisterState> emit,
  ) {
    final current = state;
    if (current is RegisterFormState) {
      emit(current.copyWith(
        fullName: event.fullName,
        email: event.email,
        password: event.password,
        confirmPassword: event.confirmPassword,
        clearFullNameError: true,
        clearEmailError: true,
        clearPasswordError: true,
        clearConfirmPasswordError: true,
        clearErrorMessage: true,
      ));
    }
  }

  void _onStatusSelected(
    RegisterStatusSelected event,
    Emitter<RegisterState> emit,
  ) {
    final current = state;
    if (current is RegisterFormState) {
      emit(current.copyWith(
        selectedStatus: event.status,
        clearSelectedGrade: true,
        clearSelectedUniversityId: true,
        clearSelectedDepartmentId: true,
      ));
    }
  }

  void _onGradeSelected(
    RegisterGradeSelected event,
    Emitter<RegisterState> emit,
  ) {
    final current = state;
    if (current is RegisterFormState) {
      emit(current.copyWith(selectedGrade: event.grade));
    }
  }

  Future<void> _onUniversitySelected(
    RegisterUniversitySelected event,
    Emitter<RegisterState> emit,
  ) async {
    final current = state;
    if (current is RegisterFormState) {
      emit(current.copyWith(
        selectedUniversityId: event.universityId,
        clearSelectedDepartmentId: true,
        isDepartmentsLoading: true,
      ));

      final result = await _getDepartments(event.universityId);

      switch (result) {
        case Success(:final value):
          final updated = state;
          if (updated is RegisterFormState) {
            emit(updated.copyWith(
              departments: value,
              isDepartmentsLoading: false,
            ));
          }
        case Error(:final failure):
          final updated = state;
          if (updated is RegisterFormState) {
            emit(updated.copyWith(
              isDepartmentsLoading: false,
              errorMessage: failure.message,
            ));
          }
      }
    }
  }

  void _onDepartmentSelected(
    RegisterDepartmentSelected event,
    Emitter<RegisterState> emit,
  ) {
    final current = state;
    if (current is RegisterFormState) {
      emit(current.copyWith(selectedDepartmentId: event.departmentId));
    }
  }

  Future<void> _onLoadUniversities(
    RegisterLoadUniversities event,
    Emitter<RegisterState> emit,
  ) async {
    final current = state;
    if (current is RegisterFormState) {
      emit(current.copyWith(isUniversitiesLoading: true));

      final result = await _getUniversities();

      switch (result) {
        case Success(:final value):
          final updated = state;
          if (updated is RegisterFormState) {
            emit(updated.copyWith(
              universities: value,
              isUniversitiesLoading: false,
            ));
          }
        case Error(:final failure):
          final updated = state;
          if (updated is RegisterFormState) {
            emit(updated.copyWith(
              isUniversitiesLoading: false,
              errorMessage: failure.message,
            ));
          }
      }
    }
  }

  void _onNextStep(
    RegisterNextStep event,
    Emitter<RegisterState> emit,
  ) {
    final current = state;
    if (current is RegisterFormState) {
      // Validate current step
      if (current.currentStep == 0) {
        String? fullNameError;
        String? emailError;
        String? passwordError;
        String? confirmPasswordError;

        if (current.fullName.isEmpty) {
          fullNameError = 'Bu alan zorunludur';
        }
        if (current.email.isEmpty) {
          emailError = 'Bu alan zorunludur';
        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
            .hasMatch(current.email)) {
          emailError = 'Gecerli bir e-posta adresi girin';
        }
        if (current.password.length < 6) {
          passwordError = 'Sifre en az 6 karakter olmalidir';
        }
        if (current.confirmPassword != current.password) {
          confirmPasswordError = 'Sifreler eslesmiyor';
        }

        if (fullNameError != null ||
            emailError != null ||
            passwordError != null ||
            confirmPasswordError != null) {
          emit(current.copyWith(
            fullNameError: fullNameError,
            emailError: emailError,
            passwordError: passwordError,
            confirmPasswordError: confirmPasswordError,
          ));
          return;
        }
      }

      if (current.currentStep == 1 && current.selectedStatus == null) {
        return;
      }

      final nextStep = current.currentStep + 1;
      emit(current.copyWith(
        currentStep: nextStep,
        clearFullNameError: true,
        clearEmailError: true,
        clearPasswordError: true,
        clearConfirmPasswordError: true,
      ));

      // Load universities when entering details step with university status
      if (nextStep == 2 &&
          current.selectedStatus == UserStatus.university &&
          current.universities.isEmpty) {
        add(const RegisterLoadUniversities());
      }
    }
  }

  void _onPreviousStep(
    RegisterPreviousStep event,
    Emitter<RegisterState> emit,
  ) {
    final current = state;
    if (current is RegisterFormState && current.currentStep > 0) {
      emit(current.copyWith(currentStep: current.currentStep - 1));
    }
  }

  Future<void> _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    final current = state;
    if (current is RegisterFormState) {
      emit(current.copyWith(isSubmitting: true, clearErrorMessage: true));

      final params = RegisterParams(
        fullName: current.fullName,
        email: current.email,
        password: current.password,
        status: current.selectedStatus ?? UserStatus.highSchool,
        universityId: current.selectedUniversityId,
        departmentId: current.selectedDepartmentId,
        grade: current.selectedGrade,
      );

      final result = await _registerUser(params);

      switch (result) {
        case Success(:final value):
          emit(RegisterSuccess(user: value));
        case Error(:final failure):
          emit(current.copyWith(
            isSubmitting: false,
            errorMessage: failure.message,
          ));
      }
    }
  }
}
