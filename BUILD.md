# 🚀 Сборка APK — Инструкции

## Способ 1: GitHub Actions (АВТОМАТИКА) ⭐ Рекомендуется

1. Загрузите проект на GitHub
2. Перейдите во вкладку **Actions**
3. Нажмите **"Build APK"** → **Run workflow**
4. Через 5-10 минут APK будет в разделе **Artifacts**

### Автоматический релиз
При push в `main` ветку создаётся GitHub Release с APK.

---

## Способ 2: GitHub Codespaces (с телефона)

1. Откройте репозиторий на GitHub
2. Нажмите **Code** → **Codespaces** → **Create codespace**
3. В терминале выполните:
```bash
./setup_codespaces.sh
source ~/.bashrc
cd /workspaces/tasteway_flutter
flutter pub get
flutter build apk --release
```
4. Скачайте APK: **Explorer** → `build/app/outputs/flutter-apk/` → ПКМ → **Download**

---

## Способ 3: Termux (Android)

1. Установите **Termux** из F-Droid (не Google Play!)
2. Выполните:
```bash
pkg update
pkg install -y git flutter openjdk-17
```
3. Клонируйте репозиторий и соберите:
```bash
git clone https://github.com/YOUR_USERNAME/tasteway_flutter.git
cd tasteway_flutter
flutter pub get
flutter build apk --release
```
4. APK будет в `build/app/outputs/flutter-apk/`

---

## Способ 4: Локально (Linux/Mac/Windows)

```bash
# 1. Установите Flutter: https://docs.flutter.dev/get-started/install
# 2. Клонируйте проект
git clone https://github.com/YOUR_USERNAME/tasteway_flutter.git
cd tasteway_flutter

# 3. Соберите
flutter pub get
flutter build apk --release

# APK: build/app/outputs/flutter-apk/app-release.apk
```

---

## ⚠️ Важно

### Yandex Maps API Key
Перед сборкой замените в `lib/core/constants/api_constants.dart`:
```dart
static const String yandexMapApiKey = 'YOUR_YANDEX_MAP_API_KEY';
```

Получить ключ: https://developer.tech.yandex.ru/

### Backend URL
По умолчанию API указывает на `https://api.tasteway.app`. 
Для локального тестирования измените в `lib/core/constants/api_constants.dart`.

---

## 📱 Установка APK

```bash
# Через ADB
adb install build/app/outputs/flutter-apk/app-release.apk

# Или скопируйте на телефон и установите
```

---

## 🐛 Ошибки сборки

### `flutter: command not found`
```bash
export PATH="$PATH:$HOME/flutter/bin"
```

### `JAVA_HOME not set`
```bash
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
```

### Out of memory
```bash
flutter build apk --release --target-platform android-arm64
```
