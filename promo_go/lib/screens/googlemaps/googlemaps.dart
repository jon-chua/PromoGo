import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../AR/AR.dart';

class GoogleMaps extends StatefulWidget {
  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  GoogleMapController mapController;
  final LatLng _center = const LatLng(1.3521, 103.8198);

  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    final merchants = await getMerchants();

    setState(() {
      _markers.clear();
      for (final merchant in merchants) {
        final marker = Marker(
          markerId: MarkerId(merchant.name),
          position: LatLng(merchant.lat, merchant.lng),
          infoWindow: InfoWindow(
            title: merchant.name + " at " + merchant.address,
            snippet: "Capture me now!",
            onTap: () {
              Navigator.pushNamed(context, AR.routeName);
            },
          ),
        );
        _markers[merchant.name] = marker;
      }
    });
  }

  // To get the list of merchants
  Future<List<Location>> getMerchants() async {
    List<Location> locations = new List<Location>();
    locations.add(new Location("Sample Address Here", "0", "test.jpg", 1.3521,
        103.8198, "McDonald's", "91234567", "Region"));

    return locations;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
        markers: _markers.values.toSet(),
      ),
    );
  }
}

class Location {
  Location(
    this.address,
    this.id,
    this.image,
    this.lat,
    this.lng,
    this.name,
    this.phone,
    this.region,
  );

  final String address;
  final String id;
  final String image;
  final double lat;
  final double lng;
  final String name;
  final String phone;
  final String region;
}
