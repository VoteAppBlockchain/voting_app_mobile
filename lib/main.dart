import 'package:flutter/material.dart';
import 'package:voting_app_mobile/pages/login.dart';

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
      home: LoginStateless(),
      //MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
