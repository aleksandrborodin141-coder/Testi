class MapConstants {
  static const String yandexMapStyle = '''
    [
      {
        "tags": {"all": ["land"]},
        "elements": "geometry",
        "stylers": [{"color": "#f5f5f5"}]
      },
      {
        "tags": {"all": ["water"]},
        "elements": "geometry",
        "stylers": [{"color": "#c9e4f6"}]
      }
    ]
  ''';

  static const double defaultLatitude = 59.9343;  // Saint Petersburg
  static const double defaultLongitude = 30.3351;
  static const double defaultZoom = 13.0;
  static const double minZoom = 10.0;
  static const double maxZoom = 19.0;
}
