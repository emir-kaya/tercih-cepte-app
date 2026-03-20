import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/failures.dart';
import '../../../../core/utils/result.dart';
import '../../domain/repositories/splash_repository.dart';

class SplashRepositoryImpl implements SplashRepository {
  static const _onboardingCompleteKey = 'onboarding_complete';

  @override
  Future<Result<bool, Failure>> checkInitialData() async {
    try {
      await Future.delayed(const Duration(milliseconds: 1500));
      return const Success(false);
    } catch (e) {
      return Error(ServerFailure(e.toString()));
    }
  }

  @override
  Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingCompleteKey) ?? false;
  }

  @override
  Future<void> setOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingCompleteKey, true);
  }

  @override
  Future<bool> isUserLoggedIn() async {
    return FirebaseAuth.instance.currentUser != null;
  }
}
