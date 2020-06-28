import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../widgets/small_white_card.dart';
import '../../shared/constants.dart';
import '../../screens/googlemaps/googlemaps.dart';

class Capture extends StatelessWidget {
  static const routeName = '/capture';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SmallWhiteCard(
          height: MediaQuery.of(context).size.height / 5.5,
          width: double.infinity,
          childWidget: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Capturing at'),
                ],
              ),
              Container(
                color: lightGreyColor,
                child: Text('location'),
                padding: EdgeInsets.all(10),
              ),
              SizedBox(height: 10),
              Text('Select a marker to start capturing the promotion!'),
            ],
          ),
        ),
        GoogleMaps(),
      ],
    );
  }
}
