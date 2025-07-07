import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final int? id;
  final String? name;
  final String username;
  final String? phone;
  final int? age;
  final String? region;
  final String? district;
  @JsonKey(name: 'english_level')
  final String? englishLevel;
  @JsonKey(name: 'language_code')
  final String? languageCode;

  const UserModel({
    this.id,
    this.name,
    required this.username,
    this.phone,
    this.age,
    this.region,
    this.district,
    this.englishLevel,
    this.languageCode,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel copyWith({
    int? id,
    String? name,
    String? username,
    String? phone,
    int? age,
    String? region,
    String? district,
    String? englishLevel,
    String? languageCode,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      phone: phone ?? this.phone,
      age: age ?? this.age,
      region: region ?? this.region,
      district: district ?? this.district,
      englishLevel: englishLevel ?? this.englishLevel,
      languageCode: languageCode ?? this.languageCode,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, username: $username, phone: $phone, age: $age, region: $region, district: $district, englishLevel: $englishLevel, languageCode: $languageCode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel &&
        other.id == id &&
        other.name == name &&
        other.username == username &&
        other.phone == phone &&
        other.age == age &&
        other.region == region &&
        other.district == district &&
        other.englishLevel == englishLevel &&
        other.languageCode == languageCode;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      name,
      username,
      phone,
      age,
      region,
      district,
      englishLevel,
      languageCode,
    );
  }
}
