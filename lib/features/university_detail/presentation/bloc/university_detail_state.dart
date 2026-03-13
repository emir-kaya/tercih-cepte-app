import 'package:equatable/equatable.dart';

import '../../domain/entities/university_detail.dart';

abstract class UniversityDetailState extends Equatable {
  const UniversityDetailState();

  @override
  List<Object?> get props => [];
}

class UniversityDetailInitial extends UniversityDetailState {}

class UniversityDetailLoading extends UniversityDetailState {}

class UniversityDetailLoaded extends UniversityDetailState {
  final UniversityDetail detail;

  const UniversityDetailLoaded({required this.detail});

  @override
  List<Object?> get props => [detail];
}

class UniversityDetailError extends UniversityDetailState {
  final String message;

  const UniversityDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
