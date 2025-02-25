import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edgetier Chat Widget Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String htmlAssetPath;

  ChatScreen({
    super.key,
    this.htmlAssetPath = "assets/www/chat-window-demo.html",
  }) {
    assert(htmlAssetPath.isNotEmpty);
  }

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  WebViewController? controller;

  int progress = 0;
  bool isChatWidgetInitialized = false;
  String? errorMessage;

  void updateProgress(int newProgress) {
    setState(() {
      progress = newProgress;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null) {
      setState(() {
        controller =
            WebViewController()
              ..setOnConsoleMessage((message) {
                debugPrint("Console message: $message");
              })
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setNavigationDelegate(
                NavigationDelegate(
                  onProgress: (int progress) {
                    // Update loading bar.
                    // updateProgress(progress);
                  },
                  onPageStarted: (String url) {
                    debugPrint("Page started: $url");
                  },
                  onPageFinished: (String url) {
                    debugPrint("Page finished: $url");
                  },
                  onHttpError: (HttpResponseError error) {
                    debugPrint(
                      "Failed to load chat widget: ${error.toString()}",
                    );
                    setState(() {
                      errorMessage =
                          "Failed to load chat widget: ${error.toString()}";
                    });
                  },
                  onWebResourceError: (WebResourceError error) {
                    debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
                    setState(() {
                      errorMessage = '''
Failed to load chat widget: ${error.errorType}
  code: ${error.errorCode}
  description: ${error.description}
                      ''';
                    });
                  },
                  // onNavigationRequest: (NavigationRequest request) {
                  //   if (request.url.contains(
                  //     RegExp(r'^https://[\w-]+.edgetier.com/.*'),
                  //   )) {
                  //     return NavigationDecision.navigate;
                  //   }
                  //   return NavigationDecision.prevent;
                  // },
                ),
              )
              ..loadFlutterAsset(widget.htmlAssetPath).then(
                (value) {
                  setState(() {
                    errorMessage = null;
                    isChatWidgetInitialized = true;
                  });
                },
                onError: (error) {
                  setState(() {
                    errorMessage =
                        "Failed to load chat widget: ${error.toString()}";
                  });
                },
              );
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support Chat'),
        leading:
            (errorMessage == null)
                ? Icon(Icons.check)
                : IconButton(
                  icon: const Icon(Icons.error),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Error"),
                          content: Text(errorMessage!),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Close"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                controller = null;
              });
            },
          ),
        ],
      ),
      body:
          controller == null
              ? CircularProgressIndicator()
              : SizedBox(
                height: 300,
                child: WebViewWidget(controller: controller!),
              ),
    );
  }
}
