import 'package:tasteway/domain/entities/place.dart';

class PlaceModel extends Place {
  const PlaceModel({
    required super.id,
    required super.name,
    super.description,
    super.address,
    required super.latitude,
    required super.longitude,
    super.category,
    super.cuisine,
    super.priceRange,
    super.rating,
    super.reviewCount,
    super.phone,
    super.website,
    super.images,
    super.openingHours,
    super.isFavorite,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      address: json['address'] as String?,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      category: json['category'] as String?,
      cuisine: json['cuisine'] as String?,
      priceRange: json['priceRange'] as int?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] as int? ?? 0,
      phone: json['phone'] as String?,
      website: json['website'] as String?,
      images: (json['images'] as List<dynamic>?)?.cast<String>() ?? const [],
      openingHours: json['openingHours'] as Map<String, dynamic>?,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'category': category,
      'cuisine': cuisine,
      'priceRange': priceRange,
      'rating': rating,
      'reviewCount': reviewCount,
      'phone': phone,
      'website': website,
      'images': images,
      'openingHours': openingHours,
      'isFavorite': isFavorite,
    };
  }

  PlaceModel copyWithModel({
    String? id,
    String? name,
    String? description,
    String? address,
    double? latitude,
    double? longitude,
    String? category,
    String? cuisine,
    int? priceRange,
    double? rating,
    int? reviewCount,
    String? phone,
    String? website,
    List<String>? images,
    Map<String, dynamic>? openingHours,
    bool? isFavorite,
  }) {
    return PlaceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      category: category ?? this.category,
      cuisine: cuisine ?? this.cuisine,
      priceRange: priceRange ?? this.priceRange,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      phone: phone ?? this.phone,
      website: website ?? this.website,
      images: images ?? this.images,
      openingHours: openingHours ?? this.openingHours,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
