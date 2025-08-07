import 'package:freezed_annotation/freezed_annotation.dart';

part 'debate_event_model.freezed.dart';
part 'debate_event_model.g.dart';

@freezed
abstract class District with _$District {
  const factory District({
    required int id,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
    required String name,
    @JsonKey(name: 'telegram_group_link') required String telegramGroupLink,
    required int region,
  }) = _District;

  factory District.fromJson(Map<String, dynamic> json) =>
      _$DistrictFromJson(json);
}

@freezed
abstract class Region with _$Region {
  const factory Region({
    required int id,
    required String name,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
    required List<District> districts,
  }) = _Region;

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);
}

@freezed
abstract class DebateEvent with _$DebateEvent {
  const factory DebateEvent({
    required int id,
    Region? region,
    District? district,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
    String? date,
    String? time,
    @JsonKey(name: 'is_passed') required bool isPassed,
  }) = _DebateEvent;

  factory DebateEvent.fromJson(Map<String, dynamic> json) =>
      _$DebateEventFromJson(json);
}
