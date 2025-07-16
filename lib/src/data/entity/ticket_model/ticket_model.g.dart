// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TicketModel _$TicketModelFromJson(Map<String, dynamic> json) => _TicketModel(
  id: json['id'] as String,
  user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
  debate: DebateEvent.fromJson(json['debate'] as Map<String, dynamic>),
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
  qrCode: json['qr_code'] as String,
  isChecked: json['is_checked'] as bool,
);

Map<String, dynamic> _$TicketModelToJson(_TicketModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'debate': instance.debate,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'qr_code': instance.qrCode,
      'is_checked': instance.isChecked,
    };
