
class AppConfig {

  AppConfig({
    required this.appTheme,
    required this.appLanguage,
    required this.appBlocked,
    required this.switchedInitialScreen,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json) {
    return AppConfig(
      appTheme: json["appTheme"] as String ,
      appLanguage: json["appLanguage"] as String,
      appBlocked: json["appBlocked"] as bool,
      switchedInitialScreen: json["switchedInitialScreen"] as bool,
    );
  }
  final String appTheme;
  final String appLanguage;
  final bool appBlocked;
  final bool switchedInitialScreen;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "appTheme": appTheme,
      "appLanguage": appLanguage,
      "appBlocked": appBlocked,
      "switchedInitialScreen": switchedInitialScreen,
    };
  }
}
