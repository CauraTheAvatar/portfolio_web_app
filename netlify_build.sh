#!/usr/bin/env bash
set -euo pipefail

echo "Starting Flutter build for Netlify..."

# Install Flutter (shallow clone of stable channel)
FLUTTER_DIR="/opt/buildhome/flutter"
if [ ! -d "$FLUTTER_DIR" ]; then
  echo "Cloning Flutter SDK (stable channel)..."
  git clone https://github.com/flutter/flutter.git --depth 1 -b stable "$FLUTTER_DIR"
else
  echo "Flutter SDK already exists, updating..."
  cd "$FLUTTER_DIR" && git pull origin stable
fi

# Add Flutter to PATH
export PATH="$FLUTTER_DIR/bin:$PATH"

# Verify Flutter installation
echo "Flutter version:"
flutter --version

# Enable web support
echo "Enabling web support..."
flutter config --enable-web

# Precache web artifacts
echo "Precaching web artifacts..."
flutter precache --web

# Get dependencies
echo "Getting dependencies..."
flutter pub get

# Build web release
echo "Building web release..."
flutter build web --release

echo "Build complete! Output is in build/web"