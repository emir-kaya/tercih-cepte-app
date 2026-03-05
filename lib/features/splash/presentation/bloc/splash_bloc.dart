import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/check_initial_data.dart';

import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final CheckInitialData _checkInitialData;

  SplashBloc({
    required CheckInitialData checkInitialData,
  })  : _checkInitialData = checkInitialData,
        super(const SplashInitial()) {
    on<SplashStarted>(_onSplashStarted);
  }

  Future<void> _onSplashStarted(
    SplashStarted event,
    Emitter<SplashState> emit,
  ) async {
    emit(const SplashLoading());

    final result = await _checkInitialData();

    result.fold(
      (failure) {
        emit(SplashError(failure.message));
        // Fallback or handle error, for now we will just navigate to home instead of blocking the user
        emit(const SplashNavigationReady(target: SplashNavigationTarget.home));
      },
      (needsForceUpdate) {
        if (needsForceUpdate) {
          emit(const SplashForceUpdateRequired(
            message: 'Uygulamanın yeni bir sürümü mevcut. Lütfen güncelleyin.',
          ));
        } else {
          // If no update is required, navigate to home (or onboard/login depending on auth state later)
          emit(const SplashNavigationReady(target: SplashNavigationTarget.home));
        }
      },
    );
  }
}
