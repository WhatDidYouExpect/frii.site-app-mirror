# The ONE and ONLY frii.site™ Mobile App
The only app you'll ever need.

> [!NOTE]  
> This app has only been tested on **Android**. iOS compatibility is **not guaranteed**.

## Getting Started

To build and run the app, you will need:

- [Android SDK Command-line Tools](https://developer.android.com/studio#command-line-tools-only)  
- [Flutter](https://docs.flutter.dev/get-started/quick)

### Step 1: Install and Configure the Android SDK

After downloading the SDK, add it to your system `PATH`:

```bash
export ANDROID_SDK_ROOT="your/path/to/android/sdk"
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin
```

### Step 2: Install Required Packages

```bash
sdkmanager --install "platform-tools" "platforms;android-33" "build-tools;33.0.2" "ndk;28.2.13676358"
sdkmanager --licenses
```

### Step 3: Verify Your Flutter Setup

Check that Flutter is installed and configured correctly:

```bash
flutter doctor
```

Resolve any issues reported by `flutter doctor` before proceeding.

### Step 4: Build the App for Android

To generate a release APK for Android:

```bash
flutter build apk --release
```

Your release APK will be located in the `build/app/outputs/flutter-apk/` directory.

You’re done! The app is now ready to install on your Android device!

