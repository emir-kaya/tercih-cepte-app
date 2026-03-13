import '../../domain/entities/university_detail.dart';

class UniversityDetailModel extends UniversityDetail {
  const UniversityDetailModel({
    required super.id,
    required super.name,
    required super.type,
    required super.foundedYear,
    required super.city,
    required super.address,
    required super.website,
    required super.email,
    required super.phone,
    required super.rector,
    required super.facultyCount,
    required super.departmentCount,
    required super.academicStaff,
  });

  factory UniversityDetailModel.fromJson(Map<String, dynamic> json) {
    return UniversityDetailModel(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      foundedYear: json['foundedYear'] as int,
      city: json['city'] as String,
      address: json['address'] as String,
      website: json['website'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      rector: json['rector'] as String,
      facultyCount: json['facultyCount'] as String,
      departmentCount: json['departmentCount'] as String,
      academicStaff: AcademicStaffModel.fromJson(
        json['academicStaff'] as Map<String, dynamic>,
      ),
    );
  }
}

class AcademicStaffModel extends AcademicStaff {
  const AcademicStaffModel({
    required super.professor,
    required super.associateProfessor,
    required super.doctor,
    required super.researchAssistant,
    required super.lecturer,
  });

  factory AcademicStaffModel.fromJson(Map<String, dynamic> json) {
    return AcademicStaffModel(
      professor: json['professor'] as int,
      associateProfessor: json['associateProfessor'] as int,
      doctor: json['doctor'] as int,
      researchAssistant: json['researchAssistant'] as int,
      lecturer: json['lecturer'] as int,
    );
  }
}
