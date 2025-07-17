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
    @Default([]) List<TicketModel> tickets,
    @Default([]) List<Region> regions,
    @Default(false) bool isLoadingRegions,
    @Default(false) bool isLoadingTickets,
    Region? selectedRegion,
    District? selectedDistrict,
    String? error,
  }) = _HistoryState;
}

class HistoryViewModel extends ChangeNotifier {
  final AppRepositoryImpl _repository = AppRepositoryImpl();

  HistoryState _state = const HistoryState();
  HistoryState get state => _state;

  List<Region> get regions => _state.regions;
  List<TicketModel> get tickets => _state.tickets;
  bool get isLoadingRegions => _state.isLoadingRegions;
  bool get isLoadingTickets => _state.isLoadingTickets;
  Region? get selectedRegion => _state.selectedRegion;
  District? get selectedDistrict => _state.selectedDistrict;
  String? get error => _state.error;

  List<District> get availableDistricts {
    return _state.selectedRegion?.districts ?? [];
  }

  HistoryViewModel() {
    loadRegions(); // Load regions on initialization
  }

  void _updateState(HistoryState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> loadRegions() async {
    if (_state.regions.isNotEmpty) return; // Don't reload if already loaded

    _updateState(_state.copyWith(isLoadingRegions: true, error: null));

    try {
      final response = await _repository.getRegions();
      if (response != null) {
        _updateState(
          _state.copyWith(
            regions: response.results,
            isLoadingRegions: false,
            error: null,
            selectedRegion: response.results.isNotEmpty
                ? response.results.first
                : null,
          ),
        );
        if (response.results.isNotEmpty) {
          loadTickets(); // Load tickets after selecting a default region
        }
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
    if (_state.selectedRegion == null) {
      _updateState(_state.copyWith(error: 'Please select a region'));
      return;
    }

    _updateState(_state.copyWith(isLoadingTickets: true, error: null));

    try {
      final tickets = await _repository.getTickets();
      _updateState(
        _state.copyWith(tickets: tickets, isLoadingTickets: false, error: null),
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

  void selectRegion(Region? region) {
    _updateState(
      _state.copyWith(
        selectedRegion: region,
        selectedDistrict: null,
        tickets: [], // Clear tickets when region changes
        error: null,
      ),
    );

    if (region != null) {
      loadTickets();
    }
  }

  void selectDistrict(District? district) {
    _updateState(_state.copyWith(selectedDistrict: district, error: null));
  }

  void clearFilters() {
    _updateState(
      _state.copyWith(
        selectedRegion: _state.regions.isNotEmpty ? _state.regions.first : null,
        selectedDistrict: null,
        tickets: [], // Clear tickets when filters are cleared
        error: null,
      ),
    );
    if (_state.selectedRegion != null) {
      loadTickets();
    }
  }

  List<TicketModel> get filteredTickets {
    if (_state.selectedRegion == null) return _state.tickets;

    return _state.tickets.where((ticket) {
      final matchesRegion =
          ticket.debate.region.id == _state.selectedRegion!.id;
      final matchesDistrict =
          _state.selectedDistrict == null ||
          ticket.debate.district.id == _state.selectedDistrict!.id;
      return matchesRegion && matchesDistrict;
    }).toList();
  }

  void clearError() {
    _updateState(_state.copyWith(error: null));
  }
}

final historyViewModelProvider = ChangeNotifierProvider(
  (ref) => HistoryViewModel(),
);
