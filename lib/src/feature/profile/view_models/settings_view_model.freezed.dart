// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SettingsState implements DiagnosticableTreeMixin {

 UserModel? get user; bool get isLoading; bool get isSaving; String? get error; String get selectedEnglishLevel; String get selectedAgeRange;
/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsStateCopyWith<SettingsState> get copyWith => _$SettingsStateCopyWithImpl<SettingsState>(this as SettingsState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SettingsState'))
    ..add(DiagnosticsProperty('user', user))..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('isSaving', isSaving))..add(DiagnosticsProperty('error', error))..add(DiagnosticsProperty('selectedEnglishLevel', selectedEnglishLevel))..add(DiagnosticsProperty('selectedAgeRange', selectedAgeRange));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsState&&(identical(other.user, user) || other.user == user)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.error, error) || other.error == error)&&(identical(other.selectedEnglishLevel, selectedEnglishLevel) || other.selectedEnglishLevel == selectedEnglishLevel)&&(identical(other.selectedAgeRange, selectedAgeRange) || other.selectedAgeRange == selectedAgeRange));
}


@override
int get hashCode => Object.hash(runtimeType,user,isLoading,isSaving,error,selectedEnglishLevel,selectedAgeRange);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SettingsState(user: $user, isLoading: $isLoading, isSaving: $isSaving, error: $error, selectedEnglishLevel: $selectedEnglishLevel, selectedAgeRange: $selectedAgeRange)';
}


}

/// @nodoc
abstract mixin class $SettingsStateCopyWith<$Res>  {
  factory $SettingsStateCopyWith(SettingsState value, $Res Function(SettingsState) _then) = _$SettingsStateCopyWithImpl;
@useResult
$Res call({
 UserModel? user, bool isLoading, bool isSaving, String? error, String selectedEnglishLevel, String selectedAgeRange
});




}
/// @nodoc
class _$SettingsStateCopyWithImpl<$Res>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._self, this._then);

  final SettingsState _self;
  final $Res Function(SettingsState) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = freezed,Object? isLoading = null,Object? isSaving = null,Object? error = freezed,Object? selectedEnglishLevel = null,Object? selectedAgeRange = null,}) {
  return _then(_self.copyWith(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserModel?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,selectedEnglishLevel: null == selectedEnglishLevel ? _self.selectedEnglishLevel : selectedEnglishLevel // ignore: cast_nullable_to_non_nullable
as String,selectedAgeRange: null == selectedAgeRange ? _self.selectedAgeRange : selectedAgeRange // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SettingsState].
extension SettingsStatePatterns on SettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettingsState value)  $default,){
final _that = this;
switch (_that) {
case _SettingsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettingsState value)?  $default,){
final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UserModel? user,  bool isLoading,  bool isSaving,  String? error,  String selectedEnglishLevel,  String selectedAgeRange)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
return $default(_that.user,_that.isLoading,_that.isSaving,_that.error,_that.selectedEnglishLevel,_that.selectedAgeRange);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UserModel? user,  bool isLoading,  bool isSaving,  String? error,  String selectedEnglishLevel,  String selectedAgeRange)  $default,) {final _that = this;
switch (_that) {
case _SettingsState():
return $default(_that.user,_that.isLoading,_that.isSaving,_that.error,_that.selectedEnglishLevel,_that.selectedAgeRange);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UserModel? user,  bool isLoading,  bool isSaving,  String? error,  String selectedEnglishLevel,  String selectedAgeRange)?  $default,) {final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
return $default(_that.user,_that.isLoading,_that.isSaving,_that.error,_that.selectedEnglishLevel,_that.selectedAgeRange);case _:
  return null;

}
}

}

/// @nodoc


class _SettingsState with DiagnosticableTreeMixin implements SettingsState {
  const _SettingsState({this.user, this.isLoading = false, this.isSaving = false, this.error, this.selectedEnglishLevel = 'B1-B2', this.selectedAgeRange = '<16'});
  

@override final  UserModel? user;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSaving;
@override final  String? error;
@override@JsonKey() final  String selectedEnglishLevel;
@override@JsonKey() final  String selectedAgeRange;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsStateCopyWith<_SettingsState> get copyWith => __$SettingsStateCopyWithImpl<_SettingsState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SettingsState'))
    ..add(DiagnosticsProperty('user', user))..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('isSaving', isSaving))..add(DiagnosticsProperty('error', error))..add(DiagnosticsProperty('selectedEnglishLevel', selectedEnglishLevel))..add(DiagnosticsProperty('selectedAgeRange', selectedAgeRange));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsState&&(identical(other.user, user) || other.user == user)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.error, error) || other.error == error)&&(identical(other.selectedEnglishLevel, selectedEnglishLevel) || other.selectedEnglishLevel == selectedEnglishLevel)&&(identical(other.selectedAgeRange, selectedAgeRange) || other.selectedAgeRange == selectedAgeRange));
}


@override
int get hashCode => Object.hash(runtimeType,user,isLoading,isSaving,error,selectedEnglishLevel,selectedAgeRange);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SettingsState(user: $user, isLoading: $isLoading, isSaving: $isSaving, error: $error, selectedEnglishLevel: $selectedEnglishLevel, selectedAgeRange: $selectedAgeRange)';
}


}

/// @nodoc
abstract mixin class _$SettingsStateCopyWith<$Res> implements $SettingsStateCopyWith<$Res> {
  factory _$SettingsStateCopyWith(_SettingsState value, $Res Function(_SettingsState) _then) = __$SettingsStateCopyWithImpl;
@override @useResult
$Res call({
 UserModel? user, bool isLoading, bool isSaving, String? error, String selectedEnglishLevel, String selectedAgeRange
});




}
/// @nodoc
class __$SettingsStateCopyWithImpl<$Res>
    implements _$SettingsStateCopyWith<$Res> {
  __$SettingsStateCopyWithImpl(this._self, this._then);

  final _SettingsState _self;
  final $Res Function(_SettingsState) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = freezed,Object? isLoading = null,Object? isSaving = null,Object? error = freezed,Object? selectedEnglishLevel = null,Object? selectedAgeRange = null,}) {
  return _then(_SettingsState(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserModel?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,selectedEnglishLevel: null == selectedEnglishLevel ? _self.selectedEnglishLevel : selectedEnglishLevel // ignore: cast_nullable_to_non_nullable
as String,selectedAgeRange: null == selectedAgeRange ? _self.selectedAgeRange : selectedAgeRange // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
