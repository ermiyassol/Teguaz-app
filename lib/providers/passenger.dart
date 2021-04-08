import 'package:flutter/material.dart';

class Passenger {
  final String passengerId;
  final phoneNo;
  final bool status;
  final int seatNo;
  final String paymentType;
  final String paymentCode;

  Passenger(
      {this.passengerId,
      this.paymentCode,
      this.paymentType,
      this.phoneNo,
      this.seatNo,
      this.status});
}
