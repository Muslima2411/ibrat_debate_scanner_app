import "../entity/user_login_model.dart";

abstract class AppRepository {
  Future<CheckPhone?> loginUser({required String number});
}
