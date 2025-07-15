import "package:ibrat_debate_scanner_app/src/data/entity/login_models/login_response_model.dart";
import "package:ibrat_debate_scanner_app/src/data/entity/user_model/user_model.dart";

import "../entity/debate_models/debate_event_response_model.dart";
import "../entity/login_models/user_login_model.dart";
import "../entity/ticket_model/ticket_model.dart";
import "../entity/user_model/set_pass_response.dart";

abstract class AppRepository {
  Future<LoginResponseModel?> loginUser({required UserLoginModel user});
  Future<DebateEventResponse?> getDebateEvents({
    required int page,
    required int pageSize,
    String? searchQuery,
  });
  Future<UserModel?> getCurrentUser();
  Future<TicketModel?> getTicketById(String ticketId);
  Future<UserModel?> getUserById(String userId);
  Future<TicketModel?> markTicketAsChecked(String ticketId);
  Future<UserModel?> updateUserInfo(UserModel updatedUser);
  Future<SetPassApiResponse<bool>> changePassword(
    String currentPassword,
    String newPassword,
  );
}
