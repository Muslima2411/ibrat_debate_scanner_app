// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debate_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_District _$DistrictFromJson(Map<String, dynamic> json) => _District(
  id: (json['id'] as num).toInt(),
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
  name: json['name'] as String,
  telegramGroupLink: json['telegram_group_link'] as String,
  region: (json['region'] as num).toInt(),
);

Map<String, dynamic> _$DistrictToJson(_District instance) => <String, dynamic>{
  'id': instance.id,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'name': instance.name,
  'telegram_group_link': instance.telegramGroupLink,
  'region': instance.region,
};

_Region _$RegionFromJson(Map<String, dynamic> json) => _Region(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
);

Map<String, dynamic> _$RegionToJson(_Region instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};

_DebateEvent _$DebateEventFromJson(Map<String, dynamic> json) => _DebateEvent(
  id: (json['id'] as num).toInt(),
  region: json['region'] == null
      ? null
      : Region.fromJson(json['region'] as Map<String, dynamic>),
  district: json['district'] == null
      ? null
      : District.fromJson(json['district'] as Map<String, dynamic>),
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
  date: json['date'] as String?,
  time: json['time'] as String?,
  isPassed: json['is_passed'] as bool,
);

Map<String, dynamic> _$DebateEventToJson(_DebateEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'region': instance.region,
      'district': instance.district,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'date': instance.date,
      'time': instance.time,
      'is_passed': instance.isPassed,
    };
