import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:teguaz_app/models/discount.dart';
import 'package:teguaz_app/models/place.dart';
import 'package:teguaz_app/providers/company.dart';
import 'dart:convert';

import 'package:teguaz_app/providers/trip.dart';

class Trips with ChangeNotifier {
  List<Trip> _Trips = [];

  List<Trip> get trips {
    return [..._Trips];
  }

  Future<void> fetchAndSetTrips() async {
    var url = Uri.parse(
        'https://teguaz-web-app-default-rtdb.firebaseio.com/trip.json');
    final response = await http.get(url);
    var extractedData = json.decode(response.body)
        as Map<String, dynamic>;
    if (extractedData.isEmpty) {
      return;
    }
    List<Trip> loadedData = [];
    extractedData
        .forEach((tripId, tripData) async {
      loadedData.add(Trip(
          tripId: tripId,
          busNo: tripData['busNo'],
          companyId: tripData['companyId'],
          date: tripData['date']
              .toString()
              .split(' / ')
              .toList(),
          destinationCity:
              tripData['destinationCity']
                  .toString()
                  .split(' / ')
                  .toList(),
          driver: tripData['driver'],
          startingCity: tripData['startingCity']
              .toString()
              .split(' / ')
              .toList(),
          startingPlace:
              tripData['startingPlace'],
          time: tripData['time'],
          passengers:
              tripData['passenger'] == null
                  ? tripData['passenger']
                  : []));
    });
    _Trips = loadedData;
    notifyListeners();
  }

  Trip finadById(String id) {
    return _Trips.firstWhere(
        (trip) => trip.tripId == id);
  }

  isTripLoaded() {
    return _Trips.isEmpty ? false : true;
  }
}
