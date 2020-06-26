import 'package:flutter/material.dart';

import '../../screens/googlemaps/googlemaps.dart';

class Capture extends StatelessWidget {
  static const routeName = '/capture';

  @override
  Widget build(BuildContext context) {
    return GoogleMaps();
  }
}
