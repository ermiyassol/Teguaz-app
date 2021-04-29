import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:teguaz_app/models/discount.dart';
import 'package:teguaz_app/models/place.dart';
import 'package:teguaz_app/providers/company.dart';
import 'dart:convert';

import 'package:teguaz_app/providers/trip.dart';

class Companies with ChangeNotifier {
  List<Company> _Companies = [];

  List<Company> get companies {
    return [..._Companies];
  }

  Future<void> fetchAndSetCompany() async {
    var companyUrl = Uri.parse(
        'https://teguaz-web-app-default-rtdb.firebaseio.com/company.json');
    final response = await http.get(companyUrl);
    final extractedData =
        json.decode(response.body)
            as Map<String, dynamic>;
    // print(extractedData);
    if (extractedData.isEmpty) {
      return;
    }

    List<Company> loadedData = [];
    extractedData
        .forEach((companyId, companyData) {
      final newCompany = Company(
          companyId: companyId,
          companyName: companyData['companyName'],
          headOffice: companyData['headOffice'],
          logoUrl: companyData['logoUrl'],
          place: [],
          website: companyData['website'],
          phoneNumber:
              companyData['phoneNumber']);

      (companyData['place']
              as Map<String, dynamic>)
          .forEach((placeId, placeData) {
        newCompany.place.add(Place(
            placeId: placeId,
            destination: placeData['destination']
                .toString()
                .split(' / ')
                .toList(),
            discount: Discount(
                percentage: placeData['discount']
                    ['percentage'],
                reason: placeData['discount']
                    ['reason']),
            price: placeData['price']));
      });
      loadedData.add(newCompany);
    });
    _Companies = loadedData;
  }

  bool checkCompany(String cid) {
    return _Companies.any(
        (company) => company.companyId == cid);
  }

  getCompany(String cid, String type) {
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
}
