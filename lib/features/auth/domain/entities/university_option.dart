import 'package:equatable/equatable.dart';

class UniversityOption extends Equatable {
  final String id;
  final String name;

  const UniversityOption({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
