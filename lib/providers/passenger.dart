import 'package:flutter/material.dart';

class Passenger {
  String deviceId;
  String phoneNo;
  String status;
  int seatNo;
  String fullName;
  String startingPlace;
  String date;
  String time;

  Passenger(
      {this.date,
      this.deviceId,
      this.fullName,
      this.startingPlace,
      this.time,
      this.phoneNo,
      this.seatNo,
      this.status});
}
