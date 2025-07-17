import 'package:flutter_riverpod/flutter_riverpod.dart';

// Navigation State
class NavigationState {
  final int currentIndex;
  final bool isLoading;
  final String? error;

  const NavigationState({
    required this.currentIndex,
    this.isLoading = false,
    this.error,
  });

  NavigationState copyWith({
    int? currentIndex,
    bool? isLoading,
    String? error,
  }) {
    return NavigationState(
      currentIndex: currentIndex ?? this.currentIndex,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

// Navigation Controller
class NavigationController extends StateNotifier<NavigationState> {
  NavigationController() : super(const NavigationState(currentIndex: 0));

  // Navigate to a specific tab
  void navigateToTab(int index) {
    // Prevent navigation to FAB position (index 2)
    if (index == 2) return;

    // Validate index range
    if (index < 0 || index >= 5) return;

    state = state.copyWith(currentIndex: index);
  }

  // Navigate to Home
  void navigateToHome() => navigateToTab(0);

  // Navigate to Statistics
  void navigateToStatistics() => navigateToTab(1);

  // Navigate to History
  void navigateToHistory() => navigateToTab(3);

  // Navigate to Profile
  void navigateToProfile() => navigateToTab(4);

  // Reset to home
  void resetToHome() {
    state = state.copyWith(currentIndex: 0);
  }

  // Get current tab name
  String getCurrentTabName() {
    switch (state.currentIndex) {
      case 0:
        return 'Home';
      case 1:
        return 'Statistics';
      case 3:
        return 'History';
      case 4:
        return 'Profile';
      default:
        return 'Unknown';
    }
  }

  // Check if current tab is active
  bool isTabActive(int index) {
    return state.currentIndex == index;
  }
}

// Provider
final navigationControllerProvider =
    StateNotifierProvider<NavigationController, NavigationState>(
      (ref) => NavigationController(),
    );

// Convenience providers for specific values
final currentIndexProvider = Provider<int>((ref) {
  return ref.watch(navigationControllerProvider).currentIndex;
});

final isLoadingProvider = Provider<bool>((ref) {
  return ref.watch(navigationControllerProvider).isLoading;
});

final navigationErrorProvider = Provider<String?>((ref) {
  return ref.watch(navigationControllerProvider).error;
});
