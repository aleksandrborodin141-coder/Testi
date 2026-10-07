part of 'recommendation_bloc.dart';

abstract class RecommendationEvent extends Equatable {
  const RecommendationEvent();

  @override
  List<Object?> get props => [];
}

class RecommendationRequested extends RecommendationEvent {
  final String query;
  final double? latitude;
  final double? longitude;

  const RecommendationRequested({
    required this.query,
    this.latitude,
    this.longitude,
  });

  @override
  List<Object?> get props => [query, latitude, longitude];
}

class SimilarPlacesRequested extends RecommendationEvent {
  final String placeName;
  final String placeCategory;

  const SimilarPlacesRequested({
    required this.placeName,
    required this.placeCategory,
  });

  @override
  List<Object?> get props => [placeName, placeCategory];
}
