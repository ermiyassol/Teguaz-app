import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:teguaz_app/models/bus.dart';
import 'package:teguaz_app/models/discount.dart';
import 'package:teguaz_app/models/place.dart';
import 'package:teguaz_app/providers/company.dart';
// import 'dart:convert';

import 'package:teguaz_app/providers/trip.dart';

class Companies with ChangeNotifier {
  List<Company> _Companies = [];

  List<Company> get companies {
    return [..._Companies];
  }

  Future<void> fetchAndSetCompany() async {
    final referenceDatabase =
        FirebaseDatabase.instance;
    final ref = referenceDatabase.reference();
    await ref
        .child("company")
        .onValue
        .listen((event) {
      // print('company lists');
      // print(event.snapshot.value);
      List<Company> loadedData = [];
      event.snapshot.value
          .forEach((companyId, companyData) {
        final newCompany = Company(
            bus: [],
            companyId: companyId,
            companyName:
                companyData['companyName'],
            headOffice: companyData['headOffice'],
            logoUrl: companyData['logoUrl'],
            place: [],
            website: companyData['website'],
            phoneNumber:
                companyData['phoneNumber']);
        print('company bus value');
        print(companyData['bus']);

        // todo validate companyData['place'] with if != null
        // todo - do it for bus
        if (companyData['place'] != null) {
          companyData['place']
              .forEach((placeId, placeData) {
            print('places');
            print(placeData);
            newCompany.place.add(Place(
                placeId: placeId,
                destination:
                    placeData['destination']
                        .toString()
                        .split(' / ')
                        .toList(),
                discount: Discount(
                    percentage:
                        placeData['discount']
                            ['percentage'],
                    reason: placeData['discount']
                        ['reason']),
                price: placeData['price']));
          });
        }
        List<Bus> buses = [];

        if (companyData['bus'] != null) {
          companyData['bus']
              .forEach((busId, busData) {
            final newBus = Bus(
                busNo: busData['busNo'],
                seatNo: busData['seatNo']);
            // print(newBus.busNo);

            buses.add(newBus);
          });
        }
        newCompany.bus = buses;
        loadedData.add(newCompany);
      });
      // print('companies');
      // print(_Companies);
      _Companies = loadedData;
      print(_Companies);
      notifyListeners();
    });
  }

  bool checkCompany(String cid) {
    return _Companies.any(
        (company) => company.companyId == cid);
  }

  getCompany(String cid, String type) {
    // todo company must be fetched before this method
    final company = _Companies.firstWhere(
        (company) => company.companyId == cid);
    if (type == 'logo') {
      return company.logoUrl;
    } else if (type == 'name') {
      return company.companyName;
    } else {
      return company;
    }
  }

  Company finadById(String id) {
    return _Companies.firstWhere(
        (company) => company.companyId == id);
  }

  void seatNo(String busNo, String companyId) {
    final companyIndex = _Companies.indexWhere(
        (company) =>
            company.companyId == companyId);
    final Bus bus = _Companies[companyIndex]
        .bus
        .firstWhere((bus) => bus.busNo == busNo);
  }

  double fetchDestinationPlace(
      String companyId, String place) {
    double calculatedPrice;
    final companyIndex = _Companies.indexWhere(
        (company) =>
            company.companyId == companyId);

    _Companies[companyIndex].place.forEach((p) {
      if (p.destination.join(' / ') == place) {
        final price = p.price;
        final discountPercent =
            p.discount.percentage;
        if (discountPercent == 0) {
          calculatedPrice = price.toDouble();
        } else {
          calculatedPrice =
              (price * (discountPercent / 100));
        }
      }
    });
    return calculatedPrice;
  }
}
