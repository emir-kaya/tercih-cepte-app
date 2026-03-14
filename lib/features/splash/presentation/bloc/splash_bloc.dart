import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/result.dart';
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

    switch (result) {
      case Error(:final failure):
        emit(SplashError(failure.message));
        emit(const SplashNavigationReady(target: SplashNavigationTarget.home));

      case Success(:final value):
        if (value) {
          emit(const SplashForceUpdateRequired(
            message: 'Uygulamanın yeni bir sürümü mevcut. Lütfen güncelleyin.',
          ));
        } else {
          // TODO: Onboard kontrolünü sonra aktif et
          emit(const SplashNavigationReady(target: SplashNavigationTarget.onboard));
        }
    }
  }
}
