import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_forum_replies.dart';
import 'forum_detail_event.dart';
import 'forum_detail_state.dart';

class ForumDetailBloc extends Bloc<ForumDetailEvent, ForumDetailState> {
  final GetForumReplies _getForumReplies;

  ForumDetailBloc(this._getForumReplies) : super(const ForumDetailInitial()) {
    on<LoadForumReplies>(_onLoadForumReplies);
  }

  Future<void> _onLoadForumReplies(
    LoadForumReplies event,
    Emitter<ForumDetailState> emit,
  ) async {
    emit(const ForumDetailLoading());

    final result = await _getForumReplies(event.topicId);

    result.fold(
      (failure) => emit(ForumDetailError(failure.message)),
      (replies) => emit(ForumDetailLoaded(replies)),
    );
  }
}
