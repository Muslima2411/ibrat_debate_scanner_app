import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repository/app_repository_impl.dart';
import 'change_password_state.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  final AppRepositoryImpl _repository;

  ChangePasswordViewModel(this._repository);

  ChangePasswordState _state = const ChangePasswordState();
  ChangePasswordState get state => _state;

  void updateCurrentPassword(String password) {
    _state = _state.copyWith(currentPassword: password, errorMessage: null);
    notifyListeners();
  }

  void updateNewPassword(String password) {
    _state = _state.copyWith(newPassword: password, errorMessage: null);
    notifyListeners();
  }

  void updateConfirmPassword(String password) {
    _state = _state.copyWith(confirmPassword: password, errorMessage: null);
    notifyListeners();
  }

  void toggleCurrentPasswordVisibility() {
    _state = _state.copyWith(
      isCurrentPasswordVisible: !_state.isCurrentPasswordVisible,
    );
    notifyListeners();
  }

  void toggleNewPasswordVisibility() {
    _state = _state.copyWith(
      isNewPasswordVisible: !_state.isNewPasswordVisible,
    );
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _state = _state.copyWith(
      isConfirmPasswordVisible: !_state.isConfirmPasswordVisible,
    );
    notifyListeners();
  }

  bool _validatePasswords() {
    if (_state.currentPassword.isEmpty) {
      _state = _state.copyWith(errorMessage: 'Current password is required');
      notifyListeners();
      return false;
    }

    if (_state.newPassword.isEmpty) {
      _state = _state.copyWith(errorMessage: 'New password is required');
      notifyListeners();
      return false;
    }

    if (_state.newPassword.length < 8) {
      _state = _state.copyWith(
        errorMessage: 'New password must be at least 8 characters long',
      );
      notifyListeners();
      return false;
    }

    // if (_state.newPassword != _state.confirmPassword) {
    //   _state = _state.copyWith(errorMessage: 'New passwords do not match');
    //   notifyListeners();
    //   return false;
    // }

    if (_state.currentPassword == _state.newPassword) {
      _state = _state.copyWith(
        errorMessage: 'New password must be different from current password',
      );
      notifyListeners();
      return false;
    }

    return true;
  }

  Future<void> changePassword() async {
    if (!_validatePasswords()) return;

    _state = _state.copyWith(
      isLoading: true,
      errorMessage: null,
      resultMessage: null,
      isSuccess: false,
      showResult: false,
    );
    notifyListeners();

    try {
      final response = await _repository.changePassword(
        _state.currentPassword,
        _state.newPassword,
      );

      // Always show the result from the API
      _state = _state.copyWith(
        isLoading: false,
        isSuccess: response.isSuccess,
        resultMessage: response.details,
        showResult: true,
        errorMessage: null,
      );
    } catch (e) {
      String message = 'Something went wrong. Please try again.';

      if (e is DioException) {
        if (e.response?.statusCode == 400) {
          message = 'Invalid password input. Please try again.';
        } else if (e.response?.statusCode == 401) {
          message = 'Unauthorized. Please log in again.';
        } else if (e.response?.statusCode == 500) {
          message = 'Server error. Please try again later.';
        } else {
          message = 'Network error. Please check your connection.';
        }
      }

      _state = _state.copyWith(
        isLoading: false,
        errorMessage: message,
        showResult: false,
      );
    }
    notifyListeners();
  }

  void dismissResult() {
    _state = _state.copyWith(showResult: false, resultMessage: null);
    notifyListeners();
  }

  void resetState() {
    _state = const ChangePasswordState();
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

final changePasswordViewModelProvider =
    ChangeNotifierProvider<ChangePasswordViewModel>((ref) {
      final repository = ref.watch(appRepositoryProvider);
      return ChangePasswordViewModel(repository);
    });

final appRepositoryProvider = Provider<AppRepositoryImpl>((ref) {
  return AppRepositoryImpl(); // Initialize with your API client
});
