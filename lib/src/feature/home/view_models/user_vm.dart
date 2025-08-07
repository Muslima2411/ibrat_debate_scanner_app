import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/local/app_storage.dart';
import '../../../data/entity/user_model/user_model.dart';
import '../../../data/repository/app_repository_impl.dart';

part 'user_vm.freezed.dart';

final userVmProvider = ChangeNotifierProvider<UserVM>((ref) => UserVM());

@freezed
abstract class UserState with _$UserState {
  const factory UserState({
    @Default(false) bool isLoading,
    @Default(false) bool isInitialized,
    UserModel? user,
    String? error,
  }) = _UserState;
}

class UserVM extends ChangeNotifier {
  UserState _state = const UserState();
  UserState get state => _state;

  final _repo = AppRepositoryImpl();
  bool _isDisposed = false; // Add disposal tracking

  UserVM() {
    _initializeUser();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  /// Initialize user data with storage-first approach
  Future<void> _initializeUser() async {
    if (_isDisposed) return; // Early return if disposed

    _updateState(isLoading: true, error: null);

    try {
      // Step 1: Check if user data exists in storage
      final userFromStorage = await _getUserFromStorage();

      if (_isDisposed) return; // Check disposal after async operation

      if (userFromStorage != null) {
        // User found in storage - use it immediately
        debugPrint("✅ User loaded from storage: ${userFromStorage.username}");
        _updateState(
          user: userFromStorage,
          isLoading: false,
          isInitialized: true,
        );
        return;
      }

      // Step 2: No user in storage - fetch from server
      debugPrint("📡 No user in storage, fetching from server...");
      await _fetchAndStoreUser();
    } catch (e) {
      if (_isDisposed) return; // Check disposal before error update

      debugPrint("❌ Error initializing user: $e");
      _updateState(
        error: "Failed to load user data",
        isLoading: false,
        isInitialized: true,
      );
    }
  }

  /// Get user data from local storage
  Future<UserModel?> _getUserFromStorage() async {
    try {
      final jsonString = await AppStorage.$read(key: StorageKey.user);

      if (jsonString != null && jsonString.isNotEmpty) {
        final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
        return UserModel.fromJson(jsonData);
      }

      return null;
    } catch (e) {
      debugPrint("❌ Error reading user from storage: $e");
      return null;
    }
  }

  /// Fetch user data from server and store it locally
  Future<void> _fetchAndStoreUser() async {
    if (_isDisposed) return;

    try {
      // Clear old (possibly broken) cached user
      await AppStorage.$delete(key: StorageKey.user);

      // Step 1: Try fetching current user
      UserModel? user = await _repo.getCurrentUser();

      debugPrint("📦 Raw user from API: ${user?.toJson()}");

      if (_isDisposed) return;

      // Step 2: Fallback – try by ID if null
      if (user == null || user.id == null) {
        final userId = await AppStorage.$read(key: StorageKey.userId);
        if (_isDisposed) return;

        if (userId != null && userId.isNotEmpty) {
          user = await _repo.getUserById(userId);
          debugPrint("📦 Raw user from getUserById(): ${user?.toJson()}");
          if (_isDisposed) return;
        }
      }

      // Step 3: Store if valid user
      if (user != null && user.id != null) {
        await _saveUserToStorage(user);
        if (_isDisposed) return;

        debugPrint("✅ User fetched and saved: ${user.username}");
        _updateState(user: user, isLoading: false, isInitialized: true);
      } else {
        debugPrint("⚠️ API returned null user data");
        _updateState(
          error: "User data not available",
          isLoading: false,
          isInitialized: true,
        );
      }
    } catch (e, stack) {
      if (_isDisposed) return;

      debugPrint("❌ Error fetching user from server: $e");
      debugPrint("📛 StackTrace:\n$stack");

      _updateState(
        error: "Failed to fetch user data from server",
        isLoading: false,
        isInitialized: true,
      );
    }
  }

  /// Save user data to local storage
  Future<void> _saveUserToStorage(UserModel user) async {
    try {
      await AppStorage.$write(
        key: StorageKey.user,
        value: jsonEncode(user.toJson()),
      );
      debugPrint("💾 User saved to storage");
    } catch (e) {
      debugPrint("❌ Error saving user to storage: $e");
      // Don't throw here - user data is still available in memory
    }
  }

  /// Refresh user data (force fetch from server)
  Future<void> refreshUser() async {
    if (_isDisposed) return;

    debugPrint("🔄 Refreshing user data...");
    _updateState(isLoading: true, error: null);
    await _fetchAndStoreUser();
  }

  /// Update user data after profile changes
  Future<void> updateUser(UserModel updatedUser) async {
    if (_isDisposed) return;

    try {
      await _saveUserToStorage(updatedUser);
      _updateState(user: updatedUser);
      debugPrint("✅ User updated successfully");
    } catch (e) {
      debugPrint("❌ Error updating user: $e");
      _updateState(error: "Failed to update user data");
    }
  }

  /// Clear user data (for logout)
  Future<void> clearUser() async {
    if (_isDisposed) return;

    try {
      await AppStorage.$delete(key: StorageKey.user);
      _updateState(user: null, isInitialized: false, error: null);
      debugPrint("🗑️ User data cleared");
    } catch (e) {
      debugPrint("❌ Error clearing user data: $e");
    }
  }

  /// Get username safely (raw username)
  String get username => _state.user?.username ?? '';

  /// Get processed username for display (removes id_admin prefix)
  String get displayUsername {
    final rawUsername = _state.user?.username ?? '';

    // If username is empty, try to get from user ID or return fallback
    if (rawUsername.isEmpty) {
      return _getFallbackUsername();
    }

    return _processUsername(rawUsername);
  }

  /// Get fallback username when main username is empty
  String _getFallbackUsername() {
    // Try to get username from user ID or other fields
    final user = _state.user;
    if (user?.name != null && user!.name!.isNotEmpty) {
      return user.name!;
    }

    // Could also try phone number or other identifier
    if (user?.id != null && user!.id!.isNotEmpty) {
      return "User ${user.id!.substring(0, 8)}...";
    }

    return 'User'; // Final fallback
  }

  /// Process username by removing first two parts (id_admin)
  String _processUsername(String username) {
    if (username.isEmpty) return '';

    try {
      final parts = username.split('_');

      // If username has less than 3 parts, return as is
      if (parts.length <= 2) {
        return username;
      }

      // Remove first two parts (id_admin) and join the rest
      final processedParts = parts.skip(2).toList();
      final processedUsername = processedParts.join('_');

      debugPrint("🔄 Username processed: '$username' -> '$processedUsername'");
      return processedUsername;
    } catch (e) {
      debugPrint("❌ Error processing username: $e");
      // Return original username if processing fails
      return username;
    }
  }

  /// Check if user is available
  bool get hasUser => _state.user != null;

  void _updateState({
    bool? isLoading,
    bool? isInitialized,
    UserModel? user,
    String? error,
  }) {
    // Check if disposed before updating state
    if (_isDisposed) {
      debugPrint("⚠️ Attempted to update disposed UserVM state");
      return;
    }

    _state = _state.copyWith(
      isLoading: isLoading ?? _state.isLoading,
      isInitialized: isInitialized ?? _state.isInitialized,
      user: user ?? _state.user,
      error: error,
    );
    notifyListeners();
  }

  /// Clear error state
  void clearError() {
    if (_isDisposed) return;
    _updateState(error: null);
  }
}
