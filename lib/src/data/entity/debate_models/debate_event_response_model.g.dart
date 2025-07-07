// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debate_event_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DebateEventResponse _$DebateEventResponseFromJson(Map<String, dynamic> json) =>
    _DebateEventResponse(
      count: (json['count'] as num).toInt(),
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>)
          .map((e) => DebateEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DebateEventResponseToJson(
  _DebateEventResponse instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};
