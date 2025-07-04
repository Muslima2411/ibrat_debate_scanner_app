import "dart:async";

import "package:connectivity_plus/connectivity_plus.dart";
import "package:dio/dio.dart";

class Connection {

  const Connection({
    required this.dio,
    required this.connectivity,
  });
  final Dio dio;
  final Connectivity connectivity;

  Future<Response<dynamic>> scheduleRequestRetry(RequestOptions requestOptions) async {
    StreamSubscription<dynamic>? streamSubscription;
    final Completer<Response<dynamic>> responseCompleter = Completer<Response<dynamic>>();

    streamSubscription = connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> connectivityResult) {
        if (connectivityResult != ConnectivityResult.none) {
          streamSubscription?.cancel();
          responseCompleter.complete(
            dio.request<dynamic>(
              requestOptions.path,
              cancelToken: requestOptions.cancelToken,
              data: requestOptions.data,
              onReceiveProgress: requestOptions.onReceiveProgress,
              onSendProgress: requestOptions.onSendProgress,
              queryParameters: requestOptions.queryParameters,
              options: Options(
                method: requestOptions.method,
                contentType: requestOptions.contentType,
                extra: requestOptions.extra,
                followRedirects: requestOptions.followRedirects,
                headers: requestOptions.headers,
                listFormat: requestOptions.listFormat,
                maxRedirects: requestOptions.maxRedirects,
                receiveDataWhenStatusError: requestOptions.receiveDataWhenStatusError,
                receiveTimeout: requestOptions.receiveTimeout,
                requestEncoder: requestOptions.requestEncoder,
                responseDecoder: requestOptions.responseDecoder,
                responseType: requestOptions.responseType,
                sendTimeout: requestOptions.sendTimeout,
                validateStatus: requestOptions.validateStatus,
              ),
            ),
          );
        }
      },
    );

    return responseCompleter.future;
  }
}
