import 'package:flutter/foundation.dart';

class Promo {
  final String name;
  final String sale;

  Promo({
    @required this.name,
    @required this.sale,
  });

  @override
  String toString() {
    // TODO: implement toString
    return '${this.sale} for ${this.name}';
  }
}
