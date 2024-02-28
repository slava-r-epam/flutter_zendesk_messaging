import 'package:ada_chat_flutter/ada_chat_flutter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ada Chat Example'),
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    debugPrint('MyApp:onPressed');
                    AdaChat.show(
                      handle: 'headspace',
                      // cluster: 'ca',
                      greetings: 'Hello there',
                      metafields: {'key1': 'value1'},
                      sensitiveMetafields: {'key2': 'value2'},
                      deviceToken: '34456456',
                      language: 'en',
                      loadTimeoutMillis: 30000,
                      // styles: 'styles',
                      acceptThirdPartyCookies: true,
                      mode: 'modal',
                      openWebLinksInSafari: true,
                      // appScheme: 'appScheme',
                      navigationBarOpaqueBackground: true,
                      // domain: 'domain',
                    );
                  },
                  child: const Text("Show chat"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
