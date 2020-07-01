import 'package:flutter/foundation.dart';
import 'package:promogo/models/merchant.dart';
import 'dart:math';

class Promo {
  final Merchant merchant;
  String salesName;
  String promoCode;
  int discount;
  DateTime expiryDate = DateTime(2020, 12, 31, 23, 59);

  Promo({
    this.merchant,
    this.salesName,
    this.promoCode,
  }) {
    promoCode = this.hashCode.toString();
    discount = Random().nextInt(50);
  }

  void printAll() {
    merchant.printAll();
    print(salesName);
    print(promoCode);
    print(discount.toString());
    print(expiryDate.toString());
  }

  @override
  String toString() {
    // TODO: implement toString
    return '${this.salesName} for ${this.promoCode}';
  }
}
