import 'package:flutter/material.dart';
import 'package:teguaz_app/screens/main_screen.dart';
import 'package:teguaz_app/screens/search_screen.dart';
import 'package:teguaz_app/widgets/about.dart';
import 'package:teguaz_app/widgets/contact.dart';
import 'package:teguaz_app/widgets/guide.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Teguaz App',
      home: MainScreen(),
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        // textTheme: TextTheme(
        //     display1: TextStyle(
        //         color: Colors.white,
        //         fontSize: 17))
      ),
      routes: {
        SearchScreen.routeName: (_) =>
            SearchScreen(),
        Guide.routeName: (_) => Guide(),
        About.routeName: (_) => About(),
        Contact.routeName: (_) => Contact()
      },
    );
  }
}
