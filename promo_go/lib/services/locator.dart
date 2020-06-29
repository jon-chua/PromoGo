import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'user_location.dart';

class LocationService {
  static String url = "https://sandbox.api.visa.com/merchantlocator/v1/locator";
  static var now = new DateTime.now().toUtc();
  static var newFormat = DateFormat("YYYY-MM-DDThh:mm:ss.sss");
  String formattedTime = newFormat.format(now);
  UserLocation userLocation = UserLocation();
  var userLat;
  var userLong;

  void getUserCurrentLocation() async {
    var userLocationData = await userLocation.getUserCurrentLocation();
    userLat = userLocationData.latitude;
    userLong = userLocationData.longitude;
  }

  Future<dynamic> getMerchantLocation() async {
    getUserCurrentLocation();

    String map =
        '{"header":{"messageDateTime":"2020-06-29T06:22:45.903","requestMessageId":"Request","startIndex":"0"},"searchAttrList":{merchantName":"Starbucks","merchantCountryCode":"840","latitude":"37.363922","longitude":"-121.929163","distance":"10","distanceUnit":"M"},"responseAttrList":["GNLOCATOR"],"searchOptions":{"maxRecords":"10","matchIndicators":true,"matchScore":true}}';

    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('huutienvt98@gmail.com:atevvscdA1'));
    print(basicAuth);
    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Authorization': basicAuth,
        'Accept': 'application/json',
        'content-type': "application/json",
      },
      body: map,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      print(decodedData);
      return decodedData;
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }
}
