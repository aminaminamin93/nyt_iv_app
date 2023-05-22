import 'dart:io';

import 'package:dio/dio.dart';

class BaseNetwork {
  static Future<Dio> network() async {
    final header = {'Accept': 'application/json'};

    return Dio(
      BaseOptions(
          baseUrl: "https://api.nytimes.com",
          headers: header,
          contentType: Headers.formUrlEncodedContentType, //ContentType.json,
          followRedirects: false,
      ),
    );
  }
}