import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ibrat_debate_scanner_app/src/data/repository/app_repository_impl.dart';

import '../../../data/entity/ticket_model/ticket_model.dart';
import '../../../data/entity/debate_models/debate_event_model.dart';

part 'history_view_model.freezed.dart';

@freezed
abstract class HistoryState with _$HistoryState {
  const factory HistoryState({
    @Default([]) List<TicketModel> allTickets, // Store all tickets here
    @Default([]) List<Region> regions,
    @Default(false) bool isLoadingRegions,
    @Default(false) bool isLoadingTickets,
    Region? selectedRegion,
    District? selectedDistrict,
    bool?
    showCheckedOnly, // null = all, true = checked only, false = pending only
    String? error,
  }) = _HistoryState;
}

class HistoryViewModel extends ChangeNotifier {
  final AppRepositoryImpl _repository = AppRepositoryImpl();

  HistoryState _state = const HistoryState();
  HistoryState get state => _state;

  // Getters for direct state access
  List<Region> get regions => _state.regions;
  List<TicketModel> get allTickets => _state.allTickets;
  bool get isLoadingRegions => _state.isLoadingRegions;
  bool get isLoadingTickets => _state.isLoadingTickets;
  Region? get selectedRegion => _state.selectedRegion;
  District? get selectedDistrict => _state.selectedDistrict;
  bool? get showCheckedOnly => _state.showCheckedOnly;
  String? get error => _state.error;

  // Computed property for filtered tickets
  List<TicketModel> get filteredTickets {
    List<TicketModel> tickets = _state.allTickets;

    // Filter by status
    if (_state.showCheckedOnly == true) {
      tickets = tickets.where((ticket) => ticket.isChecked).toList();
    } else if (_state.showCheckedOnly == false) {
      tickets = tickets.where((ticket) => !ticket.isChecked).toList();
    }
    // If showCheckedOnly is null, show all tickets

    // Filter by region
    if (_state.selectedRegion != null) {
      tickets = tickets
          .where(
            (ticket) => ticket.debate.region.id == _state.selectedRegion!.id,
          )
          .toList();
    }

    // Filter by district
    if (_state.selectedDistrict != null) {
      tickets = tickets
          .where(
            (ticket) =>
                ticket.debate.district.id == _state.selectedDistrict!.id,
          )
          .toList();
    }

    return tickets;
  }

  List<District> get availableDistricts {
    return _state.selectedRegion?.districts ?? [];
  }

  HistoryViewModel() {
    _initializeData();
  }

  Future<void> _initializeData() async {
    await loadRegions();
    await loadTickets();
  }

  void _updateState(HistoryState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> loadRegions() async {
    if (_state.regions.isNotEmpty) return;

    _updateState(_state.copyWith(isLoadingRegions: true, error: null));

    try {
      final response = await _repository.getRegions();
      if (response != null) {
        _updateState(
          _state.copyWith(
            regions: response.results,
            isLoadingRegions: false,
            error: null,
          ),
        );
      } else {
        _updateState(
          _state.copyWith(
            isLoadingRegions: false,
            error: 'Failed to load regions',
          ),
        );
      }
    } catch (e) {
      _updateState(
        _state.copyWith(
          isLoadingRegions: false,
          error: 'Error loading regions: $e',
        ),
      );
    }
  }

  Future<void> loadTickets() async {
    _updateState(_state.copyWith(isLoadingTickets: true, error: null));

    try {
      final tickets = await _repository.getTickets();
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

  void applyFilters({
    Region? region,
    District? district,
    bool? showCheckedOnly,
  }) {
    _updateState(
      _state.copyWith(
        selectedRegion: region,
        selectedDistrict: district,
        showCheckedOnly: showCheckedOnly,
        error: null,
      ),
    );
  }

  void selectRegion(Region? region) {
    _updateState(
      _state.copyWith(
        selectedRegion: region,
        selectedDistrict: null, // Reset district when region changes
        error: null,
      ),
    );
  }

  void selectDistrict(District? district) {
    _updateState(_state.copyWith(selectedDistrict: district, error: null));
  }

  void setShowCheckedOnly(bool? showCheckedOnly) {
    _updateState(
      _state.copyWith(showCheckedOnly: showCheckedOnly, error: null),
    );
  }

  void clearAllFilters() {
    _updateState(
      _state.copyWith(
        selectedRegion: null,
        selectedDistrict: null,
        showCheckedOnly: null,
        error: null,
      ),
    );
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
