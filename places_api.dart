import 'package:tasteway/data/datasources/remote/api_client.dart';
import 'package:tasteway/core/constants/api_constants.dart';

class PlacesApi {
  final ApiClient _client;

  PlacesApi({ApiClient? client}) : _client = client ?? ApiClient();

  Future<Map<String, dynamic>> getPlaces({
    double? lat,
    double? lng,
    double? radius,
    String? category,
    String? cuisine,
    int? minPrice,
    int? maxPrice,
    double? minRating,
    String? search,
    int? limit,
    int? offset,
  }) async {
    final response = await _client.get<Map<String, dynamic>>(
      ApiConstants.places,
      queryParameters: {
        if (lat != null) 'lat': lat,
        if (lng != null) 'lng': lng,
        if (radius != null) 'radius': radius,
        if (category != null) 'category': category,
        if (cuisine != null) 'cuisine': cuisine,
        if (minPrice != null) 'minPrice': minPrice,
        if (maxPrice != null) 'maxPrice': maxPrice,
        if (minRating != null) 'minRating': minRating,
        if (search != null) 'search': search,
        if (limit != null) 'limit': limit,
        if (offset != null) 'offset': offset,
      },
    );
    return response.data ?? {};
  }

  Future<Map<String, dynamic>> getPlaceById(String id) async {
    final response = await _client.get<Map<String, dynamic>>(
      '${ApiConstants.places}/$id',
    );
    return response.data ?? {};
  }

  Future<Map<String, dynamic>> toggleFavorite(String placeId) async {
    final response = await _client.post<Map<String, dynamic>>(
      '${ApiConstants.places}/$placeId/favorite',
    );
    return response.data ?? {};
  }

  Future<Map<String, dynamic>> getFavorites() async {
    final response = await _client.get<Map<String, dynamic>>(
      '${ApiConstants.places}/favorites',
    );
    return response.data ?? {};
  }
}
