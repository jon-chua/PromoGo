import 'package:flutter/foundation.dart';
import 'package:promogo/models/merchant.dart';
import 'dart:math';

class Promo {
  final Merchant merchant;
  String sale;
  String name;
  int discount;

  Promo({
    this.merchant,
    this.sale,
    this.name,
  }) {
    name = this.hashCode.toString();
    discount = Random().nextInt(50);
  }

  @override
  String toString() {
    // TODO: implement toString
    return '${this.sale} for ${this.name}';
  }
}
