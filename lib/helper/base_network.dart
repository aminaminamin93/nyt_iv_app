import 'dart:io';

import 'package:dio/dio.dart';

class BaseNetwork {
  static Future<Dio> network() async {
    final header = {'Accept': 'application/json'};

    return Dio(
      BaseOptions(
          baseUrl: "http://192.168.227.1:3000",
          headers: header,
          contentType: Headers.formUrlEncodedContentType, //ContentType.json,
          followRedirects: false,
      ),
    );
  }
}