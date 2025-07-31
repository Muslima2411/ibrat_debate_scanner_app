import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibrat_debate_scanner_app/src/data/repository/app_repository.dart';

import '../../../data/entity/debate_models/debate_event_model.dart';
import '../../../data/entity/stats/statistics_models.dart';
import '../../../data/repository/app_repository_impl.dart';

final statisticsViewModelProvider = ChangeNotifierProvider<StatisticsViewModel>(
  (ref) {
    return StatisticsViewModel();
  },
);

class StatisticsViewModel extends ChangeNotifier {
  final AppRepository _repository = AppRepositoryImpl();

  StatisticsState _state = const StatisticsState();
  StatisticsState get state => _state;

  List<Region> get regions => _state.regions;
  bool get isLoadingRegions => _state.isLoadingRegions;
  bool get isLoadingStats => _state.isLoadingStats;
  Region? get selectedRegion => _state.selectedRegion;
  District? get selectedDistrict => _state.selectedDistrict;
  StatisticsResponse? get statistics => _state.statistics;
  String? get error => _state.error;

  List<District> get availableDistricts {
    return _state.selectedRegion?.districts ?? [];
  }

  void _updateState(StatisticsState newState) {
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

  void selectRegion(Region? region) {
    _updateState(
      _state.copyWith(
        selectedRegion: region,
        selectedDistrict: null,
        statistics: null,
        error: null,
      ),
    );

    if (region != null) {
      loadStatistics();
    }
  }

  void selectDistrict(District? district) {
    _updateState(
      _state.copyWith(
        selectedDistrict: district,
        statistics: null, // Clear previous statistics
        error: null,
      ),
    );

    // Automatically load statistics when both region and district are selected
    if (_state.selectedRegion != null && district != null) {
      loadStatistics();
    }
  }

  Future<void> loadInitialStatistics() async {
    try {
      final response = await _repository.getStatistics();

      if (response != null) {
        _updateState(
          _state.copyWith(
            statistics: response,
            isLoadingStats: false,
            error: null,
          ),
        );
      } else {
        _updateState(
          _state.copyWith(
            isLoadingStats: false,
            error: 'Failed to load statistics',
          ),
        );
      }
    } catch (e) {
      _updateState(
        _state.copyWith(
          isLoadingStats: false,
          error: 'Error loading statistics: $e',
        ),
      );
    }
  }

  Future<void> loadStatistics() async {
    if (_state.selectedRegion == null) {
      _updateState(_state.copyWith(error: 'Please select a region'));
      return;
    }

    _updateState(_state.copyWith(isLoadingStats: true, error: null));

    try {
      final response = await _repository.getStatistics(
        regionId: _state.selectedRegion!.id,
        districtId: _state.selectedDistrict?.id, // optional
      );

      if (response != null) {
        _updateState(
          _state.copyWith(
            statistics: response,
            isLoadingStats: false,
            error: null,
          ),
        );
      } else {
        _updateState(
          _state.copyWith(
            isLoadingStats: false,
            error: 'Failed to load statistics',
          ),
        );
      }
    } catch (e) {
      _updateState(
        _state.copyWith(
          isLoadingStats: false,
          error: 'Error loading statistics: $e',
        ),
      );
    }
  }

  void clearError() {
    _updateState(_state.copyWith(error: null));
  }
}
