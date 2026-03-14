import 'package:equatable/equatable.dart';

import '../../../domain/entities/user.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {
  final String email;
  final String password;
  final String? emailError;
  final String? passwordError;

  const LoginInitial({
    this.email = '',
    this.password = '',
    this.emailError,
    this.passwordError,
  });

  @override
  List<Object?> get props => [email, password, emailError, passwordError];
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  final User user;

  const LoginSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

class LoginFailure extends LoginState {
  final String message;
  final String email;
  final String password;

  const LoginFailure({
    required this.message,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [message, email, password];
}
