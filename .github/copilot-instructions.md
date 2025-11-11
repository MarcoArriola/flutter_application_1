# Flutter Application 1 - AI Coding Agent Instructions

## Project Overview
This is a Flutter cross-platform mobile application (Android, iOS, macOS, Linux, Windows). Currently a minimal starter project with a simple "Hola Mundo" display using Material Design.

**Key characteristics:**
- Flutter SDK: 3.9.2+
- Uses Material Design (`flutter_lints: 5.0.0`)
- Multi-platform support via Flutter standard project structure
- Spanish language hints in codebase (class `HOlaMundo`, "Hola Mundo" display)

## Architecture & Structure

### Core Components
- **Entry point**: `lib/main.dart` - Contains `runApp()` with `HOlaMundo` widget
- **Widget hierarchy**: Currently single stateless `MaterialApp` widget
- **Future apps**: Expect Flutter app to grow with multiple screens, state management, and platform-specific channels

### Platform Specifics
- **Android**: Gradle-based build (`build.gradle.kts`), runs via Gradle wrapper
- **iOS/macOS**: Xcode projects in `ios/` and `macos/` directories
- **Linux/Windows**: CMake-based configuration in `linux/` and `windows/` directories
- **Web**: Standard Flutter web configuration in `web/`

## Development Workflows

### Build & Run Commands
```bash
# Run on debug device/emulator
flutter run

# Run on specific platform
flutter run -d windows    # Windows
flutter run -d linux      # Linux  
flutter run -d web        # Web browser

# Build release APK/app
flutter build apk         # Android
flutter build ios         # iOS
flutter build windows     # Windows desktop
```

### Testing & Linting
```bash
# Run dart/flutter linter (enforces flutter_lints)
dart analyze
flutter analyze

# Run any existing tests
flutter test
```

### Code Generation & Cleanup
```bash
# Clean build artifacts
flutter clean

# Get dependencies (after pubspec.yaml changes)
flutter pub get
```

## Conventions & Patterns

### Dart/Flutter Style
- **Linting**: Follows `package:flutter_lints` rules via `analysis_options.yaml`
- **Naming**: PascalCase for classes (e.g., `HOlaMundo`, `MaterialApp`)
- **Widgets**: Prefer `StatelessWidget` for immutable UI, `StatefulWidget` only when state needed
- **Material Design**: Use Material Design components from `package:flutter/material.dart`

### Project Language Mix
- Main code: Dart
- Android native: Kotlin (via `build.gradle.kts` - Kotlin DSL)
- iOS/macOS native: Swift (`.swift` files in `ios/Runner/`, `macos/Runner/`)
- Linux/Windows native: C++ (CMakeLists.txt)

## Key Files & Integration Points
- **pubspec.yaml**: Dependency management and Flutter configuration
- **analysis_options.yaml**: Lint rules (includes `flutter_lints`)
- **lib/main.dart**: Application entry point and root widget
- **android/app/build.gradle.kts**: Android-specific Gradle configuration
- **.metadata**: Flutter project metadata (auto-generated, do not edit manually)

## Common Tasks

### Adding Dependencies
1. Edit `pubspec.yaml` under `dependencies:` or `dev_dependencies:`
2. Run `flutter pub get`
3. Rebuild if needed

### Platform-Specific Code
- Use `dart:io` for platform detection: `Platform.isAndroid`, `Platform.isIOS`, etc.
- Method channels for native code communication (example path: `android/app/src/main/kotlin/`)

### Hot Reload Workflow
- Edit Dart code in `lib/`
- Press `r` in terminal running `flutter run` for hot reload
- Note: Some changes (e.g., adding plugins, native code) require full rebuild

## Important Notes
- **Spanish hints**: Code uses Spanish naming (e.g., `HOlaMundo`). Maintain consistency when adding features.
- **Minimal base**: Current app is intentionally simple. Expect architectural growth when adding features.
- **Android Studio/VS Code**: Project structured for either IDE; ensure Flutter and Dart extensions installed.
