import 'dart:math';
import 'package:tasteway/domain/entities/place.dart';

final List<Place> mockPlaces = [
  const Place(
    id: '1',
    name: 'Кокoko',
    description: 'Уютное кафе с авторской кухней и крафтовым кофе. Интерьер в скандинавском стиле.',
    address: 'ул. Рубинштейна, 15',
    latitude: 59.9355,
    longitude: 30.3451,
    category: 'cafe',
    cuisine: 'european',
    priceRange: 2,
    rating: 4.7,
    reviewCount: 342,
    phone: '+7 (812) 312-45-67',
    images: [
      'https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800',
      'https://images.unsplash.com/photo-1521017432531-fbd92d768814?w=800',
    ],
    openingHours: {
      'monday': '08:00-23:00',
      'tuesday': '08:00-23:00',
      'wednesday': '08:00-23:00',
      'thursday': '08:00-23:00',
      'friday': '08:00-01:00',
      'saturday': '09:00-01:00',
      'sunday': '09:00-23:00',
    },
  ),
  const Place(
    id: '2',
    name: 'Сыроварня',
    description: 'Ресторан с собственной сыроварней. Более 50 видов сыра и авторские блюда.',
    address: 'наб. реки Фонтанки, 50',
    latitude: 59.9343,
    longitude: 30.3351,
    category: 'restaurant',
    cuisine: 'russian',
    priceRange: 3,
    rating: 4.5,
    reviewCount: 521,
    phone: '+7 (812) 314-88-99',
    images: [
      'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800',
      'https://images.unsplash.com/photo-1559329007-40df8a9345d8?w=800',
    ],
    openingHours: {
      'monday': '12:00-23:00',
      'tuesday': '12:00-23:00',
      'wednesday': '12:00-23:00',
      'thursday': '12:00-23:00',
      'friday': '12:00-01:00',
      'saturday': '11:00-01:00',
      'sunday': '11:00-23:00',
    },
  ),
  const Place(
    id: '3',
    name: 'Пхали-Хинкали',
    description: 'Аутентичная грузинская кухня. Хинкали, хачапури и лучшие вина Кахетии.',
    address: 'ул. Марата, 4',
    latitude: 59.9300,
    longitude: 30.3600,
    category: 'restaurant',
    cuisine: 'georgian',
    priceRange: 2,
    rating: 4.8,
    reviewCount: 892,
    phone: '+7 (812) 640-20-20',
    images: [
      'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800',
      'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=800',
    ],
    openingHours: {
      'monday': '11:00-23:00',
      'tuesday': '11:00-23:00',
      'wednesday': '11:00-23:00',
      'thursday': '11:00-23:00',
      'friday': '11:00-01:00',
      'saturday': '11:00-01:00',
      'sunday': '11:00-23:00',
    },
  ),
  const Place(
    id: '4',
    name: 'Бюро',
    description: 'Крафтовый бар с 24 сортами пива на кранах. Закуски от шефа.',
    address: 'ул. Рубинштейна, 23',
    latitude: 59.9360,
    longitude: 30.3460,
    category: 'bar',
    cuisine: 'pub',
    priceRange: 2,
    rating: 4.6,
    reviewCount: 215,
    phone: '+7 (812) 640-11-11',
    images: [
      'https://images.unsplash.com/photo-1572116469696-31de0f17cc34?w=800',
    ],
    openingHours: {
      'monday': '16:00-02:00',
      'tuesday': '16:00-02:00',
      'wednesday': '16:00-02:00',
      'thursday': '16:00-03:00',
      'friday': '14:00-04:00',
      'saturday': '14:00-04:00',
      'sunday': '16:00-02:00',
    },
  ),
  const Place(
    id: '5',
    name: 'Italy Group',
    description: 'Лучшая итальянская пицца в городе. Дровяная печь, импортные ингредиенты.',
    address: 'ул. Итальянская, 2',
    latitude: 59.9380,
    longitude: 30.3250,
    category: 'restaurant',
    cuisine: 'italian',
    priceRange: 3,
    rating: 4.9,
    reviewCount: 1203,
    phone: '+7 (812) 571-77-77',
    images: [
      'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=800',
      'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=800',
    ],
    openingHours: {
      'monday': '11:00-23:00',
      'tuesday': '11:00-23:00',
      'wednesday': '11:00-23:00',
      'thursday': '11:00-23:00',
      'friday': '11:00-00:00',
      'saturday': '11:00-00:00',
      'sunday': '11:00-23:00',
    },
  ),
  const Place(
    id: '6',
    name: 'Паруса',
    description: 'Панорамный ресторан на крыше с видом на Неву. Высокая кухня.',
    address: 'Васильевский остров, 7-я линия, 34',
    latitude: 59.9420,
    longitude: 30.2800,
    category: 'restaurant',
    cuisine: 'fusion',
    priceRange: 4,
    rating: 4.4,
    reviewCount: 178,
    phone: '+7 (812) 320-16-16',
    images: [
      'https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?w=800',
    ],
    openingHours: {
      'monday': '18:00-00:00',
      'tuesday': '18:00-00:00',
      'wednesday': '18:00-00:00',
      'thursday': '18:00-01:00',
      'friday': '18:00-02:00',
      'saturday': '18:00-02:00',
      'sunday': '18:00-00:00',
    },
  ),
  const Place(
    id: '7',
    name: 'Люди как люди',
    description: 'Веганское кафе с домашней атмосферой. Смузи, салаты, десерты.',
    address: 'ул. Рубинштейна, 11',
    latitude: 59.9350,
    longitude: 30.3440,
    category: 'cafe',
    cuisine: 'vegan',
    priceRange: 1,
    rating: 4.6,
    reviewCount: 445,
    phone: '+7 (812) 640-22-22',
    images: [
      'https://images.unsplash.com/photo-1498837167922-ddd27525d352?w=800',
    ],
    openingHours: {
      'monday': '09:00-22:00',
      'tuesday': '09:00-22:00',
      'wednesday': '09:00-22:00',
      'thursday': '09:00-22:00',
      'friday': '09:00-23:00',
      'saturday': '10:00-23:00',
      'sunday': '10:00-22:00',
    },
  ),
  const Place(
    id: '8',
    name: 'Мансарда',
    description: 'Ресторан на крыше отеля «Лотте». Вид на Исаакиевский собор.',
    address: 'Перевозный пер., 2',
    latitude: 59.9330,
    longitude: 30.3050,
    category: 'restaurant',
    cuisine: 'european',
    priceRange: 5,
    rating: 4.7,
    reviewCount: 267,
    phone: '+7 (812) 610-67-00',
    images: [
      'https://images.unsplash.com/photo-1550966871-3ed3c47e2ce2?w=800',
    ],
    openingHours: {
      'monday': '12:00-23:00',
      'tuesday': '12:00-23:00',
      'wednesday': '12:00-23:00',
      'thursday': '12:00-23:00',
      'friday': '12:00-01:00',
      'saturday': '12:00-01:00',
      'sunday': '12:00-23:00',
    },
  ),
];

List<Place> getNearbyPlaces(double lat, double lng, {double radiusKm = 5.0}) {
  return mockPlaces.where((place) {
    final distance = _calculateDistance(lat, lng, place.latitude, place.longitude);
    return distance <= radiusKm;
  }).toList();
}

List<Place> searchPlaces(String query) {
  final lowerQuery = query.toLowerCase();
  return mockPlaces.where((place) {
    return place.name.toLowerCase().contains(lowerQuery) ||
        (place.cuisine?.toLowerCase().contains(lowerQuery) ?? false) ||
        (place.category?.toLowerCase().contains(lowerQuery) ?? false) ||
        (place.address?.toLowerCase().contains(lowerQuery) ?? false);
  }).toList();
}

List<Place> filterPlaces({
  String? category,
  String? cuisine,
  int? minPrice,
  int? maxPrice,
  double? minRating,
}) {
  return mockPlaces.where((place) {
    if (category != null && place.category != category) return false;
    if (cuisine != null && place.cuisine != cuisine) return false;
    if (minPrice != null && (place.priceRange ?? 0) < minPrice) return false;
    if (maxPrice != null && (place.priceRange ?? 0) > maxPrice) return false;
    if (minRating != null && place.rating < minRating) return false;
    return true;
  }).toList();
}

double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const R = 6371; // Earth's radius in km
  final dLat = _toRadians(lat2 - lat1);
  final dLon = _toRadians(lon2 - lon1);
  final a = 
      sin(dLat / 2) * sin(dLat / 2) +
      cos(_toRadians(lat1)) * cos(_toRadians(lat2)) *
      sin(dLon / 2) * sin(dLon / 2);
  final c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return R * c;
}

double _toRadians(double degrees) => degrees * pi / 180;
