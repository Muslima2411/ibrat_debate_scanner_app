import "package:ibrat_debate_scanner_app/src/data/entity/login_models/login_response_model.dart";

import "../entity/debate_models/debate_event_response_model.dart";
import "../entity/login_models/user_login_model.dart";

abstract class AppRepository {
  Future<LoginResponseModel?> loginUser({required UserLoginModel user});
  Future<DebateEventResponse?> getDebateEvents({
    required int page,
    required int pageSize,
    String? searchQuery,
  });
}
