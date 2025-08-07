import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibrat_debate_scanner_app/src/data/repository/app_repository.dart';

import '../../../common/local/app_storage.dart';
import '../../../data/entity/debate_models/debate_event_model.dart';
import '../../../data/entity/stats/statistics_models.dart';
import '../../../data/entity/user_model/user_model.dart';
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

  List<District> get availableDistricts => _state.districts;

  StatisticsViewModel() {
    _initialize();
  }

  Future<void> _initialize() async {
    await loadRegions();
    await _setDefaultRegionAndDistrict();
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

  Future<void> _setDefaultRegionAndDistrict() async {
    try {
      final jsonString = await AppStorage.$read(key: StorageKey.user);

      if (jsonString == null) return;

      final Map<String, dynamic> jsonData = jsonDecode(jsonString);
      final user = UserModel.fromJson(jsonData);

      // 1️⃣ Find default region
      final Region? defaultRegion = _state.regions
          .where((r) => r.id == user.region)
          .firstOrNull;

      List<District> filteredDistricts = [];

      // 2️⃣ If region found, get its districts
      if (defaultRegion != null) {
        final districtsResponse = await _repository.getDistricts();
        filteredDistricts = districtsResponse!.results
            .where((d) => d.region == defaultRegion.id)
            .toList();
      }

      // 3️⃣ Find default district
      final District? defaultDistrict = filteredDistricts
          .where((d) => d.id == user.district)
          .firstOrNull;

      // 4️⃣ Update state
      _updateState(
        _state.copyWith(
          selectedRegion: defaultRegion,
          selectedDistrict: defaultDistrict,
          districts: filteredDistricts,
        ),
      );

      // 5️⃣ Load statistics automatically
      if (defaultRegion != null) {
        await loadStatistics();
      }
    } catch (e) {
      debugPrint('⚠️ Failed to set default region/district: $e');
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
        statistics: null,
        error: null,
      ),
    );

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
        districtId: _state.selectedDistrict?.id,
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
