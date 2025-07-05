final class ApiConst {
  const ApiConst._();

  static const Duration connectionTimeout = Duration(minutes: 1);
  static const Duration sendTimeout = Duration(minutes: 1);

  // https://api.ibratdebate.uz/api/auth/token/
  static const String baseUrl = "https://api.ibratdebate.uz";

  static const String version = "/api";

  static const String auth = "$version/auth";
  static const String loginApi = "$auth/token/";
}

final class ApiParams {
  const ApiParams._();

  // static Map<String, dynamic> cabinetSmsCheckParams({
  //   required String phone,
  //   required String code,
  // }) => <String, dynamic>{"phone": phone, "code": code};

  static Map<String, dynamic> emptyParams() => <String, dynamic>{};
}
