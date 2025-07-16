final class ApiConst {
  const ApiConst._();

  static const Duration connectionTimeout = Duration(minutes: 1);
  static const Duration sendTimeout = Duration(minutes: 1);

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

  static const String regionsApi = "$auth/regions/";
  static const String districtsApi = "$auth/districts/";

  static const String statsApi = "$ticketsApi/stats/";
}

final class ApiParams {
  const ApiParams._();

  static Map<String, dynamic> emptyParams() => <String, dynamic>{};

  static Map<String, dynamic> filterTickets({
    int? region,
    int? district,
    bool? isChecked,
  }) {
    return <String, dynamic>{
      "region": region ?? "",
      "district": district ?? "",
      "is_checked": isChecked ?? "",
    };
  }
}
