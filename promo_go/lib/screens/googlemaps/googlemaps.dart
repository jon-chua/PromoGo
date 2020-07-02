import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:promogo/screens/AR/AR.dart';
import 'package:promogo/services/locator.dart';
import 'package:promogo/services/user_location.dart';

class GoogleMaps extends StatefulWidget {
  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  GoogleMapController mapController;
  LatLng _center = const LatLng(37.790761, -122.434241);
  LocationService locationService = LocationService();

  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    mapController = controller;

    UserLocation userLocation = UserLocation();
    var userLocationData = await userLocation.getUserCurrentLocation();

    mapController.moveCamera(CameraUpdate.newLatLng(
        LatLng(userLocationData.latitude, userLocationData.longitude)));

    final merchants = await locationService.getMerchantLocation();

    setState(() {
      _markers.clear();

      for (final merchant in merchants) {
        final marker = Marker(
          markerId: MarkerId(merchant.name),
          position: LatLng(double.parse(merchant.latitude),
              double.parse(merchant.longitude)),
          infoWindow: InfoWindow(
            title: merchant.name + " at " + merchant.address,
            snippet: "Capture me now!",
            onTap: () {
              Navigator.pushNamed(context, AR.routeName, arguments: merchant.name);
            },
          ),
        );
        _markers[merchant.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 13.0,
        ),
        markers: _markers.values.toSet(),
      ),
    );
  }
}
