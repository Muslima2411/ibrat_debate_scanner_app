// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['id'] as String?,
  name: json['name'] as String?,
  username: json['username'] as String,
  phone: json['phone'] as String?,
  age: json['age'] as String?,
  region: (json['region'] as num?)?.toInt(),
  district: (json['district'] as num?)?.toInt(),
  englishLevel: json['english_level'] as String?,
  languageCode: json['language_code'] as String?,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'username': instance.username,
  'phone': instance.phone,
  'age': instance.age,
  'region': instance.region,
  'district': instance.district,
  'english_level': instance.englishLevel,
  'language_code': instance.languageCode,
};
