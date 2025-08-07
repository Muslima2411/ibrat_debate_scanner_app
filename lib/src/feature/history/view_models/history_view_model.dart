import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ibrat_debate_scanner_app/src/data/repository/app_repository_impl.dart';

import '../../../common/local/app_storage.dart';
import '../../../data/entity/ticket_model/ticket_model.dart';
import '../../../data/entity/debate_models/debate_event_model.dart';
import '../../../data/entity/user_model/user_model.dart';

part 'history_view_model.freezed.dart';

@freezed
abstract class HistoryState with _$HistoryState {
  const factory HistoryState({
    @Default([]) List<TicketModel> allTickets,
    // @Default([]) List<Region> regions,
    @Default(false) bool isLoadingRegions,
    @Default(false) bool isLoadingTickets,
    int? selectedRegion,
    int? selectedDistrict,
    bool? showCheckedOnly,
    String? error,
  }) = _HistoryState;
}

class HistoryViewModel extends ChangeNotifier {
  final AppRepositoryImpl _repository = AppRepositoryImpl();

  HistoryState _state = const HistoryState();
  HistoryState get state => _state;

  // Getters for direct state access
  // List<Region> get regions => _state.regions;
  List<TicketModel> get allTickets => _state.allTickets;
  bool get isLoadingRegions => _state.isLoadingRegions;
  bool get isLoadingTickets => _state.isLoadingTickets;
  int? get selectedRegion => _state.selectedRegion;
  int? get selectedDistrict => _state.selectedDistrict;
  bool? get showCheckedOnly => _state.showCheckedOnly;
  String? get error => _state.error;

  HistoryViewModel() {
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      await loadTickets();
    } catch (e) {
      _updateState(_state.copyWith(error: 'Error initializing data: $e'));
    }
  }

  void _updateState(HistoryState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> loadTickets({bool? isChecked}) async {
    _updateState(_state.copyWith(isLoadingTickets: true, error: null));

    try {
      final tickets = await _repository.getTickets(isChecked: isChecked);

      _updateState(
        _state.copyWith(
          allTickets: tickets,
          isLoadingTickets: false,
          error: null,
        ),
      );
    } catch (e) {
      _updateState(
        _state.copyWith(
          isLoadingTickets: false,
          error: 'Error loading tickets: $e',
        ),
      );
    }
  }

  void applyFilters({bool? showCheckedOnly}) {
    _updateState(
      _state.copyWith(showCheckedOnly: showCheckedOnly, error: null),
    );

    loadTickets(isChecked: showCheckedOnly);
  }

  void clearAllFilters() {
    _updateState(_state.copyWith(showCheckedOnly: null, error: null));
  }

  void clearError() {
    _updateState(_state.copyWith(error: null));
  }

  Future<void> cancelTicket(String ticketId) async {
    try {
      await _repository.cancelTicket(ticketId);
      // Reload tickets after cancellation
      await loadTickets();
    } catch (e) {
      _updateState(_state.copyWith(error: 'Failed to cancel ticket: $e'));
    }
  }
}

final historyViewModelProvider = ChangeNotifierProvider(
  (ref) => HistoryViewModel(),
);
