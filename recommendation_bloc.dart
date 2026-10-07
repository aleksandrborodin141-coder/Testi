import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasteway/data/datasources/remote/recommendation_api.dart';

part 'recommendation_event.dart';
part 'recommendation_state.dart';

class RecommendationBloc extends Bloc<RecommendationEvent, RecommendationState> {
  final RecommendationApi _api;

  RecommendationBloc({RecommendationApi? api}) 
      : _api = api ?? RecommendationApi(),
        super(RecommendationInitial()) {
    on<RecommendationRequested>(_onRecommendationRequested);
    on<SimilarPlacesRequested>(_onSimilarPlacesRequested);
  }

  Future<void> _onRecommendationRequested(
    RecommendationRequested event,
    Emitter<RecommendationState> emit,
  ) async {
    emit(RecommendationLoading());

    try {
      final response = await _api.getRecommendations(
        query: event.query,
        lat: event.latitude,
        lng: event.longitude,
      );

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'] as Map<String, dynamic>;
        final recommendations = data['recommendations'] as List<dynamic>? ?? [];

        final formatted = recommendations.map((rec) => {
          'title': rec['title'] ?? 'Рекомендация',
          'description': rec['description'] ?? '',
          'reason': rec['reason'] ?? '',
          'placeIds': (rec['suggestedPlaces'] as List<dynamic>?)?.cast<String>() ?? [],
        }).toList();

        emit(RecommendationLoaded(recommendations: formatted));
      } else {
        emit(const RecommendationError(message: 'Не удалось получить рекомендации'));
      }
    } catch (e) {
      emit(RecommendationError(message: 'Ошибка: $e'));
    }
  }

  Future<void> _onSimilarPlacesRequested(
    SimilarPlacesRequested event,
    Emitter<RecommendationState> emit,
  ) async {
    emit(RecommendationLoading());

    try {
      final response = await _api.getSimilarPlaces(
        placeName: event.placeName,
        placeCategory: event.placeCategory,
      );

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'] as Map<String, dynamic>;
        final places = data['places'] as List<dynamic>? ?? [];

        final formatted = places.map((p) => {
          'title': p['name'] ?? 'Похожее место',
          'description': p['reason'] ?? '',
          'placeIds': <String>[],
        }).toList();

        emit(RecommendationLoaded(recommendations: formatted));
      } else {
        emit(const RecommendationError(message: 'Не удалось найти похожие места'));
      }
    } catch (e) {
      emit(RecommendationError(message: 'Ошибка: $e'));
    }
  }
}
