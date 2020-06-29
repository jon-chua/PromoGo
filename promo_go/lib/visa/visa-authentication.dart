import 'dart:io';

import 'package:flutter/services.dart';

class VisaAuthentication {
  static Future<HttpClient> visaAuthClient() async {
    SecurityContext securityContext = new SecurityContext();

    final ByteData crtData = await rootBundle.load('assets/cert.pem');
    final ByteData prvKey = await rootBundle
        .load('assets/key_be253fad-2454-430d-80cc-8d405fa6346a.pem');

    securityContext.setTrustedCertificatesBytes(crtData.buffer.asUint8List());
    securityContext.setClientAuthoritiesBytes(crtData.buffer.asUint8List());
    securityContext.useCertificateChainBytes(crtData.buffer.asUint8List());
    securityContext.usePrivateKeyBytes(prvKey.buffer.asUint8List());

    return new HttpClient(context: securityContext)
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
  }
}
