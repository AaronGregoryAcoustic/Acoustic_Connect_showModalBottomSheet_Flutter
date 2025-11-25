# Build a sample Flutter app to evaluate the Connect SDK

Before you start integrating the Connect library into your Flutter app, we recommend installing our sample app with the library.

## Requirements

- **Development environment**. To build and run the sample app, you need a standard [Flutter environment](https://docs.flutter.dev/get-started/install). We recommend using Flutter 3.16.0 with Gradle 7.5.1.
- **Mobile app compatibility**. You can run the sample app on simulators and real devices. Supported operating systems: iOS 13 and later, Android 5.0 (API level 21) and later.
- **Acoustic Connect**. If you have an Ultimate license for Connect and want to check how session replay works, you'll need an access key. For instructions, see [Get an application key for the Connect library](/acoustic-connect/docs/generate-connect-credentials-for-integration).

## Setup instructions

1. Clone the sample app code from our GitHub repository.

```shell
git clone https://github.com/go-acoustic/Connect-Flutter.git
```

2. Update the project using the pub package manager.

```shell
cd Connect-Flutter
flutter clean && flutter pub get
cd Connect-Flutter/example/gallery 
flutter clean && flutter pub get
```

3. Navigate to the **iOS** project directory, delete **podfile.lock** and then update the Pods.

```shell
cd Connect-Flutter/example/gallery/ios
rm podfile.lock
pod update
```

> 📘 **Note**
> 
> If you get an error after updating the Pods, try repeating the `pod update` command or running `pod install`.

4. *(Connect Ultimate only)* Open the primary configuration file: `Connect-Flutter/example/gallery/ConnectConfig.json`. Update 2 keys in it using your Connect credentials: `AppKey` and `PostMessageUrl`. This is necessary for access to session replay in Connect (see the exercise below).

5. Start a target device (iOS or Android). Change to the project directory and run the sample app from there.

```shell
cd Connect-Flutter/example/gallery
flutter run 
```

If using an IDE, keep the following in mind:

- To open the iOS version with Xcode, use the `Connect-Flutter/example/gallery/iOS/Runner.xcworkspace` file (not `Connect-Flutter/example/gallery/ios/Runner.xcodeproj`).
- For the Android version, open the following directory in Android Studio: `Connect-Flutter/example/gallery`.

## Exercise (Connect Ultimate)

If you have an Ultimate license for Connect, you can check how user behavior data is captured.

1. Click around in the sample app.
2. In your Connect account, go to **Insights** > **Sessions** > **Session search**.
3. Find the session and play it back.

Notes:

- If a user is inactive for 30 minutes, their session times out.
- To learn more about the **Sessions** module, see [Session replay](https://help.goacoustic.com/hc/en-us/articles/360042593634-Session-replay) in our marketing guide.
