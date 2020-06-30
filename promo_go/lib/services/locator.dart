import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:intl/intl.dart';
import 'package:promogo/constants.dart';
import 'package:promogo/models/merchant.dart';
import 'package:promogo/visa/visa-authentication.dart';

import 'user_location.dart';

class LocationService {
  static String url = "https://sandbox.api.visa.com/merchantlocator/v1/locator";
  static var now = new DateTime.now().toUtc();
  static var newFormat = DateFormat("yyyy-MM-ddThh:mm:ss.sss");
  String formattedTime = newFormat.format(now);
  UserLocation userLocation = UserLocation();

  Future<dynamic> getMerchantLocation() async {
    var merchantList = new Set();
    var userLocationData = await userLocation.getUserCurrentLocation();
    var userLat = userLocationData.latitude;
    var userLong = userLocationData.longitude;
    IOClient client = await VisaAuthentication.visaAuthClient();

    for (var cat in kMerchantList) {
      var postBody = {
        "header": {
          "messageDateTime": "$formattedTime",
          "requestMessageId": "Request_001",
          "startIndex": "0"
        },
        "searchAttrList": {
          //"merchantName": "Starbucks",
          "merchantCategoryCode": [cat],
          "merchantCountryCode": "840",
          "latitude": "$userLat",
          "longitude": "$userLong",
          "distance": "100",
          "distanceUnit": "M"
        },
        "responseAttrList": ["GNLOCATOR"],
        "searchOptions": {"matchIndicators": "true", "matchScore": "true"}
      };

      Response response = await client.post(url,
          headers: VisaAuthentication.defaultHeader,
          body: jsonEncode(postBody));

      print("Result: " + response.body);

      var data = jsonDecode(response.body);
      print("JSON object: ");
      print(data);
      if (data["merchantLocatorServiceResponse"]["response"] != null) {
        for (var merchant in data["merchantLocatorServiceResponse"]
            ["response"]) {
          var m = new Merchant(
            name: merchant["visaStoreName"],
            latitude: merchant["locationAddressLatitude"],
            longitude: merchant["locationAddressLongitude"],
            address: merchant["merchantStreetAddress"],
            city: merchant["merchantStreetCity"],
            postalCode: merchant["merchantPostalCode"],
            url: merchant["url"],
            visaMerchantId: merchant["visaMerchantId"],
            visaStoreId: merchant["visaStoreId"],
          );
          merchantList.add(m);
        }
      }
    }
    print(merchantList.length);
    return merchantList;
  }
}
