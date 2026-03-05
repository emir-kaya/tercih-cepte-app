import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/profile_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _repository;

  ProfileBloc(this._repository) : super(ProfileInitial()) {
    on<LoadProfileData>((event, emit) async {
      emit(ProfileLoading());
      // Placeholder load
      await Future.delayed(const Duration(milliseconds: 500));
      emit(ProfileLoaded());
    });
  }
}
