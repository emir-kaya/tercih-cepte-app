import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_university_detail.dart';
import 'university_detail_event.dart';
import 'university_detail_state.dart';

class UniversityDetailBloc extends Bloc<UniversityDetailEvent, UniversityDetailState> {
  final GetUniversityDetail _getUniversityDetail;

  UniversityDetailBloc(this._getUniversityDetail) : super(UniversityDetailInitial()) {
    on<LoadUniversityDetail>(_onLoadUniversityDetail);
  }

  Future<void> _onLoadUniversityDetail(
    LoadUniversityDetail event,
    Emitter<UniversityDetailState> emit,
  ) async {
    emit(UniversityDetailLoading());

    final result = await _getUniversityDetail(event.universityId);

    result.fold(
      (failure) => emit(UniversityDetailError(failure.message)),
      (detail) => emit(UniversityDetailLoaded(detail: detail)),
    );
  }
}
