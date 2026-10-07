#!/bin/bash
set -e

echo "🚀 TasteWay Beta 0.1 — Build Script"
echo "===================================="

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Check Flutter
if ! command -v flutter &> /dev/null; then
    echo "${YELLOW}Flutter not found. Installing...${NC}"

    # For Codespaces / Linux
    if command -v apt &> /dev/null; then
        sudo apt update
        sudo apt install -y curl git unzip xz-utils zip libglu1-mesa

        # Download Flutter
        cd ~
        curl -o flutter_linux.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.0-stable.tar.xz
        tar xf flutter_linux.tar.xz
        export PATH="$PATH:$HOME/flutter/bin"
        echo 'export PATH="$PATH:$HOME/flutter/bin"' >> ~/.bashrc
    fi

    # For Termux
    if command -v pkg &> /dev/null; then
        pkg install -y flutter
    fi
fi

echo "${GREEN}✓ Flutter installed${NC}"
flutter --version

# Check Java
if ! command -v java &> /dev/null; then
    echo "${YELLOW}Java not found. Installing...${NC}"

    if command -v apt &> /dev/null; then
        sudo apt install -y openjdk-17-jdk
    fi

    if command -v pkg &> /dev/null; then
        pkg install -y openjdk-17
    fi
fi

echo "${GREEN}✓ Java installed${NC}"
java -version

# Install dependencies
echo "${YELLOW}Installing dependencies...${NC}"
flutter pub get

# Build APK
echo "${YELLOW}Building APK...${NC}"
flutter build apk --release

# Result
if [ -f "build/app/outputs/flutter-apk/app-release.apk" ]; then
    echo ""
    echo "${GREEN}✅ BUILD SUCCESSFUL!${NC}"
    echo ""
    echo "APK location:"
    echo "  build/app/outputs/flutter-apk/app-release.apk"
    echo ""
    echo "File size:"
    ls -lh build/app/outputs/flutter-apk/app-release.apk
    echo ""
    echo "${GREEN}Install on device:${NC}"
    echo "  adb install build/app/outputs/flutter-apk/app-release.apk"
else
    echo "${RED}❌ BUILD FAILED${NC}"
    exit 1
fi
