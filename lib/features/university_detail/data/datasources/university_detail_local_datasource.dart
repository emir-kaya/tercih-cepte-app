import '../../domain/entities/university_detail.dart';
import '../models/university_detail_model.dart';

class UniversityDetailLocalDataSource {
  final Map<String, UniversityDetailModel> _dummyData = {
    '1': const UniversityDetailModel(
      id: '1',
      name: 'Boğaziçi Üniversitesi',
      type: 'Devlet',
      foundedYear: 1863,
      city: 'İstanbul',
      address: 'Bebek / İstanbul',
      website: 'bogazici.edu.tr',
      email: 'info@bogazici.edu.tr',
      phone: '+90 212 359 54 00',
      rector: 'Prof. Dr. Naci İnci',
      facultyCount: '6 Fakülte',
      departmentCount: '34 Bölüm',
      academicStaff: AcademicStaff(
        professor: 198,
        associateProfessor: 112,
        doctor: 87,
        researchAssistant: 245,
        lecturer: 64,
      ),
    ),
    '2': const UniversityDetailModel(
      id: '2',
      name: 'Koç Üniversitesi',
      type: 'Vakıf',
      foundedYear: 1993,
      city: 'İstanbul',
      address: 'Sarıyer / İstanbul',
      website: 'ku.edu.tr',
      email: 'info@ku.edu.tr',
      phone: '+90 212 338 10 00',
      rector: 'Prof. Dr. Umran İnan',
      facultyCount: '7 Fakülte',
      departmentCount: '22 Bölüm',
      academicStaff: AcademicStaff(
        professor: 95,
        associateProfessor: 68,
        doctor: 42,
        researchAssistant: 120,
        lecturer: 35,
      ),
    ),
    '3': const UniversityDetailModel(
      id: '3',
      name: 'Bilkent Üniversitesi',
      type: 'Vakıf',
      foundedYear: 1984,
      city: 'Ankara',
      address: 'Çankaya / Ankara',
      website: 'bilkent.edu.tr',
      email: 'info@bilkent.edu.tr',
      phone: '+90 312 290 40 00',
      rector: 'Prof. Dr. Abdullah Atalar',
      facultyCount: '9 Fakülte',
      departmentCount: '31 Bölüm',
      academicStaff: AcademicStaff(
        professor: 142,
        associateProfessor: 78,
        doctor: 56,
        researchAssistant: 180,
        lecturer: 48,
      ),
    ),
    '4': const UniversityDetailModel(
      id: '4',
      name: 'ODTÜ',
      type: 'Devlet',
      foundedYear: 1956,
      city: 'Ankara',
      address: 'Çankaya / Ankara',
      website: 'metu.edu.tr',
      email: 'info@metu.edu.tr',
      phone: '+90 312 210 20 00',
      rector: 'Prof. Dr. Mustafa Verşan Kök',
      facultyCount: '5 Fakülte',
      departmentCount: '43 Bölüm',
      academicStaff: AcademicStaff(
        professor: 320,
        associateProfessor: 195,
        doctor: 134,
        researchAssistant: 410,
        lecturer: 88,
      ),
    ),
  };

  Future<UniversityDetailModel> getUniversityDetail(String id) async {
    await Future.delayed(const Duration(milliseconds: 800));

    final detail = _dummyData[id];
    if (detail != null) return detail;

    throw Exception('Üniversite bulunamadı');
  }
}
