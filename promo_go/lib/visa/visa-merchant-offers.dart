import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:promogo/visa/visa-authentication.dart';

class VisaMerchantOffers {
  static final visaMerchantOffersUrl = 'https://sandbox.api.visa.com/vmorc/offers/v1/byofferid';

// Sample params (not sure how these work yet)
//  static String offerids = "5995";
//  static String max_offers = "2";

  static Future<Response> getMerchantOffers() async {
    IOClient client = await VisaAuthentication.visaAuthClient();

//    String url = visaMerchantOffersUrl + "?offerids=" + offerids + "&max_offers=" + max_offers;

    return await client.get(visaMerchantOffersUrl,
        headers: VisaAuthentication.defaultHeader);
  }
}
