import 'package:equatable/equatable.dart';

class Place extends Equatable {
  final String id;
  final String name;
  final String? description;
  final String? address;
  final double latitude;
  final double longitude;
  final String? category;
  final String? cuisine;
  final int? priceRange;
  final double rating;
  final int reviewCount;
  final String? phone;
  final String? website;
  final List<String> images;
  final Map<String, dynamic>? openingHours;
  final bool isFavorite;

  const Place({
    required this.id,
    required this.name,
    this.description,
    this.address,
    required this.latitude,
    required this.longitude,
    this.category,
    this.cuisine,
    this.priceRange,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.phone,
    this.website,
    this.images = const [],
    this.openingHours,
    this.isFavorite = false,
  });

  Place copyWith({
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
    return Place(
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

  @override
  List<Object?> get props => [
    id, name, description, address, latitude, longitude,
    category, cuisine, priceRange, rating, reviewCount,
    phone, website, images, openingHours, isFavorite,
  ];
}
