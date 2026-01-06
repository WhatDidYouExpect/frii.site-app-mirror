# The ONE and ONLY frii.site™ Mobile App
The only app you'll ever need.

> [!NOTE]  
> This app has only been tested on Android. iOS compatibility is **not guaranteed**.

## Getting Started

To successfully build and run the app, you will need:

- [Android SDK Command-line Tools](https://developer.android.com/studio#command-line-tools-only)  
- [Flutter](https://docs.flutter.dev/get-started/quick)

### Step 1: Install and Configure the Android SDK

After downloading the SDK, add it to your system PATH:

```bash
export ANDROID_SDK_ROOT="your/path/to/android/sdk !!"
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin
```

### Step 2: Install Required Packages

```bash
sdkmanager --install "platform-tools" "platforms;android-33" "build-tools;33.0.2" "ndk;28.2.13676358"
sdkmanager --licenses
```

### Step 3: Verify the Flutter Setup
Check your Flutter environment and ensure everything is installed correctly:
```bash
flutter doctor
```

You're done!
