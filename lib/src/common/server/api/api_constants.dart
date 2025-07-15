import 'package:ibrat_debate_scanner_app/setup.dart';

final class ApiConst {
  const ApiConst._();

  static const Duration connectionTimeout = Duration(minutes: 1);
  static const Duration sendTimeout = Duration(minutes: 1);

  // https://api.ibratdebate.uz/api/auth/token/
  static const String baseUrl = "https://api.ibratdebate.uz";

  static const String version = "/api";

  static const String auth = "$version/auth";
  static const String core = "$version/core";

  static const String loginApi = "$auth/token/";
  static const String refreshTokenApi = "$auth/token/refresh/";

  static const String debatesApi = "$core/debates";
  static const String ticketsApi = "$core/tickets";

  static const String users = "$auth/users";
  static const String meApi = "$users/me/";
  static const String setPasswordApi = "$users/set_password/";
}

final class ApiParams {
  const ApiParams._();

  // static Map<String, dynamic> cabinetSmsCheckParams({
  //   required String phone,
  //   required String code,
  // }) => <String, dynamic>{"phone": phone, "code": code};

  static Map<String, dynamic> emptyParams() => <String, dynamic>{};
}
