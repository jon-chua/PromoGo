import 'package:flutter/material.dart';
import '../../screens/AR/AR.dart';
import '../../screens/googlemaps/googlemaps.dart';

class Capture extends StatelessWidget {
  static const routeName = '/capture';

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      RaisedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AR()),
          );
        },
        child: Text(
          "AR Feature",
        ),
      ),
      Expanded(child: GoogleMaps())
    ]);
  }
}
