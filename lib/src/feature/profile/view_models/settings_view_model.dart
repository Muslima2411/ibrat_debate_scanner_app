import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../data/entity/user_model/user_model.dart';
import '../../../data/repository/app_repository_impl.dart';

part 'settings_view_model.freezed.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({
    UserModel? user,
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    String? error,
    @Default('B1-B2') String selectedEnglishLevel,
    @Default('<16') String selectedAgeRange,
  }) = _SettingsState;
}

class SettingsViewModel extends ChangeNotifier {
  static const List<String> englishLevels = ['B1-B2', 'C1-C2'];
  static const List<String> ageRanges = ['<16', '16-18', '19-24', '>24'];

  final AppRepositoryImpl _repository;

  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final MaskTextInputFormatter phoneFormatter;

  SettingsState _state = const SettingsState();
  SettingsState get state => _state;

  SettingsViewModel(this._repository) {
    nameController = TextEditingController();
    phoneController = TextEditingController();
    phoneFormatter = MaskTextInputFormatter(
      mask: '+998 (##) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
    );

    // Add listeners to controllers
    nameController.addListener(_onNameChanged);
    phoneController.addListener(_onPhoneChanged);
  }

  void _onNameChanged() {
    notifyListeners();
  }

  void _onPhoneChanged() {
    notifyListeners();
  }

  void initializeWithUser(UserModel? user) {
    if (user != null) {
      nameController.text = user.name ?? '';
      phoneController.text = user.phone ?? '';

      _state = _state.copyWith(
        user: user,
        selectedEnglishLevel: user.englishLevel ?? englishLevels.first,
        selectedAgeRange: _getValidAgeRange(user.age),
      );

      // Format phone number
      if (user.phone != null && user.phone!.isNotEmpty) {
        phoneFormatter.formatEditUpdate(
          TextEditingValue.empty,
          TextEditingValue(text: user.phone!),
        );
      }

      notifyListeners();
    }
  }

  String _getValidAgeRange(String? userAge) {
    if (userAge != null && ageRanges.contains(userAge)) {
      return userAge;
    }
    return ageRanges.first;
  }

  void setSelectedEnglishLevel(String level) {
    _state = _state.copyWith(selectedEnglishLevel: level);
    notifyListeners();
  }

  void setSelectedAgeRange(String ageRange) {
    _state = _state.copyWith(selectedAgeRange: ageRange);
    notifyListeners();
  }

  Future<void> saveUserInfo() async {
    if (_state.user == null) return;

    try {
      _state = _state.copyWith(isSaving: true, error: null);
      notifyListeners();

      final updatedUser = _state.user!.copyWith(
        name: nameController.text.isNotEmpty ? nameController.text : null,
        phone: phoneController.text.isNotEmpty ? phoneController.text : null,
        age: _state.selectedAgeRange,
        englishLevel: _state.selectedEnglishLevel,
      );

      final result = await _repository.updateUserInfo(updatedUser);

      if (result != null) {
        _state = _state.copyWith(user: result, isSaving: false, error: null);
        debugPrint('✅ User info saved successfully: $result');
      } else {
        _state = _state.copyWith(
          isSaving: false,
          error: 'Failed to save user information',
        );
        debugPrint('❌ Failed to save user info');
      }
    } catch (e) {
      _state = _state.copyWith(
        isSaving: false,
        error: 'Error saving user information: $e',
      );
      debugPrint('❌ Error saving user info: $e');
    }

    notifyListeners();
  }

  void clearError() {
    _state = _state.copyWith(error: null);
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.removeListener(_onNameChanged);
    phoneController.removeListener(_onPhoneChanged);
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}

final settingsViewModelProvider =
    ChangeNotifierProvider.autoDispose<SettingsViewModel>((ref) {
      final repository = AppRepositoryImpl(); // ideally injected too
      return SettingsViewModel(repository);
    });
