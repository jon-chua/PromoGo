import 'package:flutter/foundation.dart';

import '../models/promo.dart';

enum CustomNotificationType {
  redemption,
  capture,
}

class CustomNotification {
  final Promo promo;
  final String imageUrl;
  final DateTime dateTime;
  final CustomNotificationType notificationType;

  CustomNotification({
    @required this.promo,
    @required this.notificationType,
    @required this.imageUrl,
    @required this.dateTime,
  });
}
