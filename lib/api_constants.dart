class ApiConstants {
  static const String baseUrl = 'https://api.tasteway.app/api/v1';
  static const String yandexMapApiKey = 'feb24f62-fc93-40b6-843e-37279dc87f23';
  static const Duration timeout = Duration(seconds: 30);

  // Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refresh = '/auth/refresh';
  static const String places = '/places';
  static const String reviews = '/reviews';
  static const String recommendations = '/recommendations';
  static const String favorites = '/favorites';
}
