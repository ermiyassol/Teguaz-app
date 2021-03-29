import 'package:flutter/material.dart';
import 'package:teguaz_app/widgets/main_appbar.dart';
import 'package:teguaz_app/widgets/main_drawer.dart';

class MainScreen extends StatelessWidget {
  // const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      drawer: MainDrawer(),
      body: Container(),
    );
  }
}
