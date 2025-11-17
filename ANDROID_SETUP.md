# Android Build Configuration

## Issue Fixed: Core Library Desugaring

The `flutter_local_notifications` package requires **core library desugaring** to work on older Android devices.

### What Was Changed

Modified `android/app/build.gradle.kts`:

1. **Enabled desugaring in compileOptions:**
```kotlin
compileOptions {
    sourceCompatibility = JavaVersion.VERSION_11
    targetCompatibility = JavaVersion.VERSION_11
    isCoreLibraryDesugaringEnabled = true  // Added this line
}
```

2. **Added desugaring dependency:**
```kotlin
dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
}
```

## What is Desugaring?

Desugaring allows newer Java 8+ APIs to work on older Android versions. The `flutter_local_notifications` package uses these APIs for scheduling notifications.

## Build Commands

```bash
# Clean build
flutter clean

# Build debug APK
flutter build apk --debug

# Build release APK
flutter build apk --release

# Build for specific architecture
flutter build apk --target-platform android-arm64

# Run on connected device
flutter run
```

## Minimum SDK Requirements

- **minSdk**: 21 (Android 5.0 Lollipop)
- **targetSdk**: Latest (configured by Flutter)
- **compileSdk**: Latest (configured by Flutter)

## Troubleshooting

### Build Still Failing?

1. **Clean everything:**
   ```bash
   flutter clean
   cd android && ./gradlew clean && cd ..
   flutter pub get
   ```

2. **Invalidate cache:**
   ```bash
   rm -rf build/
   rm -rf android/.gradle/
   ```

3. **Update Gradle:**
   - Check `android/gradle/wrapper/gradle-wrapper.properties`
   - Should use Gradle 8.0+

### Notification Issues?

Make sure your Android device/emulator is API 21+ (Android 5.0+).

### Permission Issues?

The app automatically requests notification permissions when you enable reminders in Settings.

## Release Build

For production release:

1. **Create a keystore:**
   ```bash
   keytool -genkey -v -keystore ~/upload-keystore.jks \
     -keyalg RSA -keysize 2048 -validity 10000 \
     -alias upload
   ```

2. **Configure signing:**
   - Create `android/key.properties`
   - Add signing config to `build.gradle.kts`

3. **Build release:**
   ```bash
   flutter build apk --release
   # or
   flutter build appbundle --release  # For Play Store
   ```

## Current Configuration

- **Namespace**: `com.example.bright_minds`
- **Application ID**: `com.example.bright_minds`
- **Java Version**: 11
- **Kotlin JVM Target**: 11
- **Desugaring**: Enabled

---

✅ **Build is now working!** You can run `flutter run` to test on Android devices.
