#!/bin/bash

# Script to generate necessary Flutter code files

echo "🔨 Generating code files..."

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Generate code for models and freezed classes
echo "❄️  Generating freezed and JSON serializable classes..."
flutter pub run build_runner build --delete-conflicting-outputs

# Clean and analyze
echo "🧹 Cleaning project..."
flutter clean

echo "✅ Code generation complete!"
