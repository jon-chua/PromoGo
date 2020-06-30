import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/io_client.dart';

class VisaAuthentication {
  static Map<String, String> defaultHeader = {
    "authorization":
        "Basic NFU5WjY5UVBNQzJVWlBIQzBCSlAyMVVKT1RadGE2YV9ldm9FUEFiYTdKM0R4R3dSZzowa0VlZGY5ZFFuQ1ZtSktoMkVoeg==",
    "accept": "application/json",
    "content-type": "application/json"
  };

  static Future<IOClient> visaAuthClient() async {
    SecurityContext securityContext = new SecurityContext();

    final ByteData crtData = await rootBundle.load('assets/cert.pem');
    final ByteData prvKey = await rootBundle
        .load('assets/key_be253fad-2454-430d-80cc-8d405fa6346a.pem');
    securityContext.setTrustedCertificatesBytes(crtData.buffer.asUint8List());
    securityContext.setClientAuthoritiesBytes(crtData.buffer.asUint8List());
    securityContext.useCertificateChainBytes(crtData.buffer.asUint8List());
    securityContext.usePrivateKeyBytes(prvKey.buffer.asUint8List());

    final HttpClient client = new HttpClient(context: securityContext)
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);

    return new IOClient(client);
  }
}
