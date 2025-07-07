import "dart:convert";
import "dart:developer";

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "../../common/server/api/api.dart";
import "../../common/server/api/api_constants.dart";

import "../entity/debate_models/debate_event_response_model.dart";
import "../entity/login_models/login_response_model.dart";
import "../entity/login_models/user_login_model.dart";
import "app_repository.dart";

@immutable
final class AppRepositoryImpl implements AppRepository {
  factory AppRepositoryImpl() => _impl;

  const AppRepositoryImpl._internal();

  static const AppRepositoryImpl _impl = AppRepositoryImpl._internal();

  @override
  Future<LoginResponseModel?> loginUser({required UserLoginModel user}) async {
    final String? str = await ApiService.post(ApiConst.loginApi, user.toJson());
    if (str != null) {
      log(str);
      return LoginResponseModel.fromJson(jsonDecode(str));
    } else {
      return null;
    }
  }

  @override
  Future<DebateEventResponse?> getDebateEvents({
    required int page,
    required int pageSize,
    String? searchQuery,
  }) async {
    try {
      // TODO: Implement pagination later

      // final Map<String, dynamic> queryParams = <String, dynamic>{};
      //
      // // Pagination parameters (commented out for now)
      // // queryParams['page'] = page.toString();
      // // queryParams['page_size'] = pageSize.toString();
      //
      // if (searchQuery != null && searchQuery.isNotEmpty) {
      //   queryParams['search'] = searchQuery;
      // }

      String url = ApiConst.debatesApi;

      // if (queryParams.isNotEmpty) {
      //   final String queryString = queryParams.entries
      //       .map((e) => '${e.key}=${Uri.encodeComponent(e.value)}')
      //       .join('&');
      //   url = '$url?$queryString';
      // }

      final String? response = await ApiService.get(
        url,
        ApiParams.emptyParams(),
      );

      if (response != null) {
        log('Debate events response: $response');
        final Map<String, dynamic> jsonResponse = jsonDecode(response);
        return DebateEventResponse.fromJson(jsonResponse);
      } else {
        log('Failed to get debate events: response is null');
        return null;
      }
    } catch (e, stackTrace) {
      log('Error getting debate events: $e', stackTrace: stackTrace);
      return null;
    }
  }
}
