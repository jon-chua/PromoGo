import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:promogo/visa/visa-authentication.dart';

class VisaDirect {
  static final visaDirectUrl =
      'https://sandbox.api.visa.com/visadirect/fundstransfer/v1/pullfundstransactions';

  static Future<Response> visaDirect() async {
    IOClient client = await VisaAuthentication.visaAuthClient();

    DateTime now = new DateTime.now();
    String dateTime = now.year.toString() +
        "-" +
        now.month.toString().padLeft(2, "0") +
        "-" +
        now.day.toString().padLeft(2, "0") +
        "T" +
        now.hour.toString().padLeft(2, "0") +
        ":" +
        now.minute.toString().padLeft(2, "0") +

        ":" +
        now.second.toString().padLeft(2, "0");

    final json =
        '{"acquirerCountryCode":"840","acquiringBin":"408999","amount":"124.02","businessApplicationId":"AA","cardAcceptor":{"address":{"country":"USA","county":"081","state":"CA","zipCode":"94404"},"idCode":"ABCD1234ABCD123","name":"Visa Inc. USA-Foster City","terminalId":"ABCD1234"},"cavv":"0700100038238906000013405823891061668252","foreignExchangeFeeTransaction":"11.99","localTransactionDateTime":"$dateTime","retrievalReferenceNumber":"330000550000","senderCardExpiryDate":"2015-10","senderCurrencyCode":"USD","senderPrimaryAccountNumber":"4895142232120006","surcharge":"11.99","systemsTraceAuditNumber":"451001","nationalReimbursementFee":"11.22","cpsAuthorizationCharacteristicsIndicator":"Y","addressVerificationData":{"street":"XYZ St","postalCode":"12345"},"settlementServiceIndicator":"9","colombiaNationalServiceData":{"countryCodeNationalService":"170","nationalReimbursementFee":"20.00","nationalNetMiscAmountType":"A","nationalNetReimbursementFeeBaseAmount":"20.00","nationalNetMiscAmount":"10.00","addValueTaxReturn":"10.00","taxAmountConsumption":"10.00","addValueTaxAmount":"10.00","costTransactionIndicator":"0","emvTransactionIndicator":"1","nationalChargebackReason":"11"},"riskAssessmentData":{"delegatedAuthenticationIndicator":true,"lowValueExemptionIndicator":true,"traExemptionIndicator":true,"trustedMerchantExemptionIndicator":true,"scpExemptionIndicator":true},"visaMerchantIdentifier":"73625198"}';

    return await client.post(visaDirectUrl,
        headers: VisaAuthentication.defaultHeader, body: json);
  }
}
