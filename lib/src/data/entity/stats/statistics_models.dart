import 'package:freezed_annotation/freezed_annotation.dart';

import '../debate_models/debate_event_model.dart';

part 'statistics_models.freezed.dart';
part 'statistics_models.g.dart';

@freezed
abstract class RegionsResponse with _$RegionsResponse {
  const factory RegionsResponse({
    required int count,
    required List<Region> results,
    String? next,
    String? previous,
  }) = _RegionsResponse;

  factory RegionsResponse.fromJson(Map<String, dynamic> json) =>
      _$RegionsResponseFromJson(json);
}

@freezed
abstract class DistrictsResponse with _$DistrictsResponse {
  const factory DistrictsResponse({
    required int count,
    required List<District> results,
    String? next,
    String? previous,
  }) = _DistrictsResponse;

  factory DistrictsResponse.fromJson(Map<String, dynamic> json) =>
      _$DistrictsResponseFromJson(json);
}

@freezed
abstract class StatisticsResponse with _$StatisticsResponse {
  const factory StatisticsResponse({
    @JsonKey(name: 'all_count') required int allCount,
    @JsonKey(name: 'has_come_count') required int hasComeCount,
  }) = _StatisticsResponse;

  factory StatisticsResponse.fromJson(Map<String, dynamic> json) =>
      _$StatisticsResponseFromJson(json);
}

@freezed
abstract class StatisticsState with _$StatisticsState {
  const factory StatisticsState({
    @Default([]) List<Region> regions,
    @Default([]) List<District> districts,
    @Default(false) bool isLoadingRegions,
    @Default(false) bool isLoadingStats,
    Region? selectedRegion,
    District? selectedDistrict,
    StatisticsResponse? statistics,
    String? error,
  }) = _StatisticsState;
}
