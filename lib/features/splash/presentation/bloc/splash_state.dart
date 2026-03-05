import 'package:equatable/equatable.dart';

enum SplashNavigationTarget {
  onboard,
  login,
  home,
}

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

class SplashInitial extends SplashState {
  const SplashInitial();
}

class SplashLoading extends SplashState {
  const SplashLoading();
}

class SplashForceUpdateRequired extends SplashState {
  final String? storeUrl;
  final String? message;

  const SplashForceUpdateRequired({this.storeUrl, this.message});

  @override
  List<Object?> get props => [storeUrl, message];
}

class SplashOptionalUpdateAvailable extends SplashState {
  final String? storeUrl;
  final String? message;
  final SplashNavigationTarget navigationTarget;

  const SplashOptionalUpdateAvailable({
    this.storeUrl,
    this.message,
    required this.navigationTarget,
  });

  @override
  List<Object?> get props => [storeUrl, message, navigationTarget];
}

class SplashNavigationReady extends SplashState {
  final SplashNavigationTarget target;

  const SplashNavigationReady({required this.target});

  @override
  List<Object?> get props => [target];
}

class SplashError extends SplashState {
  final String message;

  const SplashError(this.message);

  @override
  List<Object?> get props => [message];
}
