import 'dart:io';

import 'package:flutter/services.dart';

class VisaDirect {
  static Future<HttpClientResponse> visaDirect() async {
    SecurityContext securityContext = new SecurityContext();

    final ByteData crtData = await rootBundle.load('assets/cert.pem');
    final ByteData prvKey = await rootBundle
        .load('assets/key_be253fad-2454-430d-80cc-8d405fa6346a.pem');

    securityContext.setTrustedCertificatesBytes(crtData.buffer.asUint8List());
    securityContext.setClientAuthoritiesBytes(crtData.buffer.asUint8List());
    securityContext.useCertificateChainBytes(crtData.buffer.asUint8List());
    securityContext.usePrivateKeyBytes(prvKey.buffer.asUint8List());

    HttpClient client = new HttpClient(context: securityContext)
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);

    return await client
        .postUrl(Uri.parse(
            'https://sandbox.api.visa.com/visadirect/fundstransfer/v1/pullfundstransactions'))
        .then((HttpClientRequest request) {
      request.headers.add(HttpHeaders.authorizationHeader,
          "Basic NFU5WjY5UVBNQzJVWlBIQzBCSlAyMVVKT1RadGE2YV9ldm9FUEFiYTdKM0R4R3dSZzowa0VlZGY5ZFFuQ1ZtSktoMkVoeg==");
      request.headers.add(HttpHeaders.acceptHeader, "application/json");
      request.headers.add(HttpHeaders.contentTypeHeader, "application/json");
      request.write(
          '{"acquirerCountryCode":"840","acquiringBin":"408999","amount":"124.02","businessApplicationId":"AA","cardAcceptor":{"address":{"country":"USA","county":"081","state":"CA","zipCode":"94404"},"idCode":"ABCD1234ABCD123","name":"Visa Inc. USA-Foster City","terminalId":"ABCD1234"},"cavv":"0700100038238906000013405823891061668252","foreignExchangeFeeTransaction":"11.99","localTransactionDateTime":"2020-06-29T02:00:02","retrievalReferenceNumber":"330000550000","senderCardExpiryDate":"2015-10","senderCurrencyCode":"USD","senderPrimaryAccountNumber":"4895142232120006","surcharge":"11.99","systemsTraceAuditNumber":"451001","nationalReimbursementFee":"11.22","cpsAuthorizationCharacteristicsIndicator":"Y","addressVerificationData":{"street":"XYZ St","postalCode":"12345"},"settlementServiceIndicator":"9","colombiaNationalServiceData":{"countryCodeNationalService":"170","nationalReimbursementFee":"20.00","nationalNetMiscAmountType":"A","nationalNetReimbursementFeeBaseAmount":"20.00","nationalNetMiscAmount":"10.00","addValueTaxReturn":"10.00","taxAmountConsumption":"10.00","addValueTaxAmount":"10.00","costTransactionIndicator":"0","emvTransactionIndicator":"1","nationalChargebackReason":"11"},"riskAssessmentData":{"delegatedAuthenticationIndicator":true,"lowValueExemptionIndicator":true,"traExemptionIndicator":true,"trustedMerchantExemptionIndicator":true,"scpExemptionIndicator":true},"visaMerchantIdentifier":"73625198"}');
      return request.close();
    });
  }
}
