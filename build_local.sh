#!/bin/bash

# Local build script for TasteWay

set -e

echo "🚀 TasteWay Build Script"
echo "========================"

# Check Flutter installation
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter не установлен!"
    exit 1
fi

echo "✓ Flutter найден"

# Get Flutter version
FLUTTER_VERSION=$(flutter --version | head -n 1)
echo "  $FLUTTER_VERSION"

# Clean previous builds
echo ""
echo "🧹 Очистка предыдущих сборок..."
flutter clean

# Get dependencies
echo ""
echo "📦 Загрузка зависимостей..."
flutter pub get

# Generate code
echo ""
echo "❄️  Генерация кода (freezed, JSON serialization)..."
flutter pub run build_runner build --delete-conflicting-outputs

# Run analyzer
echo ""
echo "🔍 Анализ кода..."
flutter analyze

# Run tests
echo ""
echo "🧪 Запуск тестов..."
flutter test

# Build APK
echo ""
echo "📱 Сборка APK в режиме Release..."
flutter build apk --release

echo ""
echo "✅ Сборка завершена успешно!"
echo "📁 APK находится в: build/app/outputs/flutter-apk/app-release.apk"
