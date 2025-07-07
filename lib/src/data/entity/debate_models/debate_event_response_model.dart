import 'package:freezed_annotation/freezed_annotation.dart';

import 'debate_event_model.dart';

part 'debate_event_response_model.freezed.dart';
part 'debate_event_response_model.g.dart';

@freezed
abstract class DebateEventResponse with _$DebateEventResponse {
  const factory DebateEventResponse({
    required int count,
    required String? next,
    required String? previous,
    required List<DebateEvent> results,
  }) = _DebateEventResponse;

  factory DebateEventResponse.fromJson(Map<String, dynamic> json) =>
      _$DebateEventResponseFromJson(json);
}
