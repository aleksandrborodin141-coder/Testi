import 'package:tasteway/data/datasources/remote/api_client.dart';
import 'package:tasteway/core/constants/api_constants.dart';

class RecommendationApi {
  final ApiClient _client;

  RecommendationApi({ApiClient? client}) : _client = client ?? ApiClient();

  Future<Map<String, dynamic>> getRecommendations({
    required String query,
    double? lat,
    double? lng,
  }) async {
    final response = await _client.post<Map<String, dynamic>>(
      ApiConstants.recommendations,
      data: {
        'query': query,
        if (lat != null) 'lat': lat,
        if (lng != null) 'lng': lng,
      },
    );
    return response.data ?? {};
  }

  Future<Map<String, dynamic>> getSimilarPlaces({
    required String placeName,
    required String placeCategory,
  }) async {
    final response = await _client.post<Map<String, dynamic>>(
      '${ApiConstants.recommendations}/similar',
      data: {
        'placeName': placeName,
        'placeCategory': placeCategory,
      },
    );
    return response.data ?? {};
  }
}
