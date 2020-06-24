import 'package:flutter/foundation.dart';

class Offer {
  final String name;
  final String description;
  final String sale;
  final String imageUrl;
  int outletsNum;

  Offer({
    @required this.name,
    @required this.description,
    @required this.sale,
    @required this.imageUrl,
    @required this.outletsNum,
  });
}
