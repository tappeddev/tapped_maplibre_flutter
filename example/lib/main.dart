import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:tapped_maplibre_flutter/tapped_maplibre_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _counter = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Builder(builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Tested this $_counter times!"),
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const _MapScreen()),
                    );
                  },
                  child: Text("open single"),
                ),
                MaterialButton(
                  color: Colors.red,
                  child: Text("Start testing"),
                  onPressed: () async {
                    for (var i = 0; i < 100;) {
                      await Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const _MapScreen()),
                      );
                      if (!mounted) return;
                      setState(() {
                        _counter++;
                      });
                      await Future<void>.delayed(const Duration(seconds: 2));
                      if (!mounted) return;
                    }
                  },
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class _MapScreen extends StatefulWidget {
  const _MapScreen({Key? key}) : super(key: key);

  @override
  State<_MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<_MapScreen> {
  final _tappedMaplibreFlutterPlugin = TappedMaplibreFlutter();

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ich bin eine map!"),
      ),
      body: _tappedMaplibreFlutterPlugin.build(context),
    );
  }
}
