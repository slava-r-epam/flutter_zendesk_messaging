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
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    debugPrint('MyApp: AdaChat.initialize');

                    AdaChat.initialize(
                      handle: 'headspace',
                      // cluster: 'ca',
                      greetings: 'Hello there',
                      metafields: {
                        'key1': 'value1',
                        'key2': 'value2',
                      },
                      sensitiveMetafields: {
                        'key1s': 'value1s',
                        'key2s': 'value2s'
                      },
                      // deviceToken: '3445645623',
                      language: 'en',
                      loadTimeoutMillis: 30000,
                      // styles: 'styles',
                      acceptThirdPartyCookies: true,
                      // mode: 'inject',
                      openWebLinksInSafari: true,
                      // appScheme: 'appScheme',
                      navigationBarOpaqueBackground: true,
                      // domain: 'domain',
                    );
                  },
                  child: const Text("initialize"),
                ),
                ElevatedButton(
                  onPressed: () {
                    debugPrint('MyApp: AdaChat.setMetaFields');

                    AdaChat.setMetaFields(metafields: {
                      'key2': 'value2abc',
                      'key3': '',
                    });
                  },
                  child: const Text("setMetaFields"),
                ),
                ElevatedButton(
                  onPressed: () {
                    debugPrint('MyApp: AdaChat.setDeviceToken');

                    AdaChat.setDeviceToken(deviceToken: '456243452');
                  },
                  child: const Text("setDeviceToken"),
                ),
                ElevatedButton(
                  onPressed: () {
                    debugPrint('MyApp: AdaChat.deleteHistory');

                    AdaChat.deleteHistory();
                  },
                  child: const Text("deleteHistory"),
                ),
                ElevatedButton(
                  onPressed: () {
                    debugPrint('MyApp: AdaChat.triggerAnswer');

                    AdaChat.triggerAnswer(answerId: '5dade02365851edea546b245');
                  },
                  child: const Text("triggerAnswer"),
                ),
                ElevatedButton(
                  onPressed: () {
                    debugPrint('MyApp: AdaChat.show');

                    AdaChat.show(
                        // mode: 'inject',
                        );
                  },
                  child: const Text("show"),
                ),
                ElevatedButton(
                  onPressed: () {
                    debugPrint('MyApp: AdaChat.reset');

                    AdaChat.reset();
                  },
                  child: const Text("reset"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
