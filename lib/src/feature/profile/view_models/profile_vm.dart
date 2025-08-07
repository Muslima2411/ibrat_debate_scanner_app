import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/entity/user_model/user_model.dart';
import '../../home/view_models/user_vm.dart'; // Import UserVM

part 'profile_vm.freezed.dart';

// Simplified ProfileState - user data comes from UserVM
@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(false) bool isLoading,
    @Default(false) bool isRefreshing,
    String? error,
    @Default(false) bool isLogoutLoading,
    @Default(false) bool isUpdating,
  }) = _ProfileState;
}

final profileViewModelProvider = ChangeNotifierProvider<ProfileViewModel>(
  (ref) => ProfileViewModel(ref),
);

class ProfileViewModel extends ChangeNotifier {
  final Ref _ref;
  bool _isDisposed = false;

  ProfileState _state = const ProfileState();
  ProfileState get state => _state;

  ProfileViewModel(this._ref);

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  // Get user data from UserVM
  UserModel? get user {
    final userVM = _ref.read(userVmProvider);
    return userVM.state.user;
  }

  // Get user loading state from UserVM
  bool get isUserLoading {
    final userVM = _ref.read(userVmProvider);
    return userVM.state.isLoading;
  }

  // Get user error from UserVM
  String? get userError {
    final userVM = _ref.read(userVmProvider);
    return userVM.state.error;
  }

  // Get processed username for display
  String get displayUsername {
    final userVM = _ref.read(userVmProvider);
    return userVM.displayUsername;
  }

  // Get raw username
  String get username {
    final userVM = _ref.read(userVmProvider);
    return userVM.username;
  }

  // Check if user data is available
  bool get hasUser {
    final userVM = _ref.read(userVmProvider);
    return userVM.hasUser;
  }

  /// Refresh user data through UserVM
  Future<void> refreshUserData() async {
    if (_isDisposed) return;

    debugPrint('🔄 Refreshing user data via UserVM...');
    _updateState(isRefreshing: true, error: null);

    try {
      final userVM = _ref.read(userVmProvider);
      await userVM.refreshUser();

      _updateState(isRefreshing: false);
      debugPrint('✅ User data refresh completed');
    } catch (e) {
      debugPrint('❌ Error refreshing user data: $e');
      _updateState(
        isRefreshing: false,
        error: 'Failed to refresh profile data',
      );
    }
  }

  /// Update user profile data
  Future<void> updateUserProfile(UserModel updatedUser) async {
    if (_isDisposed) return;

    debugPrint('📝 Updating user profile...');
    _updateState(isUpdating: true, error: null);

    try {
      final userVM = _ref.read(userVmProvider);
      await userVM.updateUser(updatedUser);

      _updateState(isUpdating: false);
      debugPrint('✅ User profile updated successfully');
    } catch (e) {
      debugPrint('❌ Error updating user profile: $e');
      _updateState(isUpdating: false, error: 'Failed to update profile');
    }
  }

  /// Logout user
  Future<void> logoutUser() async {
    if (_isDisposed) return;

    debugPrint('🚪 Logging out user...');
    _updateState(isLogoutLoading: true, error: null);

    try {
      final userVM = _ref.read(userVmProvider);
      await userVM.clearUser();

      // Clear other data if needed (tokens, etc.)
      // await AppStorage.$remove(key: StorageKey.accessToken);
      // await AppStorage.$remove(key: StorageKey.refreshToken);

      _updateState(isLogoutLoading: false);
      debugPrint('✅ User logged out successfully');
    } catch (e) {
      debugPrint('❌ Error logging out user: $e');
      _updateState(isLogoutLoading: false, error: 'Failed to logout');
    }
  }

  /// Clear profile-specific errors (user errors are handled by UserVM)
  void clearError() {
    if (_isDisposed) return;
    _updateState(error: null);
  }

  /// Force refresh user data initialization
  Future<void> initializeUserData() async {
    if (_isDisposed) return;

    debugPrint('🔄 Initializing user data...');
    _updateState(isLoading: true, error: null);

    try {
      final userVM = _ref.read(userVmProvider);

      // If user data is not initialized, refresh it
      if (!userVM.state.isInitialized) {
        await userVM.refreshUser();
      }

      _updateState(isLoading: false);
      debugPrint('✅ User data initialization completed');
    } catch (e) {
      debugPrint('❌ Error initializing user data: $e');
      _updateState(
        isLoading: false,
        error: 'Failed to initialize profile data',
      );
    }
  }

  void _updateState({
    bool? isLoading,
    bool? isRefreshing,
    bool? isLogoutLoading,
    bool? isUpdating,
    String? error,
  }) {
    if (_isDisposed) return;

    _state = _state.copyWith(
      isLoading: isLoading ?? _state.isLoading,
      isRefreshing: isRefreshing ?? _state.isRefreshing,
      isLogoutLoading: isLogoutLoading ?? _state.isLogoutLoading,
      isUpdating: isUpdating ?? _state.isUpdating,
      error: error,
    );
    notifyListeners();
  }
}
