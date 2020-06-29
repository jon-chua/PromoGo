import 'dart:convert';
import 'dart:io';

import 'package:promogo/visa/visa-authentication.dart';

class VisaMerchantOffers {
  static final visaMerchantOffersUrl = 'https://sandbox.api.visa.com/vmorc/offers/v1/byofferid';

// Sample params (not sure how these work yet)
//  static String offerids = "5995";
//  static String max_offers = "500";

  static Future<HttpClientResponse> visaMerchantOffers() async {
    HttpClient client = await VisaAuthentication.visaAuthClient();

    return await client
        .getUrl(Uri.parse(visaMerchantOffersUrl))
        .then((HttpClientRequest request) {
      request.headers.add(HttpHeaders.authorizationHeader,
          "Basic NFU5WjY5UVBNQzJVWlBIQzBCSlAyMVVKT1RadGE2YV9ldm9FUEFiYTdKM0R4R3dSZzowa0VlZGY5ZFFuQ1ZtSktoMkVoeg==");
      request.headers.add(HttpHeaders.acceptHeader, "application/json");
      request.headers.add(HttpHeaders.contentTypeHeader, "application/json");
      return request.close();
    });
  }

  void getMerchantOffersResult() async {
    final response = await VisaMerchantOffers.visaMerchantOffers();
    response.transform(utf8.decoder).listen((contents) {
      print(contents);
    });
  }
}
