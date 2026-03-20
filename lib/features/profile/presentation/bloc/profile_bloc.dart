import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/profile_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _repository;

  ProfileBloc(this._repository) : super(ProfileInitial()) {
    on<LoadProfileData>(_onLoadProfile);
  }

  Future<void> _onLoadProfile(
    LoadProfileData event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final user = await _repository.getCurrentUserProfile();
      emit(ProfileLoaded(user));
    } catch (e) {
      emit(const ProfileError('Profil yüklenirken bir hata oluştu'));
    }
  }
}
