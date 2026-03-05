import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_home_overview.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeOverview _getHomeOverview;

  HomeBloc(this._getHomeOverview) : super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<RefreshHomeData>(_onRefreshHomeData);
  }

  Future<void> _onLoadHomeData(LoadHomeData event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    await _fetchData(emit);
  }

  Future<void> _onRefreshHomeData(RefreshHomeData event, Emitter<HomeState> emit) async {
    // Keep showing current data or show a small refresh indicator (not whole screen loading)
    await _fetchData(emit);
  }

  Future<void> _fetchData(Emitter<HomeState> emit) async {
    final result = await _getHomeOverview();
    
    result.fold(
      (failure) => emit(HomeError(failure.message)),
      (overview) => emit(HomeLoaded(overview: overview)),
    );
  }
}
