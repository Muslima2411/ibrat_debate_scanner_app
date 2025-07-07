import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ibrat_debate_scanner_app/src/common/routes/app_router.dart';
import '../../../common/local/app_storage.dart';
import '../../../data/entity/login_models/user_login_model.dart';
import '../../../data/repository/app_repository_impl.dart';

part 'login_vm.freezed.dart';

final loginVmProvider = ChangeNotifierProvider.autoDispose<LoginVM>(
  (ref) => LoginVM(),
);

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({@Default(false) bool isLoading, String? error}) =
      _LoginState;
}

class LoginVM extends ChangeNotifier {
  LoginState _state = const LoginState();
  LoginState get state => _state;

  final _repo = AppRepositoryImpl();

  Future<void> login(
    String username,
    String password,
    BuildContext context,
  ) async {
    _updateState(isLoading: true, error: null);

    try {
      final response = await _repo.loginUser(
        user: UserLoginModel(password: password, username: username),
      );

      if (response != null) {
        debugPrint("✅ Login Successful: $response");
        await AppStorage.$write(
          key: StorageKey.accessToken,
          value: response.access,
        );
        await AppStorage.$write(
          key: StorageKey.refreshToken,
          value: response.refresh,
        );
        await AppStorage.$write(key: StorageKey.user, value: username);

        debugPrint("🔒 Token saved securely");
        context.router.popAndPush(HomeRoute());
      } else {
        _updateState(error: "Invalid credentials");
      }
    } catch (e) {
      debugPrint("❌ Login Error: $e");
      _updateState(error: "Something went wrong");
    } finally {
      _updateState(isLoading: false);
    }
  }

  void _updateState({bool? isLoading, String? error}) {
    _state = _state.copyWith(
      isLoading: isLoading ?? _state.isLoading,
      error: error,
    );
    notifyListeners();
  }
}
