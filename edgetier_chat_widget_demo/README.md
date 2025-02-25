# edgetier_chat_widget_demo

A Flutter demo for Chat Widget

## Getting Started

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
