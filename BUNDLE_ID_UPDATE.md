# Bundle ID / Application ID Update

## ✅ Updates Complete

Bundle ID and Application ID have been updated to: **`app.today.brightminds`**

## Changes Made

### Android

**1. Application ID** - [android/app/build.gradle.kts](android/app/build.gradle.kts)
```kotlin
// Before
namespace = "com.example.bright_minds"
applicationId = "com.example.bright_minds"

// After
namespace = "app.today.brightminds"
applicationId = "app.today.brightminds"
```

**2. Package Structure**
- Created new directory: `android/app/src/main/kotlin/app/today/brightminds/`
- Moved MainActivity.kt to new location
- Updated package declaration:
  ```kotlin
  package app.today.brightminds
  ```
- Removed old directory: `android/app/src/main/kotlin/com/`

**3. App Label** - [android/app/src/main/AndroidManifest.xml](android/app/src/main/AndroidManifest.xml)
```xml
<!-- Before -->
android:label="bright_minds"

<!-- After -->
android:label="BrightMinds"
```

### iOS

**1. Bundle Identifier** - [ios/Runner.xcodeproj/project.pbxproj](ios/Runner.xcodeproj/project.pbxproj)

Updated in all build configurations (Debug, Release, Profile):
```
// Before
PRODUCT_BUNDLE_IDENTIFIER = com.example.brightMinds;

// After
PRODUCT_BUNDLE_IDENTIFIER = app.today.brightminds;
```

Also updated test target bundle IDs:
```
app.today.brightminds.RunnerTests
```

## Verification

### Check Android Application ID
```bash
grep "applicationId" android/app/build.gradle.kts
```
Should output: `applicationId = "app.today.brightminds"`

### Check iOS Bundle ID
```bash
grep "PRODUCT_BUNDLE_IDENTIFIER" ios/Runner.xcodeproj/project.pbxproj | head -3
```
Should output: `PRODUCT_BUNDLE_IDENTIFIER = app.today.brightminds;`

### Check Package Structure
```bash
ls -la android/app/src/main/kotlin/app/today/brightminds/
```
Should show: `MainActivity.kt`

## What This Means

### For Development
- ✅ No changes needed for local development
- ✅ `flutter run` works as before
- ✅ Hot reload still functions normally

### For App Stores

**Google Play Store:**
- Package name: `app.today.brightminds`
- This is the unique identifier for your app
- **IMPORTANT**: Once published, this cannot be changed

**Apple App Store:**
- Bundle ID: `app.today.brightminds`
- This is the unique identifier for your app
- **IMPORTANT**: Once registered, this cannot be changed

### Domain Ownership

The reverse domain notation `app.today.brightminds` implies:
- Domain: `today.app` (or ownership/rights to use this)
- App identifier: `brightminds`

**Note**: You should own or have rights to use the domain `today.app` for app store submissions.

## Next Steps for Publishing

### Android (Google Play)

1. **Generate Release Keystore:**
   ```bash
   keytool -genkey -v -keystore ~/upload-keystore.jks \
     -keyalg RSA -keysize 2048 -validity 10000 \
     -alias upload
   ```

2. **Configure Signing:**
   Create `android/key.properties`:
   ```properties
   storePassword=<password>
   keyPassword=<password>
   keyAlias=upload
   storeFile=<path-to-keystore>
   ```

3. **Build Release:**
   ```bash
   flutter build appbundle --release
   ```

### iOS (App Store)

1. **Register Bundle ID** in Apple Developer Portal:
   - Login to [developer.apple.com](https://developer.apple.com)
   - Go to Certificates, Identifiers & Profiles
   - Register `app.today.brightminds` as App ID

2. **Configure Signing:**
   - Open Xcode: `open ios/Runner.xcworkspace`
   - Select Runner target
   - Set Development Team
   - Verify Bundle Identifier: `app.today.brightminds`

3. **Build Archive:**
   ```bash
   flutter build ios --release
   ```
   Then archive in Xcode for App Store distribution

## Testing

After these changes, test the following:

- [ ] App installs successfully on Android device
- [ ] App installs successfully on iOS device
- [ ] App name displays as "BrightMinds"
- [ ] Notifications still work (with new package name)
- [ ] Local storage persists correctly
- [ ] Deep links work (if configured)

## Rollback (If Needed)

If you need to revert to the old IDs:

**Android:**
```kotlin
namespace = "com.example.bright_minds"
applicationId = "com.example.bright_minds"
```

**iOS:**
```
PRODUCT_BUNDLE_IDENTIFIER = com.example.brightMinds;
```

**Note**: Rollback would require moving Kotlin files back to old package structure.

---

**Status**: ✅ All bundle IDs updated successfully
**New ID**: `app.today.brightminds`
**App Name**: BrightMinds
