import 'package:flutter/material.dart';
import 'package:voting_app_mobile/pages/voting.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lime,
      ),
      home: Vote(),
      //MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
