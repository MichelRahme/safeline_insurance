# Safeline Insurance

Safeline Insurance app makes use of Flutter's and Firebase's Machine Learning kit to automatically scan insurance claim receipts. 


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Getting Started on iOS

1. Your iPhone must be running on the latest public software.
To get the latest public software on your iPhone, you must do so by downloading
the configuration profile from on your iPhone.

[Get Public Beta Software](https://beta.apple.com/sp/betaprogram/enroll#ios)

2. Install Xcode 11.4.1 by following steps on flutter.dev/install.
[Install Xcode](https://flutter.dev/docs/get-started/install/macos#install-xcode)

3. You can get the project running on your iOS device by following the steps on flutter.dev/install.
[Deploy to iOS devices](https://flutter.dev/docs/get-started/install/macos#deploy-to-ios-devices)

If you are experiencing issues after following these steps, run cmd `flutter doctor -v`
to check that everything has been installed correctly:

    [✓] Xcode - develop for iOS and macOS (Xcode 11.4)
         • Xcode at /Applications/Xcode-beta.app/Contents/Developer
         • Xcode 11.4, Build version 11N132i
         • CocoaPods version 1.8.4

#### Common Mistakes:

- Must be on MacOS.
- iPhone iOS version is less than iOS 11.4
- Using Xcode 11.3.1 instead of 11.4.1
- Did not open ios/Runner.xcworkspace using Xcode to set Runner > Signing & Capabilities > Team, and enable automatically manage signing
- Did not trust this computer when iPhone was connected to by USB to Computer
- Did not trust App on iPhone. Settings > General > Profiles & Device Management > Developer App > Trust Development App
