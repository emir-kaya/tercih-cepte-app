import 'package:equatable/equatable.dart';

abstract class UniversityDetailEvent extends Equatable {
  const UniversityDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadUniversityDetail extends UniversityDetailEvent {
  final String universityId;

  const LoadUniversityDetail(this.universityId);

  @override
  List<Object> get props => [universityId];
}
