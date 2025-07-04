import "dart:developer";

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "../../common/server/api/api.dart";
import "../../common/server/api/api_constants.dart";

import "../entity/user_login_model.dart";
import "app_repository.dart";

@immutable
final class AppRepositoryImpl implements AppRepository {
  factory AppRepositoryImpl() => _impl;

  const AppRepositoryImpl._internal();

  static const AppRepositoryImpl _impl = AppRepositoryImpl._internal();

  @override
  Future<CheckPhone?> loginUser({required String number}) async {
    final String? str = await ApiService.post(
      ApiConst.apiSendCode,
      <String, dynamic>{"phoneNumber": number},
    );
    if (str != null) {
      log(str);
      return checkPhoneFromJson(str);
    } else {
      return null;
    }
  }
}
