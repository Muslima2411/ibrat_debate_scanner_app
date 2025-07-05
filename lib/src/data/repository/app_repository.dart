import "package:ibrat_debate_scanner_app/src/data/entity/login_response_model.dart";
import "package:ibrat_debate_scanner_app/src/data/entity/user_login_model.dart";

abstract class AppRepository {
  Future<LoginResponseModel?> loginUser({required UserLoginModel user});
}
