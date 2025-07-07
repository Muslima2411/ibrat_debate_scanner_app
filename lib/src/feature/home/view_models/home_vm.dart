import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/local/app_storage.dart';
import '../../../data/entity/debate_models/debate_event_model.dart';
import '../../../data/repository/app_repository.dart';
import '../../../data/repository/app_repository_impl.dart';

final homeViewModelProvider = ChangeNotifierProvider.autoDispose<HomeViewModel>(
  (ref) => HomeViewModel(AppRepositoryImpl()),
);

class HomeViewModel extends ChangeNotifier {
  final AppRepository _repository;

  String username = '';
  final List<DebateEvent> _events = [];

  // int _currentPage = 1;
  // final int _pageSize = 10;
  // bool _hasMore = true;
  bool _isLoading = false;

  List<DebateEvent> get events => _events;
  bool get isLoading => _isLoading;
  // bool get hasMore => _hasMore;

  HomeViewModel(this._repository) {
    _loadUser();
    fetchEvents();
  }

  void _loadUser() async {
    final user = await AppStorage.$read(key: StorageKey.user);
    username = user ?? 'Guest';
    notifyListeners();
  }

  Future<void> fetchEvents() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final response = await _repository.getDebateEvents(
        page: 1, // Fixed page for now
        pageSize: 1000, // Large value to fetch all
      );

      if (response != null && response.results.isNotEmpty) {
        _events.clear();
        _events.addAll(response.results);

        // Pagination temporarily disabled
        // _currentPage++;
        // if (response.data.length < _pageSize) {
        //   _hasMore = false;
        // }
      } else {
        // _hasMore = false;
      }
    } catch (e) {
      debugPrint('Error fetching events: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
