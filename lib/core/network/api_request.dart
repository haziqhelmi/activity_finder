import 'dart:io';

import 'package:activity_finder/constant/url.constant.dart';
import 'package:dio/dio.dart';

class ApiRequest {
  final Dio _dio = Dio();
  static final String _baseUrl = UrlConstant.baseUrl;

  ApiRequest() {
    _dio.options
      ..headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
      }
      ..responseType = ResponseType.json;
  }

  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? param,
  }) async {
    final Response result =
        await _dio.getUri(Uri.https(_baseUrl, endpoint, param));

    return result.data;
  }

  Future<dynamic> post(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    final Response result = await _dio
        .postUri(Uri.https(_baseUrl, endpoint), data: body)
        .timeout(const Duration(milliseconds: 30));

    return result.data;
  }
}
