import 'package:flutter/material.dart';
import 'package:teguaz_app/screens/trip_list_screen.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';

  @override
  _SearchScreenState createState() =>
      _SearchScreenState();
}

class _SearchScreenState
    extends State<SearchScreen> {
  var searchValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (val) {
            setState(() {
              searchValue = val;
            });
          },
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              labelText: 'Search',
              labelStyle:
                  TextStyle(color: Colors.white)),
        ),
      ),
      body: TripListScreen(
        searchingText: searchValue,
      ),
    );
  }
}
