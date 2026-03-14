import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/result.dart';
import '../../../domain/usecases/login_user.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUser _loginUser;

  LoginBloc({
    required LoginUser loginUser,
  })  : _loginUser = loginUser,
        super(const LoginInitial()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  void _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    final currentState = state;
    final password = currentState is LoginInitial ? currentState.password : '';

    emit(LoginInitial(
      email: event.email,
      password: password,
    ));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final currentState = state;
    final email = currentState is LoginInitial ? currentState.email : '';

    emit(LoginInitial(
      email: email,
      password: event.password,
    ));
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    final email = event.email;
    final password = event.password;

    String? emailError;
    String? passwordError;

    if (email.isEmpty) {
      emailError = 'E-posta adresi boş bırakılamaz';
    }

    if (password.length < 6) {
      passwordError = 'Şifre en az 6 karakter olmalıdır';
    }

    if (emailError != null || passwordError != null) {
      emit(LoginInitial(
        email: email,
        password: password,
        emailError: emailError,
        passwordError: passwordError,
      ));
      return;
    }

    emit(const LoginLoading());

    final result = await _loginUser(email: email, password: password);

    switch (result) {
      case Success(:final value):
        emit(LoginSuccess(user: value));
      case Error(:final failure):
        emit(LoginFailure(
          message: failure.message,
          email: email,
          password: password,
        ));
    }
  }
}
