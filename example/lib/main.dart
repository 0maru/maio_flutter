import 'package:flutter/material.dart';
import 'package:maio_flutter/maio_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MaioRewardedAd.init(mediaId: "mediaId");
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: FlatButton(
            child: Text('show rewarded ad'),
            onPressed: () {
              MaioRewardedAd.show();
            },
          ),
        ),
      ),
    );
  }
}
