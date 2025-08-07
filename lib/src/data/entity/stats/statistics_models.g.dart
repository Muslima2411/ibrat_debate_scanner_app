// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegionsResponse _$RegionsResponseFromJson(Map<String, dynamic> json) =>
    _RegionsResponse(
      count: (json['count'] as num).toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => Region.fromJson(e as Map<String, dynamic>))
          .toList(),
      next: json['next'] as String?,
      previous: json['previous'] as String?,
    );

Map<String, dynamic> _$RegionsResponseToJson(_RegionsResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'results': instance.results,
      'next': instance.next,
      'previous': instance.previous,
    };

_DistrictsResponse _$DistrictsResponseFromJson(Map<String, dynamic> json) =>
    _DistrictsResponse(
      count: (json['count'] as num).toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => District.fromJson(e as Map<String, dynamic>))
          .toList(),
      next: json['next'] as String?,
      previous: json['previous'] as String?,
    );

Map<String, dynamic> _$DistrictsResponseToJson(_DistrictsResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'results': instance.results,
      'next': instance.next,
      'previous': instance.previous,
    };

_StatisticsResponse _$StatisticsResponseFromJson(Map<String, dynamic> json) =>
    _StatisticsResponse(
      allCount: (json['all_count'] as num).toInt(),
      hasComeCount: (json['has_come_count'] as num).toInt(),
    );

Map<String, dynamic> _$StatisticsResponseToJson(_StatisticsResponse instance) =>
    <String, dynamic>{
      'all_count': instance.allCount,
      'has_come_count': instance.hasComeCount,
    };
