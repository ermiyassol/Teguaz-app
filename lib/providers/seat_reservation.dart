import 'package:flutter/material.dart';
import 'package:teguaz_app/providers/passenger.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SeatReservation with ChangeNotifier {
  Passenger _Passenger;
  String responseId;
  String passengerTripId;

  Map<String, dynamic> get passengerDetail {
    return {
      'fullName': _Passenger.fullName,
      'seatNo': _Passenger.seatNo,
      'tripId': passengerTripId,
    };
  }

  reserveSeat(
      String deviceId,
      String tripId,
      String fullName,
      String phoneNumber,
      int seatNo,
      String startingPlace) async {
    passengerTripId = tripId;
    final newPassenger = new Passenger(
        fullName: fullName,
        deviceId: deviceId,
        phoneNo: phoneNumber,
        seatNo: seatNo,
        startingPlace: startingPlace,
        date: DateFormat.yMd()
            .format(DateTime.now()),
        time: DateFormat.jm()
            .format(DateTime.now()),
        status: 'reserved');
    _Passenger = newPassenger;
    var url = Uri.parse(
        'https://teguaz-web-app-default-rtdb.firebaseio.com/trip/$tripId/passengers.json');

    try {
      var response = await http.post(url,
          body: json.encode({
            'fullName': fullName,
            'deviceId': deviceId,
            'phoneNo': phoneNumber,
            'seatNo': seatNo,
            'startingPlace': startingPlace,
            'date': DateFormat.yMd()
                .format(DateTime.now()),
            'time': DateFormat.jm()
                .format(DateTime.now()),
            'status': 'reserved'
          }));

      responseId =
          json.decode(response.body)['name'];
    } catch (error) {
      print(error);
    }

    // todo 2 - push newPassenger
    // todo 3 - make a way to authenticate the user
    // todo 4 - perform payment

    // ! exceptions
    // todo - (ESSENTIAL) when payment performed Response ID and Trip Id Must BE null
    //! todo 1 - when 2 users try to reserve one seat make enable for only one user
    //! todo 2 - make seat number lists responsive //! mostly at the right side
  }

  Future<void> buyTicket() async {
    var url = Uri.parse(
        'https://teguaz-web-app-default-rtdb.firebaseio.com/trip/$passengerTripId/passengers/$responseId.json');
    try {
      await http.patch(url,
          body: json.encode({
            'fullName': _Passenger.fullName,
            'deviceId': _Passenger.deviceId,
            'phoneNo': _Passenger.phoneNo,
            'seatNo': _Passenger.seatNo,
            'startingPlace':
                _Passenger.startingPlace,
            'date': _Passenger.date,
            'time': _Passenger.time,
            'status': 'sold'
          }));
    } catch (error) {
      print(error);
    }
  }

  Future<void> deletePassenger() async {
    if (passengerTripId != null &&
        responseId != null) {
      var url = Uri.parse(
          'https://teguaz-web-app-default-rtdb.firebaseio.com/trip/$passengerTripId/passengers/$responseId.json');
      try {
        await http.delete(url);
      } catch (error) {}
    }
  }

  paymentPerformed() {
    passengerTripId = null;
    responseId = null;
  }
}
