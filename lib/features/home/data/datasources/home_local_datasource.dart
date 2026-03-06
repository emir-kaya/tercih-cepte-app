import '../models/dashboard_stats_model.dart';
import '../models/featured_university_model.dart';
import '../models/home_overview_model.dart';

class HomeLocalDataSource {
  Future<HomeOverviewModel> getHomeOverview() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    const stats = DashboardStatsModel(
      totalUniversities: 208,
      totalDepartments: 14500,
    );

    const universities = [
      FeaturedUniversityModel(
        id: '1',
        name: 'Boğaziçi Üniversitesi',
        city: 'İstanbul',
        scoreRange: '520 - 560',
        type: 'Devlet',
        shortDescription: 'Türkiye\'nin önde gelen eğitim kurumlarından biri.',
      ),
      FeaturedUniversityModel(
        id: '2',
        name: 'Koç Üniversitesi',
        city: 'İstanbul',
        scoreRange: '500 - 540',
        type: 'Vakıf',
        shortDescription: 'Modern kampüsü ve güçlü akademik kadrosu.',
      ),
      FeaturedUniversityModel(
        id: '3',
        name: 'Bilkent Üniversitesi',
        city: 'Ankara',
        scoreRange: '490 - 540',
        type: 'Vakıf',
        shortDescription: 'Ankara\'da uluslararası standartlarda eğitim.',
      ),
      FeaturedUniversityModel(
        id: '4',
        name: 'ODTÜ',
        city: 'Ankara',
        scoreRange: '510 - 550',
        type: 'Devlet',
        shortDescription: 'Mühendislik ve fen bilimlerinde öncü kurum.',
      ),
    ];

    return const HomeOverviewModel(
      stats: stats,
      featuredUniversities: universities,
    );
  }
}
