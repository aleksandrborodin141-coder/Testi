part of 'places_bloc.dart';

abstract class PlacesEvent extends Equatable {
  const PlacesEvent();

  @override
  List<Object?> get props => [];
}

class PlacesLoadRequested extends PlacesEvent {
  final double latitude;
  final double longitude;
  final double radiusKm;

  const PlacesLoadRequested({
    required this.latitude,
    required this.longitude,
    this.radiusKm = 5.0,
  });

  @override
  List<Object?> get props => [latitude, longitude, radiusKm];
}

class PlacesSearchRequested extends PlacesEvent {
  final String query;

  const PlacesSearchRequested({required this.query});

  @override
  List<Object?> get props => [query];
}

class PlacesFilterRequested extends PlacesEvent {
  final String? category;
  final String? cuisine;
  final int? minPrice;
  final int? maxPrice;
  final double? minRating;

  const PlacesFilterRequested({
    this.category,
    this.cuisine,
    this.minPrice,
    this.maxPrice,
    this.minRating,
  });

  @override
  List<Object?> get props => [category, cuisine, minPrice, maxPrice, minRating];
}

class PlaceToggleFavorite extends PlacesEvent {
  final String placeId;

  const PlaceToggleFavorite({required this.placeId});

  @override
  List<Object?> get props => [placeId];
}
