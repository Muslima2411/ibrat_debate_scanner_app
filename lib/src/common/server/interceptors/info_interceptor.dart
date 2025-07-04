import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class InfoInterceptor extends Interceptor {
  InfoInterceptor._();
  static final instance = InfoInterceptor._();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      print(
        '*** ON_REQUEST(${options.method}) ***\n'
        'URL: ${options.uri}\n'
        'Data: ${options.data}\n'
        'Headers: ${options.headers}\n'
        '----------------------',
      );
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print(
        '*** ON_RESPONSE(${response.statusCode}) ***\n'
        'URL: ${response.realUri}\n'
        'Data: ${response.data}\n'
        '----------------------',
      );
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print(
        '*** ON_ERROR ***\n'
        'URL: ${err.response?.realUri}\n'
        'Message: ${err.message}\n'
        '----------------------',
      );
    }
    super.onError(err, handler);
  }
}
