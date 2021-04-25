import 'package:flutter/material.dart';
import 'package:teguaz_app/widgets/main_drawer.dart';

class CompanyScreen extends StatelessWidget {
  static const routeName = '/company-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Companies List'),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Text('companies List'),
      ),
    );
  }
}
