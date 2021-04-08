import 'package:flutter/material.dart';
import 'package:teguaz_app/widgets/trip_list.dart';

class TripListScreen extends StatelessWidget {
  const TripListScreen({Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 10, vertical: 10),
      child: ListView(
        children: [
          TripList(),
          TripList(),
          TripList(),
          TripList()
        ],
      ),
    );
  }
}
