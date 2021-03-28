import 'package:flutter/material.dart';
import 'package:teguaz_app/screens/main_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teguaz App',
      home: MainScreen(),
      theme: ThemeData(),
      routes: {},
    );
  }
}
