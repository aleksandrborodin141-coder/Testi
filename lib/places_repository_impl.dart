import 'package:tasteway/data/datasources/remote/places_api.dart';
import 'package:tasteway/data/models/place_model.dart';
import 'package:tasteway/domain/entities/place.dart';
import 'package:tasteway/domain/repositories/places_repository.dart';

class PlacesRepositoryImpl implements PlacesRepository {
  final PlacesApi _api;

  PlacesRepositoryImpl({PlacesApi? api}) : _api = api ?? PlacesApi();

  @override
  Future<List<Place>> getPlaces({
    double? lat,
    double? lng,
    double? radius,
  }) async {
    try {
      final response = await _api.getPlaces(
        lat: lat,
        lng: lng,
        radius: radius,
      );

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'] as Map<String, dynamic>;
        final places = data['places'] as List<dynamic>? ?? [];
        return places
            .map((p) => PlaceModel.fromJson(p as Map<String, dynamic>))
            .toList();
      }

      return [];
    } catch (e) {
      throw Exception('Failed to load places: $e');
    }
  }

  @override
  Future<Place> getPlaceById(String id) async {
    try {
      final response = await _api.getPlaceById(id);

      if (response['success'] == true && response['data'] != null) {
        return PlaceModel.fromJson(response['data'] as Map<String, dynamic>);
      }

      throw Exception('Place not found');
    } catch (e) {
      throw Exception('Failed to load place: $e');
    }
  }

  @override
  Future<List<Place>> searchPlaces(String query) async {
    try {
      final response = await _api.getPlaces(search: query);

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'] as Map<String, dynamic>;
        final places = data['places'] as List<dynamic>? ?? [];
        return places
            .map((p) => PlaceModel.fromJson(p as Map<String, dynamic>))
            .toList();
      }

      return [];
    } catch (e) {
      throw Exception('Failed to search places: $e');
    }
  }

  @override
  Future<bool> toggleFavorite(String placeId) async {
    try {
      final response = await _api.toggleFavorite(placeId);
      if (response['success'] == true && response['data'] != null) {
        return response['data']['isFavorite'] as bool? ?? false;
      }
      return false;
    } catch (e) {
      throw Exception('Failed to toggle favorite: $e');
    }
  }

  @override
  Future<List<Place>> getFavorites() async {
    try {
      final response = await _api.getFavorites();

      if (response['success'] == true && response['data'] != null) {
        final places = response['data'] as List<dynamic>? ?? [];
        return places
            .map((p) => PlaceModel.fromJson(p as Map<String, dynamic>))
            .toList();
      }

      return [];
    } catch (e) {
      throw Exception('Failed to load favorites: $e');
    }
  }
}
