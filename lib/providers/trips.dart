// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:teguaz_app/providers/passenger.dart';
// import 'package:http/http.dart' as http;
// import 'package:teguaz_app/models/discount.dart';
// import 'package:teguaz_app/models/place.dart';
// import 'package:teguaz_app/providers/company.dart';
// import 'dart:convert';

import 'package:teguaz_app/providers/trip.dart';

class Trips with ChangeNotifier {
  List<Trip> _Trips = [];
  List<Map<String, dynamic>>
      _UpcommingPassengerTrips = [];

  Map<String, dynamic> tripDetail(String tripId) {
    final Trip trip = _Trips.where(
            (trip) => trip.tripId == tripId)
        .toList()[0];
    return {
      'startingPlace': trip.startingCity,
      'destinationPlace': trip.destinationCity,
      'date': trip.date,
      'time': trip.time,
      'companyId': trip.companyId
    };
  }

  List<Trip> trips({String companyId = ''}) {
    if (companyId != '') {
      return _Trips.where((trip) =>
          trip.companyId == companyId).toList();
    }
    // todo test the parameters

    return [..._Trips];
  }

  List<Map<String, dynamic>>
      get upComingTripsList {
    return [..._UpcommingPassengerTrips];
  }

  int get UpcomingTrip {
    return _UpcommingPassengerTrips.length;
  }

  Future<void> fetchAndSetTrips(
      String deviceId) async {
    final referenceDatabase =
        FirebaseDatabase.instance;
    final ref = referenceDatabase.reference();
    await ref
        .child("trip")
        .onValue
        .listen((event) {
      List<Trip> loadedData = [];
      _UpcommingPassengerTrips = [];
      event.snapshot.value
          .forEach((tripId, tripData) {
        Trip newTrip = Trip(
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
                    : []);

        List<Passenger> passengers = [];

        if (tripData['passengers'] != null) {
          tripData['passengers'].forEach(
              (passengerId, passengerData) {
            final newPassenger = Passenger(
              fullName: passengerData['fullName'],
              deviceId: passengerData['deviceId'],
              phoneNo: passengerData['phoneNo'],
              seatNo: passengerData['seatNo'],
              startingPlace:
                  passengerData['startingPlace'],
              date: passengerData['date'],
              time: passengerData['time'],
              status: passengerData['status'],
            );
            passengers.add(newPassenger);
            //! making device
            if (newPassenger.deviceId ==
                deviceId) {
              _UpcommingPassengerTrips.add({
                'passengerId': passengerId,
                'tripId': tripId,
                'deviceId': newPassenger.deviceId,
                'companyId': newTrip.companyId,
                'fullName': newPassenger.fullName,
                'phoneNo': newPassenger.phoneNo,
                'seatNo': newPassenger.seatNo,
                'startingPlace': newPassenger
                    .startingPlace
                    .toString()
                    .split(' / ')
                    .toList(),
                'status': newPassenger.status,
                'busNo': newTrip.busNo,
                'date': newTrip.date,
                'destinationCity':
                    newTrip.destinationCity,
                'startingCity':
                    newTrip.startingCity,
                'time': newTrip.time,
              });
            }
          });
        }
        // passengers.sort((a, b) =>
        //     a.seatNo.compareTo(b.seatNo));

        newTrip.passengers = passengers;
        loadedData.add(newTrip);
      });

      _Trips = loadedData;
      // print('tripsssssss');
      // print(_Trips);
      notifyListeners();
    });
  }

  Trip finadById(String id) {
    return _Trips.firstWhere(
        (trip) => trip.tripId == id);
  }

  isTripLoaded() {
    return _Trips.isEmpty ? false : true;
  }

  int checkSeatNo(int seatNo, String tripId) {
    final tripIndex = _Trips.indexWhere(
        (trip) => trip.tripId == tripId);
    final seatNoIndex = _Trips[tripIndex]
        .passengers
        .indexWhere(
            (seat) => seat.seatNo == seatNo);

    if (seatNoIndex == -1) {
      return 0;
    } else {
      return _Trips[tripIndex]
                  .passengers[seatNoIndex]
                  .status ==
              'reserved'
          ? 1
          : 2;
    }
  }
}
