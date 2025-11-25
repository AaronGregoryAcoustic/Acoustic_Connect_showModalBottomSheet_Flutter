# Update the Connect Flutter library

You can use either of the following approaches to updating the Connect plugin in your Flutter app:

- Strict approach when you specify the exact version to install. For the list of available versions, see [Release notes for mobile Connect SDKs](/acoustic-connect/changelog/connect-mobile-sdk-release-notes).
- Flexible approach when you allow automatic updates within certain constraints.

When you enter the caret symbol ^ next to a version number, it signals that you allow minor updates and patches within the same major version, for example from version 2.33.0 to version 2.33.1 or 2.35.0. When a new major version is available (3.x.x), you will need to update the dependency.

> 📘 **Note**
>
> While minor versions aim for compatibility, there's always a slight risk of unexpected issues. It's a good practice to test your app thoroughly after updating packages.

## Instructions

1. In the root project directory, open **pubspec.yaml**.
2. Specify a version number or constraint.

```yaml
dependencies:
  connect_flutter_plugin: ^2.33.0
```

3. From the root project directory, run the `update` command.

```shell
flutter pub update
```

Flutter will look for the latest versions of your dependencies that fit the specified version constraints.

## Additional version-related settings

There is a configuration file in the Connect library (**ConnectConfig.json**). It lets you manage some additional settings related to versions:

- Upgrade (or downgrade) to a custom version of the iOS or Android library.
- Change the build type from beta to release or vice versa.

Here are the detailed descriptions of these optional configuration parameters.

| Parameter | Values | Description |
|-----------|--------|-------------|
| `useRelease` | Boolean. The default value is `true`. | Set the value to `false` to switch to the latest beta version of the library. It contains debug information. |
| `iOSVersion` | String | Under the hood, the Connect Flutter SDK is a wrapper for two Connect SDKs: iOS and Android. Using this parameter, you can downgrade the iOS SDK to an older version. |
| `AndroidVersion` | String | Using this parameter, you can downgrade the Android SDK to an older version. |

After editing **ConnectConfig.json**, you must run the Connect Command Line Tool. This is necessary to apply the changes.

```shell
cd <YOUR_PROJECT_PATH>
dart run $HOME/connect_cli/bin/connect_cli.dart
```
