import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:promogo/visa/visa-authentication.dart';

class VisaPaymentValidation {
  static final visaPaymentValidationtUrl =
      'https://sandbox.api.visa.com/pav/v1/cardvalidation';

  static const String defaultCvv = "022";
  static const String defaultExpiryDate = "2020-10";
  static const String defaultCardNumber = "4957030420210462";

  static Future<Response> validateCard(
      {String cvv = defaultCvv,
      String expiryDate = defaultExpiryDate,
      String cardNumber = defaultCardNumber}) async {
    IOClient client = await VisaAuthentication.visaAuthClient();

    String json =
        '{"cardCvv2Value": "$cvv", "cardExpiryDate": "$expiryDate", "primaryAccountNumber": "$cardNumber"}';

    return await client.post(visaPaymentValidationtUrl,
        headers: VisaAuthentication.defaultHeader, body: json);
  }
}
