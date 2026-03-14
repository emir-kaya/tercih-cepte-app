import 'package:equatable/equatable.dart';

class DepartmentOption extends Equatable {
  final String id;
  final String name;
  final String universityId;

  const DepartmentOption({
    required this.id,
    required this.name,
    required this.universityId,
  });

  @override
  List<Object?> get props => [id, name, universityId];
}
