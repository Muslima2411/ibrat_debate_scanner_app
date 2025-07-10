import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ibrat_debate_scanner_app/src/data/entity/ticket_model/ticket_model.dart';
import 'package:ibrat_debate_scanner_app/src/data/entity/user_model/user_model.dart';
import 'package:ibrat_debate_scanner_app/src/data/repository/app_repository.dart';

import '../../../data/repository/app_repository_impl.dart';

part 'qr_code_scanner_vm.freezed.dart';

@freezed
abstract class QrCodeScannerState with _$QrCodeScannerState {
  const factory QrCodeScannerState({
    @Default(false) bool isScanning,
    @Default(false) bool isLoading,
    @Default(false) bool isDisposed,
    @Default(false) bool isConfirming, // Loading state for confirmation
    String? scannedCode,
    TicketModel? ticket,
    UserModel? user,
    String? errorMessage,
    @Default(false) bool shouldNavigateBack,
  }) = _QrCodeScannerState;
}

class QrCodeScannerViewModel extends ChangeNotifier {
  final AppRepository _repository;

  QrCodeScannerState _state = const QrCodeScannerState(isScanning: true);
  bool _isDisposed = false;

  QrCodeScannerViewModel(this._repository);

  QrCodeScannerState get state => _state;

  void _updateState(QrCodeScannerState newState) {
    if (_isDisposed) return;
    _state = newState;
    notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  Future<void> handleScannedCode(String code) async {
    try {
      debugPrint('🔍 Processing QR code: $code');

      _updateState(
        _state.copyWith(
          isLoading: true,
          isScanning: false,
          scannedCode: code,
          errorMessage: null,
          shouldNavigateBack: false,
        ),
      );

      // Step 1: Get ticket by ID
      final ticket = await _repository.getTicketById(code);
      debugPrint('✅ Ticket retrieved: ${ticket?.id}');

      // Check if ticket is already checked
      if (ticket!.isChecked) {
        _updateState(
          _state.copyWith(
            isLoading: false,
            errorMessage: 'This ticket has already been checked in.',
            shouldNavigateBack: false,
          ),
        );

        // Auto-navigate back after 3 seconds
        Future.delayed(const Duration(seconds: 3), () {
          if (!_isDisposed) {
            _updateState(_state.copyWith(shouldNavigateBack: true));
          }
        });
        return;
      }

      // Step 2: Get user details
      final user = await _repository.getUserById(ticket.user);
      debugPrint('✅ User retrieved: ${user?.id}');

      _updateState(
        _state.copyWith(isLoading: false, ticket: ticket, user: user),
      );

      debugPrint('✅ Successfully loaded ticket and user data');
    } catch (e) {
      debugPrint('❌ Error processing QR code: $e');

      String errorMessage = 'Failed to process QR code.';
      if (e.toString().contains('404')) {
        errorMessage = 'Ticket not found. Please check the QR code.';
      } else if (e.toString().contains('500')) {
        errorMessage = 'Server error. Please try again later.';
      } else if (e.toString().contains('network') ||
          e.toString().contains('connection')) {
        errorMessage = 'Network error. Please check your connection.';
      }

      _updateState(
        _state.copyWith(
          isLoading: false,
          errorMessage: errorMessage,
          shouldNavigateBack: false,
        ),
      );

      // Auto-navigate back after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        if (!_isDisposed) {
          _updateState(_state.copyWith(shouldNavigateBack: true));
        }
      });
    }
  }

  Future<void> confirmCheckIn() async {
    if (_state.ticket == null) {
      setError('No ticket data available');
      return;
    }

    try {
      debugPrint('🔄 Confirming check-in for ticket: ${_state.ticket!.id}');

      _updateState(_state.copyWith(isConfirming: true, errorMessage: null));

      // Mark ticket as checked
      final updatedTicket = await _repository.markTicketAsChecked(
        _state.ticket!.id,
      );
      debugPrint('✅ Ticket marked as checked: ${updatedTicket?.id}');

      _updateState(_state.copyWith(isConfirming: false, ticket: updatedTicket));

      // Navigate back after successful check-in
      Future.delayed(const Duration(milliseconds: 500), () {
        if (!_isDisposed) {
          _updateState(_state.copyWith(shouldNavigateBack: true));
        }
      });
    } catch (e) {
      debugPrint('❌ Error confirming check-in: $e');

      String errorMessage = 'Failed to confirm check-in.';
      if (e.toString().contains('500')) {
        errorMessage = 'Server error. Please try again.';
      } else if (e.toString().contains('network') ||
          e.toString().contains('connection')) {
        errorMessage = 'Network error. Please check your connection.';
      }

      _updateState(
        _state.copyWith(isConfirming: false, errorMessage: errorMessage),
      );
    }
  }

  void restartScanning() {
    _updateState(
      _state.copyWith(
        isScanning: true,
        scannedCode: null,
        ticket: null,
        user: null,
        errorMessage: null,
        shouldNavigateBack: false,
        isConfirming: false,
      ),
    );
  }

  void pauseScanning() {
    _updateState(_state.copyWith(isScanning: false));
  }

  void resumeScanning() {
    _updateState(_state.copyWith(isScanning: true));
  }

  void disposeScanner() {
    _state = _state.copyWith(isDisposed: true);
    _isDisposed = true;
  }

  void setError(String error) {
    _updateState(_state.copyWith(errorMessage: error));
  }

  void clearError() {
    _updateState(_state.copyWith(errorMessage: null));
  }

  void resetNavigationFlag() {
    _updateState(_state.copyWith(shouldNavigateBack: false));
  }
}

// Update the providers
final qrCodeScannerViewModelProvider =
    ChangeNotifierProvider<QrCodeScannerViewModel>((ref) {
      final repository = AppRepositoryImpl(); // ✅ Use singleton directly
      return QrCodeScannerViewModel(repository);
    });

final qrCodeScannerStateProvider = Provider<QrCodeScannerState>((ref) {
  return ref.watch(qrCodeScannerViewModelProvider).state;
});
