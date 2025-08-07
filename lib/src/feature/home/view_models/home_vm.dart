import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/local/app_storage.dart';
import '../../../data/entity/debate_models/debate_event_model.dart';
import '../../../data/entity/user_model/user_model.dart';
import '../../../data/repository/app_repository.dart';
import '../../../data/repository/app_repository_impl.dart';
import 'user_vm.dart'; // Import UserVM

final homeViewModelProvider = ChangeNotifierProvider<HomeViewModel>(
  (ref) => HomeViewModel(AppRepositoryImpl(), ref),
);

class HomeViewModel extends ChangeNotifier {
  final AppRepository _repository;
  final Ref _ref;

  final List<DebateEvent> _events = [];
  bool _isLoading = false;
  String? _error;

  List<DebateEvent> get events => _events;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Get username from UserVM (raw)
  String get username {
    final userVM = _ref.read(userVmProvider);
    return userVM.username;
  }

  // Get processed username for display (removes id_admin prefix)
  String get displayUsername {
    final userVM = _ref.read(userVmProvider);
    return userVM.displayUsername;
  }

  // Check if user is available
  bool get hasUser {
    final userVM = _ref.read(userVmProvider);
    return userVM.hasUser;
  }

  // Get full user data if needed
  UserModel? get currentUser {
    final userVM = _ref.read(userVmProvider);
    return userVM.state.user;
  }

  HomeViewModel(this._repository, this._ref) {
    _initializeData();
  }

  // Simplified initialization - only handle events
  Future<void> _initializeData() async {
    await fetchEvents();
  }

  Future<void> fetchEvents() async {
    if (_isLoading) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _repository.getDebateEvents(
        page: 1,
        pageSize: 1000,
      );

      if (response != null && response.results.isNotEmpty) {
        _events.clear();
        _events.addAll(response.results);
      }
    } catch (e) {
      debugPrint('Error fetching events: $e');
      _error = 'Failed to load events';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Method to refresh all data
  Future<void> refresh() async {
    // Refresh user data through UserVM
    final userVM = _ref.read(userVmProvider);
    await userVM.refreshUser();

    // Refresh events
    await fetchEvents();
  }

  // Method to clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
