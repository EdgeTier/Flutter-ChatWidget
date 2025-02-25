# edgetier_chat_widget_demo

A Flutter demo for Chat Widget

## How this demo works

The demo application is built using Flutter and demonstrates how to integrate a web-based chat widget into a Flutter app using the `webview_flutter` package.

1. **Main Entry Point**: The `main` function initializes the app by calling `runApp` with `MyApp` as the root widget.
2. **ChatScreen Widget**: This stateful widget is the main screen of the app, which contains a `WebView` to load the chat widget from an HTML asset.
3. **WebViewController**: The `WebViewController` is used to manage the web view, including loading the HTML asset and handling various web view events such as page load progress, errors, and console messages.
4. **Chat Widget HTML**: The chat widget is using a static HTML file that contains the chat widget loading script. The HTML is loaded into the web view using the `loadAsset` method of the `WebViewController`. You can experiment by just opening the [assets/www/chat-window-demo.html](assets/www/chat-window-demo.html) file in a browser.

## Local Setup

Setting up for both platforms requires a few hours and a lot of network bandwidth + disk space (15GB+). 
The following steps are for macOS.

### Set up Flutter

Open this project in VSCode with Flutter extension installed. Then run Cmd+Shift+P and select `Flutter: Get Packages`.

### Set up iOS Platform

1. Download XCode for iOS
2. Install cocoapods

   ```bash
   brew install cocoapods
   brew link --overwrite cocoapods
   ```

3. Open XCode and install the iOS simulator
4. Open the project in VSCode, open `main.dart` and do Run - select iOS device to create the emulator.

### Set up Android Platform

1. Download Android Studio for Android
2. Install the Android emulator, SDK and SDK command linetools
3. Install Java and add the CLI tools to PATH

   ```bash
   curl -s "https://get.sdkman.io" | bash
   sdk install java 23-open
   ```

   Add CLI-tools to PATH by adding the following line to `~/.zshenv`:

   ```bash
   # Android CLI tools
   export PATH=~/Library/Android/sdk/cmdline-tools/latest/bin:$PATH
   ```

4. Open the project in VSCode, open `main.dart` and do Run - select Android device to create the emulator.
