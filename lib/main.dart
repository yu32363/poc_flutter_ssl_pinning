import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

import 'package:poc_flutter_ssl_pinning/screens/news_screen.dart';
import 'package:poc_flutter_ssl_pinning/service/news_api_service.dart';

Future<SecurityContext> get globalContext async {
  final sslCert = await rootBundle.load('assets/certificate.pem');
  SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
  return securityContext;
}

Future<http.Client> getSSLPinningClient() async {
  HttpClient client = HttpClient(context: await globalContext);
  client.badCertificateCallback =
      (X509Certificate cert, String host, int port) => false;
  IOClient ioClient = IOClient(client);
  return ioClient;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final client = await getSSLPinningClient();

  final apiService = NewsApiService(client);

  runApp(
    MaterialApp(
      home: NewsScreen(
        apiService: apiService,
      ),
    ),
  );
}
