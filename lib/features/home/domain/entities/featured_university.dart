import 'package:equatable/equatable.dart';

class FeaturedUniversity extends Equatable {
  final String id;
  final String name;
  final String city;
  final String scoreRange;
  final String type; // e.g. "Devlet", "Vakıf"
  final String shortDescription;
  final String? imageUrl;

  const FeaturedUniversity({
    required this.id,
    required this.name,
    required this.city,
    required this.scoreRange,
    required this.type,
    required this.shortDescription,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        city,
        scoreRange,
        type,
        shortDescription,
        imageUrl,
      ];
}
