import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/entity/user_model/user_model.dart';
import '../../../data/repository/app_repository_impl.dart';

part 'profile_vm.freezed.dart';

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(false) bool isLoading,
    @Default(false) bool isRefreshing,
    UserModel? user,
    String? error,
  }) = _ProfileState;
}

class ProfileViewModel extends ChangeNotifier {
  final AppRepositoryImpl _repository;

  ProfileState _state = const ProfileState(isLoading: true);
  ProfileState get state => _state;

  ProfileViewModel({AppRepositoryImpl? repository})
    : _repository = repository ?? AppRepositoryImpl() {
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    debugPrint('🔄 Loading user data...');
    _updateState(_state.copyWith(isLoading: true, error: null));

    try {
      final user = await _repository.getCurrentUser();

      if (user != null) {
        debugPrint('✅ User data loaded successfully');
        _updateState(
          _state.copyWith(isLoading: false, user: user, error: null),
        );
      } else {
        debugPrint('❌ Failed to load user data');
        _updateState(
          _state.copyWith(isLoading: false, error: 'Failed to load user data'),
        );
      }
    } catch (e) {
      debugPrint('❌ Error loading user data: $e');
      _updateState(
        _state.copyWith(isLoading: false, error: 'Error loading user data: $e'),
      );
    }
  }

  Future<void> refreshUserData() async {
    debugPrint('🔄 Refreshing user data...');
    _updateState(_state.copyWith(isRefreshing: true, error: null));

    try {
      final user = await _repository.getCurrentUser();

      if (user != null) {
        debugPrint('✅ User data refreshed successfully');
        _updateState(
          _state.copyWith(isRefreshing: false, user: user, error: null),
        );
      } else {
        debugPrint('❌ Failed to refresh user data');
        _updateState(
          _state.copyWith(
            isRefreshing: false,
            error: 'Failed to refresh user data',
          ),
        );
      }
    } catch (e) {
      debugPrint('❌ Error refreshing user data: $e');
      _updateState(
        _state.copyWith(
          isRefreshing: false,
          error: 'Error refreshing user data: $e',
        ),
      );
    }
  }

  void clearError() {
    _updateState(_state.copyWith(error: null));
  }

  void _updateState(ProfileState newState) {
    _state = newState;
    notifyListeners();
  }
}
