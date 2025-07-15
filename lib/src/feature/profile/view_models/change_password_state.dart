import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_password_state.freezed.dart';

@freezed
abstract class ChangePasswordState with _$ChangePasswordState {
  const factory ChangePasswordState({
    @Default(false) bool isLoading,
    @Default('') String currentPassword,
    @Default('') String newPassword,
    @Default('') String confirmPassword,
    @Default(false) bool isCurrentPasswordVisible,
    @Default(false) bool isNewPasswordVisible,
    @Default(false) bool isConfirmPasswordVisible,
    String? errorMessage,
    String? resultMessage,
    @Default(false) bool isSuccess,
    @Default(false) bool showResult,
  }) = _ChangePasswordState;
}
