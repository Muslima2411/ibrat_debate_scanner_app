import "dart:async";
import "dart:convert";
import "dart:io";
import "package:connectivity_plus/connectivity_plus.dart";
import "package:dio/dio.dart";
import "package:dio/io.dart";
import "package:flutter/foundation.dart";
import "package:flutter/services.dart";
import "package:l/l.dart";
import "../../local/app_storage.dart";
import "../../utils/jwt_utils.dart";
import "../interceptors/connectivity_interceptor.dart";
import "api_connection.dart";
import "api_constants.dart";

@immutable
class ApiService {
  factory ApiService() => _service;

  const ApiService._internal();

  static const ApiService _service = ApiService._internal();

  // Add a flag to prevent recursive refresh calls
  static bool _isRefreshing = false;

  static Future<Dio> initDio({bool skipTokenRefresh = false}) async {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: ApiConst.baseUrl,
        headers: await ApiService.getHeaders(
          skipTokenRefresh: skipTokenRefresh,
        ),
        connectTimeout: ApiConst.connectionTimeout,
        receiveTimeout: ApiConst.sendTimeout,
        sendTimeout: ApiConst.sendTimeout,
        validateStatus: (int? status) => status != null && status < 205,
      ),
    );

    dio.interceptors.addAll(<Interceptor>[
      ConnectivityInterceptor(
        requestReceiver: Connection(dio: dio, connectivity: Connectivity()),
      ),
    ]);

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
          return client;
        };

    return dio;
  }

  static Future<Map<String, String>> getHeaders({
    bool isUpload = false,
    bool skipTokenRefresh = false,
  }) async {
    final Map<String, String> headers = <String, String>{
      "Content-type": isUpload ? "multipart/form-data" : "application/json",
    };

    String? token = await AppStorage.$read(key: StorageKey.accessToken) ?? "";

    // Only refresh token if not already refreshing and not skipping
    if (!skipTokenRefresh && !_isRefreshing && isAccessTokenExpired(token)) {
      debugPrint('⏳ Access token expired. Refreshing...');
      final success = await ApiService.refreshAccessToken();
      if (success) {
        token = await AppStorage.$read(key: StorageKey.accessToken) ?? "";
      }
    }

    if (token.isNotEmpty) {
      headers["Authorization"] = "Bearer $token";
    }

    return headers;
  }

  static Future<String?> get(String api, Map<String, dynamic> params) async {
    try {
      final Response<dynamic> response = await (await initDio()).get<dynamic>(
        api,
        queryParameters: params,
      );
      return jsonEncode(response.data);
    } on TimeoutException catch (_) {
      l.e("The connection has timed out, Please try again!");
      rethrow;
    } on DioError catch (e) {
      l.e(e.response.toString());
      rethrow;
    } on Object catch (e) {
      l.e(e.toString());
      rethrow;
    }
  }

  static Future<String?> post(
    String api,
    Map<String, dynamic> data, [
    Map<String, dynamic> params = const <String, dynamic>{},
  ]) async {
    try {
      final Response<dynamic> response = await (await initDio()).post<dynamic>(
        api,
        data: data,
        queryParameters: params,
      );
      return jsonEncode(response.data);
    } on TimeoutException catch (_) {
      l.e("The connection has timed out, Please try again!");
      rethrow;
    } on DioError catch (e) {
      l.e(e.response.toString());
      rethrow;
    } on Object catch (_) {
      rethrow;
    }
  }

  static Future<String?> put(String api, Map<String, dynamic> data) async {
    try {
      final Response<dynamic> response = await (await initDio()).put<dynamic>(
        api,
        data: data,
      );

      return jsonEncode(response.data);
    } on TimeoutException catch (_) {
      l.e("The connection has timed out, Please try again!");
      rethrow;
    } on DioError catch (e) {
      l.e(e.response.toString());
      rethrow;
    } on Object catch (_) {
      rethrow;
    }
  }

  static Future<String?> patch(
    String api,
    Map<String, dynamic> data, [
    Map<String, dynamic> params = const <String, dynamic>{},
  ]) async {
    try {
      final Response<dynamic> response = await (await initDio()).patch<dynamic>(
        api,
        data: data,
        queryParameters: params,
      );
      return jsonEncode(response.data);
    } on TimeoutException catch (_) {
      l.e("The connection has timed out, Please try again!");
      rethrow;
    } on DioError catch (e) {
      l.e(e.response.toString());
      rethrow;
    } on Object catch (_) {
      rethrow;
    }
  }

  static Future<String?> delete(String api, Map<String, dynamic> params) async {
    try {
      final Response<dynamic> _ = await (await initDio()).delete<dynamic>(
        api,
        queryParameters: params,
      );
      return "success";
    } on TimeoutException catch (_) {
      l.e("The connection has timed out, Please try again!");
      rethrow;
    } on DioError catch (e) {
      l.e(e.response.toString());
      rethrow;
    } on Object catch (_) {
      rethrow;
    }
  }

  static Future<bool> refreshAccessToken() async {
    // Prevent concurrent refresh calls
    if (_isRefreshing) {
      debugPrint('🔄 Already refreshing token, waiting...');
      return false;
    }

    _isRefreshing = true;
    debugPrint('🔄 ===== Token Refresh Started =====');

    try {
      final String? refreshToken = await AppStorage.$read(
        key: StorageKey.refreshToken,
      );

      if (refreshToken == null || refreshToken.isEmpty) {
        debugPrint('🔑 No refresh token found.');
        return false;
      }

      debugPrint('🔍 Analyzing refresh token before use...');
      analyzeToken(refreshToken, tokenType: 'Refresh Token');

      // Check if refresh token is expired
      if (isAccessTokenExpired(refreshToken)) {
        debugPrint('🔑 Refresh token is also expired.');
        return false;
      }

      debugPrint('📡 Making refresh request to: ${ApiConst.refreshTokenApi}');

      // Create a separate Dio instance for refresh to avoid recursion
      final refreshDio = Dio(
        BaseOptions(
          baseUrl: ApiConst.baseUrl,
          headers: {"Content-type": "application/json"},
          connectTimeout: ApiConst.connectionTimeout,
          receiveTimeout: ApiConst.sendTimeout,
          sendTimeout: ApiConst.sendTimeout,
          validateStatus: (int? status) => status != null && status < 205,
        ),
      );

      final response = await refreshDio.post(
        ApiConst.refreshTokenApi,
        data: {'refresh': refreshToken},
      );

      debugPrint('📡 Refresh response status: ${response.statusCode}');
      debugPrint('📡 Refresh response data: ${response.data}');

      if (response.statusCode == 200) {
        final json = response.data;

        final newAccessToken = json['access'] as String?;
        final newRefreshToken = json['refresh'] as String?;

        debugPrint(
          '🔑 New access token received: ${newAccessToken != null ? 'Yes' : 'No'}',
        );
        debugPrint(
          '🔑 New refresh token received: ${newRefreshToken != null ? 'Yes' : 'No'}',
        );

        if (newAccessToken != null && newAccessToken.isNotEmpty) {
          await AppStorage.$write(
            key: StorageKey.accessToken,
            value: newAccessToken,
          );
          debugPrint('💾 New access token saved to storage');

          // Analyze the new token
          analyzeToken(newAccessToken, tokenType: 'New Access Token');
        }

        if (newRefreshToken != null && newRefreshToken.isNotEmpty) {
          await AppStorage.$write(
            key: StorageKey.refreshToken,
            value: newRefreshToken,
          );
          debugPrint('💾 New refresh token saved to storage');

          // Analyze the new refresh token
          analyzeToken(newRefreshToken, tokenType: 'New Refresh Token');
        }

        debugPrint('✅ Access token refreshed successfully.');
        return true;
      } else {
        debugPrint(
          '❌ Failed to refresh access token. Status: ${response.statusCode}',
        );
        return false;
      }
    } catch (e) {
      debugPrint('❌ Error refreshing token: $e');
      return false;
    } finally {
      _isRefreshing = false;
      debugPrint('🔄 ===== Token Refresh Completed =====');
    }
  }
}

extension ListFileToFormData on List<File> {
  Future<FormData> mappedFormData({required bool isPickedFile}) async =>
      FormData.fromMap(<String, MultipartFile>{
        for (final File v in this) ...<String, MultipartFile>{
          DateTime.now().toString(): MultipartFile.fromBytes(
            isPickedFile
                ? v.readAsBytesSync()
                : (await rootBundle.load(v.path)).buffer.asUint8List(),
            filename: v.path.substring(v.path.lastIndexOf("/")),
          ),
        },
      });
}
