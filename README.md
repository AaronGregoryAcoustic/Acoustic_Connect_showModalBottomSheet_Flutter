# BancoEstado Flutter Sample App

A Flutter banking application demonstrating Acoustic Connect SDK integration with screen tracking and user interaction monitoring.

## App Overview

This is a sample banking app with:

- **Welcome Screen**: Initial landing page with login button
- **Login Bottom Sheet**: Modal login form with screen logging
- **Home Screen**: Main dashboard with shortcuts and navigation
- **Bottom Sheet Widgets**: Account summary, cards, transfers, and more options
- **Bottom Navigation**: 4-tab navigation bar

### App Flow

1. Welcome screen with greeting and dollar sign logo
2. Login bottom sheet for password entry
3. Home screen with transaction shortcuts
4. Various bottom sheets for banking operations

### Acoustic Connect Integration

The app integrates **connect_flutter_plugin v2.36.3-beta** for session replay and analytics:

- Auto-start enabled in main.dart
- Manual screen layout logging implemented in bottom sheets
- Captures user interactions, gestures, and screen flows

## Development Environment

### Flutter SDK
- **Flutter**: 3.32.4 (stable channel)
- **Dart**: 3.8.1
- **DevTools**: 2.42.0

### macOS Development Machine
- **OS**: macOS 15.7.1
- **Xcode**: 26.0 (Build 17A321)
- **CocoaPods**: 1.16.2

### Android Toolchain
- **Android SDK**: 35.0.0
- **Build Tools**: 35.0.0
- **Platform**: android-35, android-34
- **NDK**: 27.0.12077973
- **Java**: OpenJDK 17.0.13 (Zulu17.54+21-CA)
- **Android Studio**: 2024.2.2 and 2024.3.1.2

### iOS Toolchain
- **Xcode**: 26.0
- **iOS Deployment Target**: 13.0
- **CocoaPods**: 1.16.2

### IDEs
- **Android Studio**: 2024.2.2 and 2024.3.1.2
- **VS Code**: 1.105.1 with Flutter extension v3.120.0

### Test Devices
- **Android**: Pixel 5 API 34 (emulator running Android 14)
- **iOS**: iPhone 15 Simulator (iOS 18.0)

## Prerequisites

### Required Tools

1. Flutter SDK 3.32.4+
2. Xcode 26.0+ (for iOS development)
3. Android Studio (for Android development)
4. CocoaPods 1.16.2+ (for iOS dependencies)

### Android Configuration

- minSdkVersion: 21
- targetSdkVersion: 34
- compileSdkVersion: 34
- Java: OpenJDK 17 required

### iOS Configuration

- Deployment Target: iOS 13.0+
- Xcode Command Line Tools required

## Setup Instructions

### 1. Install Dependencies

```bash
cd /path/to/BancoEstadoFlutterApp
flutter pub get
```

### 2. iOS Setup

```bash
cd ios
pod install
cd ..
```

### 3. Run the App

**Android:**
```bash
flutter run
```

**iOS:**
```bash
flutter run -d "iPhone 15"
```

## Project Structure

```
lib/
  main.dart           # Main app with Acoustic Connect integration

ios/
  Podfile            # CocoaPods dependencies (iOS 13.0+)
  
android/
  app/build.gradle.kts   # Android build config
  
assets/              # App assets

documents/
  BUILD_ISSUES.md         # Detailed issue documentation
  HOME_SCREEN_FIXES.md    # UI implementation notes
```

## Known Issues with Acoustic Connect SDK

### 1. Screen Name Capture Unreliable

**Issue:** Bottom sheet screen names appear as null in Acoustic replay despite explicit logScreenLayout() calls.

**Code Implementation:**
```dart
@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    PluginConnect.logScreenLayout('LoginBottomSheet');
  });
}
```

**Test Results:**
- iOS: Partial success - login bottom sheet captures correctly, HomeScreen shows as null
- Android: All bottom sheets show as null regardless of logging

**Root Cause:** The SDK's Flutter instrumentation doesn't properly capture modal bottom sheets as distinct screens.

### 2. Control ID Differentiation Fails

**Issue:** All tap events report identical control ID: /RW/V/RV/MQ/Connect

**Impact:** Cannot distinguish between different buttons (login, shortcuts, nav tabs)

**Example Replay Data:**
```json
{
  "control": {
    "id": "/RW/V/RV/MQ/Connect",
    "idType": -4,
    "type": "FlutterSurfaceView",
    "subType": "SurfaceView"
  }
}
```

**Root Cause:** The SDK doesn't generate unique IDs for Flutter widgets - likely requires native platform view instrumentation.

### 3. Android Release Build Failure

**Issue:** Release builds fail with error:

```
error: resource android:color/system_neutral1_1000 not found
```

**Workaround:** Use debug builds only. Release builds require SDK fix.

**Status:** Reported to Acoustic - appears to be SDK bug with Android system resources.

## Important Notes

### Logo Implementation

The app uses a text-based dollar sign ($) logo instead of an image asset due to image loading exceptions on both platforms.

Implementation in lib/main.dart:
```dart
Container(
  width: 80,
  height: 80,
  decoration: BoxDecoration(
    color: Colors.white,
    shape: BoxShape.circle,
  ),
  child: Center(
    child: Text(
      '\$',
      style: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1976D2),
      ),
    ),
  ),
)
```

### Screen Logging Implementation

Manual screen logging is implemented in:
1. LoginBottomSheet - triggers on bottom sheet open
2. BottomSheetWidget - triggers for account summary, cards, transfers, more options

Each uses WidgetsBinding.instance.addPostFrameCallback() to log after widget build completes.

### Automatic Dependency Management

When running flutter run on a clean project (after flutter clean), Flutter automatically runs pub get to restore dependencies. No manual pub get required.

### Project Size

- Clean project (committed to version control): 3.9 MB
- After build (with generated files): ~2.28 GB

## Cleaning the Project

To remove all generated files before committing or uploading:

```bash
# Clean Flutter build artifacts
flutter clean

# Remove iOS CocoaPods
rm -rf ios/Pods ios/Podfile.lock ios/.symlinks ios/Flutter/ephemeral

# Remove Android Gradle build
rm -rf android/.gradle android/build android/app/build

# Remove other generated files
rm -rf .dart_tool build
```

## Deployment

### Debug APK (Android)

```bash
flutter build apk --debug
# Output: build/app/outputs/flutter-apk/app-debug.apk
```

### iOS Simulator

```bash
flutter run -d "iPhone 15"
```

## Support

For issues with:
- **Flutter**: https://docs.flutter.dev/
- **Acoustic Connect SDK**: Contact Acoustic Support

## License

This is a sample application for demonstration purposes.

---

© 2025 Sample App - For internal testing and debugging only.
