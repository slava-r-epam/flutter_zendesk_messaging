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
          title: const Text('Zendesk Messaging Example'),
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
                  onPressed: () => AdaChat.show(handle: 'handle'),
                  child: const Text("Initialize"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
