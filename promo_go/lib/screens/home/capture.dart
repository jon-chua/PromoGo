import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:promogo/services/user_location.dart';

import '../../widgets/small_white_card.dart';
import '../../shared/constants.dart';
import '../../screens/googlemaps/googlemaps.dart';

class Capture extends StatefulWidget {
  static const routeName = '/capture';

  @override
  _CaptureState createState() => new _CaptureState();
}

class _CaptureState extends State<Capture> {
  String location;

  Future<String> reverseGeolocate(double latitude, double longitude) async {
    List<Placemark> placemarks =
        await Geolocator().placemarkFromCoordinates(latitude, longitude);

    if (placemarks != null && placemarks.isNotEmpty) {
      final Placemark pos = placemarks[0];
      return pos.thoroughfare + ', ' + pos.locality;
    }
    return "";
  }

  @override
  initState() {
    super.initState();

    UserLocation userLocation = UserLocation();
    userLocation.getUserCurrentLocation().then((userLocationData) {
      return reverseGeolocate(
          userLocationData.latitude, userLocationData.longitude);
    }).then((String value) {
       setState(() {
        location = value.trim();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (location == null) {
      return new Container();
    } else {
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
                  child: Text(location),
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
}
