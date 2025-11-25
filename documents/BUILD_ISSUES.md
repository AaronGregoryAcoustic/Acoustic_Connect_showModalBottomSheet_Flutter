# Build Issues and Solutions

## Current Status

### ✅ What's Working:
- **Debug builds**: `flutter build apk --debug` ✅ Works perfectly
- **Flutter run**: App runs successfully on devices
- Acoustic Connect SDK integrated
- Configuration files added to Android assets

### ❌ Release Build Issue:

**Problem**: Release APK build fails with Android resource linking errors related to `values-v34` (Android 14) system colors.

```
ERROR: resource android:color/system_background_dark not found
ERROR: resource android:color/system_primary_light not found
... (multiple similar errors)
```

**Root Cause**: The `connect_flutter_plugin` version 2.36.0 references Android 14 (API 34) system colors in its resources, but there's a compilation issue with these resources in release mode.

## Workarounds

### Option 1: Use Debug Build (Current Working Solution)
```bash
# Build debug APK (works perfectly)
flutter build apk --debug

# Or run directly on device
flutter run -d <device-id>
```

### Option 2: Build App Bundle Instead
```bash
# Try building an app bundle instead of APK
flutter build appbundle
```

### Option 3: Downgrade Connect Plugin (if needed)
If you need release builds urgently, you could try an older version:
```yaml
# In pubspec.yaml
dependencies:
  connect_flutter_plugin: ^2.35.0  # or earlier version
```

### Option 4: Contact Acoustic Support
This appears to be a known issue with the Connect Flutter plugin and Android API 34+ resources. You may want to:
- Check the [Connect Flutter Plugin GitHub](https://github.com/acoustic-analytics/Connect-Flutter-Plugin) for updates
- Contact Acoustic support for a patched version
- Check if there's a beta version (2.36.3-beta exists on pub.dev)

## What Was Changed

### Android Build Configuration Updated:
**File**: `android/app/build.gradle.kts`

```kotlin
android {
    compileSdk = 35          // Updated from flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"  // Required by connect_flutter_plugin
    
    defaultConfig {
        minSdk = 21
        targetSdk = 35       // Updated from flutter.targetSdkVersion
    }
}
```

### Flutter Code Integration:
**File**: `lib/main.dart`

```dart
import 'package:connect_flutter_plugin/connect_flutter_plugin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Connect(child: BancoEstadoApp()));
}

class BancoEstadoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [Connect.loggingNavigatorObserver],
      // ... rest of app
    );
  }
}
```

## Recommendations for ChatGPT Desktop

If you're having ChatGPT Desktop regenerate or fix this:

1. **Test with newer plugin version first**:
   ```
   flutter pub add connect_flutter_plugin:2.36.3-beta
   ```

2. **If that doesn't work, specify resource configuration**:
   The plugin might need Android resource compilation settings adjusted in `gradle.properties` or `build.gradle.kts`

3. **Alternative approach**: Use the Connect SDK's native Android/iOS libraries directly instead of the Flutter plugin, though this requires more manual integration.

## Next Steps

1. ✅ **Debug builds work** - You can develop and test with debug builds
2. ✅ **Device testing works** - `flutter run` works perfectly
3. ❌ **Release APK** - Needs plugin update or workaround
4. ⏳ **App Bundle** - Not yet tested, may work around the issue

---

**Last Updated**: October 20, 2025
**Flutter Version**: 3.32.4
**Connect Plugin**: 2.36.0
**Android SDK**: 35
