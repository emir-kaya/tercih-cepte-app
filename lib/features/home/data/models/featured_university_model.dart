import '../../domain/entities/featured_university.dart';

class FeaturedUniversityModel extends FeaturedUniversity {
  const FeaturedUniversityModel({
    required super.id,
    required super.name,
    required super.city,
    required super.scoreRange,
    required super.type,
    required super.shortDescription,
    super.imageUrl,
  });

  factory FeaturedUniversityModel.fromJson(Map<String, dynamic> json) {
    return FeaturedUniversityModel(
      id: json['id'] as String,
      name: json['name'] as String,
      city: json['city'] as String,
      scoreRange: json['scoreRange'] as String,
      type: json['type'] as String,
      shortDescription: json['shortDescription'] as String,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'city': city,
      'scoreRange': scoreRange,
      'type': type,
      'shortDescription': shortDescription,
      'imageUrl': imageUrl,
    };
  }
}
