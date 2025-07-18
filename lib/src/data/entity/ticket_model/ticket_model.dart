import 'package:freezed_annotation/freezed_annotation.dart';

import '../debate_models/debate_event_model.dart';
import '../user_model/user_model.dart';

part 'ticket_model.freezed.dart';
part 'ticket_model.g.dart';

@freezed
abstract class TicketModel with _$TicketModel {
  const factory TicketModel({
    required String id,
    required UserModel user,
    required DebateEvent debate,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
    @JsonKey(name: 'qr_code') required String qrCode,
    @JsonKey(name: 'is_checked') required bool isChecked,
  }) = _TicketModel;

  factory TicketModel.fromJson(Map<String, dynamic> json) =>
      _$TicketModelFromJson(json);
}
