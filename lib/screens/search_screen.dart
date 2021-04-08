import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = '/search-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              labelText: 'Search',
              labelStyle:
                  TextStyle(color: Colors.white)),
        ),
      ),
      body: Container(),
    );
  }
}
