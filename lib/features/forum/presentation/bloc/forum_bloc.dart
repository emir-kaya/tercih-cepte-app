import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_forum_topics.dart';
import 'forum_event.dart';
import 'forum_state.dart';

class ForumBloc extends Bloc<ForumEvent, ForumState> {
  final GetForumTopics _getForumTopics;

  ForumBloc(this._getForumTopics) : super(ForumInitial()) {
    on<LoadForumData>(_onLoadForumData);
    on<RefreshForumData>(_onRefreshForumData);
  }

  Future<void> _onLoadForumData(LoadForumData event, Emitter<ForumState> emit) async {
    emit(ForumLoading());
    await _fetchData(emit);
  }

  Future<void> _onRefreshForumData(RefreshForumData event, Emitter<ForumState> emit) async {
    await _fetchData(emit);
  }

  Future<void> _fetchData(Emitter<ForumState> emit) async {
    final result = await _getForumTopics();
    
    result.fold(
      (failure) => emit(ForumError(failure.message)),
      (topics) => emit(ForumLoaded(topics: topics)),
    );
  }
}
