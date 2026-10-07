import 'package:tasteway/domain/entities/place.dart';

abstract class PlacesRepository {
  Future<List<Place>> getPlaces({
    double? lat,
    double? lng,
    double? radius,
  });

  Future<Place> getPlaceById(String id);

  Future<List<Place>> searchPlaces(String query);

  Future<bool> toggleFavorite(String placeId);

  Future<List<Place>> getFavorites();
}
