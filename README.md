# 🍽️ TasteWay - AI-Powered Place Discovery App

Мобильное приложение для поиска и открытия новых заведений с рекомендациями на основе ИИ.

## ✨ Возможности

- 🤖 AI-рекомендации заведений на основе предпочтений
- 🗺️ Интерактивная карта с Yandex Maps
- 📍 Геолокация и поиск рядом
- ⭐ Система оценок и отзывов
- ❤️ Сохранение избранных мест
- 👤 Профиль пользователя с историей
- 🔐 Безопасная авторизация

## 🛠️ Технологии

### Frontend
- **Flutter 3.24.0** - кроссплатформенный фреймворк
- **BLoC Pattern** - управление состоянием
- **Go Router** - навигация
- **Yandex MapKit** - встроенные карты

### Backend
- REST API на `https://api.tasteway.app/api/v1`
- JWT авторизация
- AI-рекомендации

### Storage
- **SharedPreferences** - локальные настройки
- **SQLite** - кэширование данных
- **Flutter Secure Storage** - безопасное хранилище

## 📋 Требования

- Flutter 3.24.0 или выше
- Dart 3.0.0 или выше
- Android SDK 21+
- Java 17
- (опционально) Yandex Maps API ключ

## 🚀 Быстрый старт

### 1. Клонирование репозитория
\`\`\`bash
git clone https://github.com/YOUR_USERNAME/tasteway_flutter.git
cd tasteway_flutter
\`\`\`

### 2. Установка зависимостей
\`\`\`bash
flutter pub get
\`\`\`

### 3. Запуск на устройстве/эмуляторе
\`\`\`bash
flutter run
\`\`\`

### 4. Сборка APK
\`\`\`bash
flutter build apk --release
# APK будет в build/app/outputs/flutter-apk/app-release.apk
\`\`\`

### 5. Сборка App Bundle для Google Play
\`\`\`bash
flutter build appbundle --release
# AppBundle будет в build/app/outputs/bundle/release/app-release.aab
\`\`\`

## ⚙️ Конфигурация

### API Configuration
Отредактируй `lib/core/constants/api_constants.dart`:
\`\`\`dart
class ApiConstants {
  static const String baseUrl = 'https://api.tasteway.app/api/v1';
  static const String yandexMapApiKey = 'YOUR_API_KEY';
  // ...
}
\`\`\`

### Yandex Maps
Получи API ключ: https://developer.tech.yandex.ru/

## 📱 Установка на Android

### Через ADB
\`\`\`bash
adb install build/app/outputs/flutter-apk/app-release.apk
\`\`\`

### Вручную
1. Скопируй APK на телефон
2. Открой файловый менеджер
3. Найди и откройте APK файл
4. Разреши установку

## 🔑 Подписание для Google Play

### Создание ключа (выполнить один раз)
\`\`\`bash
keytool -genkey -v -keystore ~/android_keystore.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias tasteway_key
\`\`\`

### Использование ключа
Создай `android/key.properties`:
\`\`\`properties
storePassword=YOUR_STORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=tasteway_key
storeFile=/path/to/android_keystore.jks
\`\`\`

Затем обнови `android/app/build.gradle` для использования签名конфига.

## 🐛 Решение проблем

### `flutter: command not found`
\`\`\`bash
export PATH="\$PATH:\$HOME/flutter/bin"
\`\`\`

### Ошибка Gradle
\`\`\`bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
\`\`\`

### Проблемы с Yandex Maps
- Проверь API ключ в `api_constants.dart`
- Убедись, что геолокация разрешена на устройстве
- Проверь интернет соединение

## 📊 Архитектура

\`\`\`
lib/
├── core/           # Общие константы, темы, конфиги
├── data/           # Репозитории, API, модели данных
├── domain/         # Бизнес-логика, сущности
├── presentation/   # UI, BLoC, экраны
└── services/       # Сервисы (локация, карты, хранилище)
\`\`\`

## 🤝 Внесение вклада

1. Сделай Fork репозитория
2. Создай feature ветку (\`git checkout -b feature/AmazingFeature\`)
3. Закоммитьте ваши изменения (\`git commit -m 'Add some AmazingFeature'\`)
4. Запушьте в ветку (\`git push origin feature/AmazingFeature\`)
5. Откройте Pull Request

## 📄 Лицензия

Проект распространяется под лицензией MIT. Смотри файл [LICENSE](LICENSE) для деталей.

## 📞 Контакты

- 📧 Email: support@tasteway.app
- 🐦 Twitter: @tasteway_app
- 💬 Telegram: @tasteway_support

## 🎯 Roadmap

- [ ] Push-уведомления
- [ ] Интеграция с системой платежей
- [ ] Социальные фичи (добавление друзей, совместные рекомендации)
- [ ] Web версия
- [ ] Desktop приложение

---

**Версия:** 0.1.0 Beta  
**Последнее обновление:** Сентябрь 2026
