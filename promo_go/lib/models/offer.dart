import 'package:flutter/foundation.dart';

class Offer {
  final String name;
  final String code;
  final String sale;
  final String imageUrl;
  final DateTime expiryDate;

  Offer({
    @required this.name,
    @required this.sale,
    @required this.imageUrl,
    @required this.code,
    @required this.expiryDate,
  });
}
