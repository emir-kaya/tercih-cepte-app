import 'package:equatable/equatable.dart';

class UniversityDetail extends Equatable {
  final String id;
  final String name;
  final String type;
  final int foundedYear;
  final String city;
  final String address;
  final String website;
  final String email;
  final String phone;
  final String rector;
  final String facultyCount;
  final String departmentCount;
  final AcademicStaff academicStaff;

  const UniversityDetail({
    required this.id,
    required this.name,
    required this.type,
    required this.foundedYear,
    required this.city,
    required this.address,
    required this.website,
    required this.email,
    required this.phone,
    required this.rector,
    required this.facultyCount,
    required this.departmentCount,
    required this.academicStaff,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        foundedYear,
        city,
        address,
        website,
        email,
        phone,
        rector,
        facultyCount,
        departmentCount,
        academicStaff,
      ];
}

class AcademicStaff extends Equatable {
  final int professor;
  final int associateProfessor;
  final int doctor;
  final int researchAssistant;
  final int lecturer;

  const AcademicStaff({
    required this.professor,
    required this.associateProfessor,
    required this.doctor,
    required this.researchAssistant,
    required this.lecturer,
  });

  @override
  List<Object?> get props => [
        professor,
        associateProfessor,
        doctor,
        researchAssistant,
        lecturer,
      ];
}
