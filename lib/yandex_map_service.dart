import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:tasteway/core/constants/map_constants.dart';
import 'package:tasteway/domain/entities/place.dart';

class YandexMapService {
  YandexMapController? _controller;

  void setController(YandexMapController controller) {
    _controller = controller;
  }

  Future<void> moveToLocation({
    required double latitude,
    required double longitude,
    double zoom = MapConstants.defaultZoom,
  }) async {
    if (_controller == null) return;

    final cameraPosition = CameraPosition(
      target: Point(latitude: latitude, longitude: longitude),
      zoom: zoom,
    );

    await _controller!.moveCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
      animation: const MapAnimation(
        type: MapAnimationType.smooth,
        duration: 0.5,
      ),
    );
  }

  Future<void> moveToUserLocation() async {
    // Will be implemented with geolocator
    await moveToLocation(
      latitude: MapConstants.defaultLatitude,
      longitude: MapConstants.defaultLongitude,
    );
  }

  Future<void> addPlaceMarkers(List<Place> places) async {
    if (_controller == null) return;

    final List<MapObject> markers = [];

    for (int i = 0; i < places.length; i++) {
      final place = places[i];
      markers.add(
        PlacemarkMapObject(
          mapId: MapObjectId('place_$i'),
          point: Point(
            latitude: place.latitude,
            longitude: place.longitude,
          ),
          icon: PlacemarkIcon.single(
            PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage('assets/images/pin.png'),
              scale: 2.0,
            ),
          ),
          opacity: 1.0,
          onTap: (_, __) {
            // Handle marker tap - will be connected to bloc
          },
        ),
      );
    }

    await _controller!.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: places.first.latitude,
            longitude: places.first.longitude,
          ),
          zoom: MapConstants.defaultZoom,
        ),
      ),
    );
  }

  Future<void> clearMarkers() async {
    if (_controller == null) return;
    // Remove all placemarks
  }

  void dispose() {
    _controller = null;
  }
}
