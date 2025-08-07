import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ibrat_debate_scanner_app/src/common/routes/app_router.dart';
import '../../../common/local/app_storage.dart';
import '../../../data/entity/login_models/user_login_model.dart';
import '../../../data/repository/app_repository_impl.dart';
import '../../home/view_models/user_vm.dart';

part 'login_vm.freezed.dart';

final loginVmProvider = ChangeNotifierProvider.autoDispose<LoginVM>(
  (ref) => LoginVM(ref),
);

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({@Default(false) bool isLoading, String? error}) =
      _LoginState;
}

class LoginVM extends ChangeNotifier {
  final Ref _ref;

  LoginState _state = const LoginState();
  LoginState get state => _state;

  final _repo = AppRepositoryImpl();

  LoginVM(this._ref);

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

        // Store tokens
        await AppStorage.$write(
          key: StorageKey.accessToken,
          value: response.access,
        );
        await AppStorage.$write(
          key: StorageKey.refreshToken,
          value: response.refresh,
        );

        debugPrint("🔒 Tokens saved securely");

        // Get UserVM instance and refresh user data
        final userVM = _ref.read(userVmProvider);

        // Wait for user data to be refreshed
        await userVM.refreshUser();

        // Check if user data was loaded successfully
        if (userVM.hasUser) {
          debugPrint(
            "✅ User data loaded successfully: ${userVM.displayUsername}",
          );

          // Navigate only if everything succeeded and context is still mounted
          if (context.mounted) {
            context.router.popAndPush(HomeRoute());
          }
        } else {
          // User data failed to load
          debugPrint("❌ Failed to load user data after login");
          _updateState(
            error:
                userVM.state.error ??
                "Login successful but failed to load profile",
          );
        }
      } else {
        _updateState(error: "Invalid credentials");
      }
    } catch (e) {
      debugPrint("❌ Login Error: $e");
      _updateState(error: "Login failed. Please try again.");
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

  void clearError() {
    _updateState(error: null);
  }
}
