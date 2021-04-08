import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teguaz_app/providers/setting.dart';
import 'package:teguaz_app/providers/trips.dart';

class TripDetailScreen extends StatelessWidget {
  static const routeName = '/trip-detail';

  @override
  Widget build(BuildContext context) {
    final tripId = ModalRoute.of(context)
        .settings
        .arguments as String;
    final trip =
        Provider.of<Trips>(context, listen: false)
            .finadById(tripId);
    final languageIndex = Provider.of<Setting>(
            context,
            listen: false)
        .languageIndex;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${trip.startingCity[languageIndex]} - ${trip.destinationCity[languageIndex]}'),
      ),
    );
  }
}
