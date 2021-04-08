import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './passenger.dart';

class Trip with ChangeNotifier {
  final String tripId;
  final String busNo;
  final String companyId;
  final List<String> date;
  final List<String> destinationCity;
  final String driver;
  final List<String> startingCity;
  final List<dynamic> startingPlace;
  final String time;
  final List<Passenger> passengers;

  Trip(
      {@required this.tripId,
      @required this.busNo,
      @required this.companyId,
      @required this.date,
      @required this.destinationCity,
      @required this.driver,
      @required this.startingCity,
      @required this.startingPlace,
      @required this.time,
      this.passengers});
}
