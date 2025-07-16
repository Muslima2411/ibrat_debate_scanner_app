// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ticket_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TicketModel {

 String get id; UserModel get user; DebateEvent get debate;@JsonKey(name: 'created_at') String get createdAt;@JsonKey(name: 'updated_at') String get updatedAt;@JsonKey(name: 'qr_code') String get qrCode;@JsonKey(name: 'is_checked') bool get isChecked;
/// Create a copy of TicketModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketModelCopyWith<TicketModel> get copyWith => _$TicketModelCopyWithImpl<TicketModel>(this as TicketModel, _$identity);

  /// Serializes this TicketModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketModel&&(identical(other.id, id) || other.id == id)&&(identical(other.user, user) || other.user == user)&&(identical(other.debate, debate) || other.debate == debate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.qrCode, qrCode) || other.qrCode == qrCode)&&(identical(other.isChecked, isChecked) || other.isChecked == isChecked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,user,debate,createdAt,updatedAt,qrCode,isChecked);

@override
String toString() {
  return 'TicketModel(id: $id, user: $user, debate: $debate, createdAt: $createdAt, updatedAt: $updatedAt, qrCode: $qrCode, isChecked: $isChecked)';
}


}

/// @nodoc
abstract mixin class $TicketModelCopyWith<$Res>  {
  factory $TicketModelCopyWith(TicketModel value, $Res Function(TicketModel) _then) = _$TicketModelCopyWithImpl;
@useResult
$Res call({
 String id, UserModel user, DebateEvent debate,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt,@JsonKey(name: 'qr_code') String qrCode,@JsonKey(name: 'is_checked') bool isChecked
});


$DebateEventCopyWith<$Res> get debate;

}
/// @nodoc
class _$TicketModelCopyWithImpl<$Res>
    implements $TicketModelCopyWith<$Res> {
  _$TicketModelCopyWithImpl(this._self, this._then);

  final TicketModel _self;
  final $Res Function(TicketModel) _then;

/// Create a copy of TicketModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? user = null,Object? debate = null,Object? createdAt = null,Object? updatedAt = null,Object? qrCode = null,Object? isChecked = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserModel,debate: null == debate ? _self.debate : debate // ignore: cast_nullable_to_non_nullable
as DebateEvent,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,qrCode: null == qrCode ? _self.qrCode : qrCode // ignore: cast_nullable_to_non_nullable
as String,isChecked: null == isChecked ? _self.isChecked : isChecked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of TicketModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DebateEventCopyWith<$Res> get debate {
  
  return $DebateEventCopyWith<$Res>(_self.debate, (value) {
    return _then(_self.copyWith(debate: value));
  });
}
}


/// Adds pattern-matching-related methods to [TicketModel].
extension TicketModelPatterns on TicketModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketModel value)  $default,){
final _that = this;
switch (_that) {
case _TicketModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketModel value)?  $default,){
final _that = this;
switch (_that) {
case _TicketModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  UserModel user,  DebateEvent debate, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt, @JsonKey(name: 'qr_code')  String qrCode, @JsonKey(name: 'is_checked')  bool isChecked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketModel() when $default != null:
return $default(_that.id,_that.user,_that.debate,_that.createdAt,_that.updatedAt,_that.qrCode,_that.isChecked);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  UserModel user,  DebateEvent debate, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt, @JsonKey(name: 'qr_code')  String qrCode, @JsonKey(name: 'is_checked')  bool isChecked)  $default,) {final _that = this;
switch (_that) {
case _TicketModel():
return $default(_that.id,_that.user,_that.debate,_that.createdAt,_that.updatedAt,_that.qrCode,_that.isChecked);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  UserModel user,  DebateEvent debate, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt, @JsonKey(name: 'qr_code')  String qrCode, @JsonKey(name: 'is_checked')  bool isChecked)?  $default,) {final _that = this;
switch (_that) {
case _TicketModel() when $default != null:
return $default(_that.id,_that.user,_that.debate,_that.createdAt,_that.updatedAt,_that.qrCode,_that.isChecked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketModel implements TicketModel {
  const _TicketModel({required this.id, required this.user, required this.debate, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt, @JsonKey(name: 'qr_code') required this.qrCode, @JsonKey(name: 'is_checked') required this.isChecked});
  factory _TicketModel.fromJson(Map<String, dynamic> json) => _$TicketModelFromJson(json);

@override final  String id;
@override final  UserModel user;
@override final  DebateEvent debate;
@override@JsonKey(name: 'created_at') final  String createdAt;
@override@JsonKey(name: 'updated_at') final  String updatedAt;
@override@JsonKey(name: 'qr_code') final  String qrCode;
@override@JsonKey(name: 'is_checked') final  bool isChecked;

/// Create a copy of TicketModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketModelCopyWith<_TicketModel> get copyWith => __$TicketModelCopyWithImpl<_TicketModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketModel&&(identical(other.id, id) || other.id == id)&&(identical(other.user, user) || other.user == user)&&(identical(other.debate, debate) || other.debate == debate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.qrCode, qrCode) || other.qrCode == qrCode)&&(identical(other.isChecked, isChecked) || other.isChecked == isChecked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,user,debate,createdAt,updatedAt,qrCode,isChecked);

@override
String toString() {
  return 'TicketModel(id: $id, user: $user, debate: $debate, createdAt: $createdAt, updatedAt: $updatedAt, qrCode: $qrCode, isChecked: $isChecked)';
}


}

/// @nodoc
abstract mixin class _$TicketModelCopyWith<$Res> implements $TicketModelCopyWith<$Res> {
  factory _$TicketModelCopyWith(_TicketModel value, $Res Function(_TicketModel) _then) = __$TicketModelCopyWithImpl;
@override @useResult
$Res call({
 String id, UserModel user, DebateEvent debate,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt,@JsonKey(name: 'qr_code') String qrCode,@JsonKey(name: 'is_checked') bool isChecked
});


@override $DebateEventCopyWith<$Res> get debate;

}
/// @nodoc
class __$TicketModelCopyWithImpl<$Res>
    implements _$TicketModelCopyWith<$Res> {
  __$TicketModelCopyWithImpl(this._self, this._then);

  final _TicketModel _self;
  final $Res Function(_TicketModel) _then;

/// Create a copy of TicketModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? user = null,Object? debate = null,Object? createdAt = null,Object? updatedAt = null,Object? qrCode = null,Object? isChecked = null,}) {
  return _then(_TicketModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserModel,debate: null == debate ? _self.debate : debate // ignore: cast_nullable_to_non_nullable
as DebateEvent,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,qrCode: null == qrCode ? _self.qrCode : qrCode // ignore: cast_nullable_to_non_nullable
as String,isChecked: null == isChecked ? _self.isChecked : isChecked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of TicketModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DebateEventCopyWith<$Res> get debate {
  
  return $DebateEventCopyWith<$Res>(_self.debate, (value) {
    return _then(_self.copyWith(debate: value));
  });
}
}

// dart format on
