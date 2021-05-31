import 'package:flutter/foundation.dart';
import 'package:teguaz_app/models/discount.dart';

class Place {
  final String placeId;
  final List<String> destination;
  final Discount discount;
  final int price;

  Place(
      {@required this.placeId,
      @required this.destination,
      @required this.discount,
      @required this.price});
}
