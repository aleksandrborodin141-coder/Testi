#!/bin/bash
# Run this in GitHub Codespaces terminal

echo "Setting up TasteWay build environment..."

# Install Flutter
sudo apt update
sudo apt install -y curl git unzip xz-utils zip libglu1-mesa openjdk-17-jdk

cd ~
if [ ! -d "flutter" ]; then
    curl -o flutter.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.0-stable.tar.xz
    tar xf flutter.tar.xz
    rm flutter.tar.xz
fi

export PATH="$PATH:$HOME/flutter/bin"
echo 'export PATH="$PATH:$HOME/flutter/bin"' >> ~/.bashrc

# Verify
flutter doctor
flutter --version

echo "✅ Setup complete! Now run:"
echo "  cd /workspaces/tasteway_flutter"
echo "  flutter pub get"
echo "  flutter build apk --release"
