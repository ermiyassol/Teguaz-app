import 'package:flutter/foundation.dart';
import 'package:teguaz_app/models/place.dart';

class Company with ChangeNotifier {
  final String companyId;
  final String companyName;
  final String headOffice;
  final String logoUrl;
  final List<Place> place;
  final String website;
  final String phoneNumber;

  Company(
      {@required this.companyId,
      @required this.companyName,
      @required this.headOffice,
      @required this.logoUrl,
      @required this.place,
      @required this.website,
      @required this.phoneNumber});
}
