// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'change_password_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChangePasswordState {

 bool get isLoading; String get currentPassword; String get newPassword; String get confirmPassword; bool get isCurrentPasswordVisible; bool get isNewPasswordVisible; bool get isConfirmPasswordVisible; String? get errorMessage; String? get resultMessage; bool get isSuccess; bool get showResult;
/// Create a copy of ChangePasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangePasswordStateCopyWith<ChangePasswordState> get copyWith => _$ChangePasswordStateCopyWithImpl<ChangePasswordState>(this as ChangePasswordState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangePasswordState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.currentPassword, currentPassword) || other.currentPassword == currentPassword)&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword)&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword)&&(identical(other.isCurrentPasswordVisible, isCurrentPasswordVisible) || other.isCurrentPasswordVisible == isCurrentPasswordVisible)&&(identical(other.isNewPasswordVisible, isNewPasswordVisible) || other.isNewPasswordVisible == isNewPasswordVisible)&&(identical(other.isConfirmPasswordVisible, isConfirmPasswordVisible) || other.isConfirmPasswordVisible == isConfirmPasswordVisible)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.resultMessage, resultMessage) || other.resultMessage == resultMessage)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.showResult, showResult) || other.showResult == showResult));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,currentPassword,newPassword,confirmPassword,isCurrentPasswordVisible,isNewPasswordVisible,isConfirmPasswordVisible,errorMessage,resultMessage,isSuccess,showResult);

@override
String toString() {
  return 'ChangePasswordState(isLoading: $isLoading, currentPassword: $currentPassword, newPassword: $newPassword, confirmPassword: $confirmPassword, isCurrentPasswordVisible: $isCurrentPasswordVisible, isNewPasswordVisible: $isNewPasswordVisible, isConfirmPasswordVisible: $isConfirmPasswordVisible, errorMessage: $errorMessage, resultMessage: $resultMessage, isSuccess: $isSuccess, showResult: $showResult)';
}


}

/// @nodoc
abstract mixin class $ChangePasswordStateCopyWith<$Res>  {
  factory $ChangePasswordStateCopyWith(ChangePasswordState value, $Res Function(ChangePasswordState) _then) = _$ChangePasswordStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, String currentPassword, String newPassword, String confirmPassword, bool isCurrentPasswordVisible, bool isNewPasswordVisible, bool isConfirmPasswordVisible, String? errorMessage, String? resultMessage, bool isSuccess, bool showResult
});




}
/// @nodoc
class _$ChangePasswordStateCopyWithImpl<$Res>
    implements $ChangePasswordStateCopyWith<$Res> {
  _$ChangePasswordStateCopyWithImpl(this._self, this._then);

  final ChangePasswordState _self;
  final $Res Function(ChangePasswordState) _then;

/// Create a copy of ChangePasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? currentPassword = null,Object? newPassword = null,Object? confirmPassword = null,Object? isCurrentPasswordVisible = null,Object? isNewPasswordVisible = null,Object? isConfirmPasswordVisible = null,Object? errorMessage = freezed,Object? resultMessage = freezed,Object? isSuccess = null,Object? showResult = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,currentPassword: null == currentPassword ? _self.currentPassword : currentPassword // ignore: cast_nullable_to_non_nullable
as String,newPassword: null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,confirmPassword: null == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String,isCurrentPasswordVisible: null == isCurrentPasswordVisible ? _self.isCurrentPasswordVisible : isCurrentPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,isNewPasswordVisible: null == isNewPasswordVisible ? _self.isNewPasswordVisible : isNewPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,isConfirmPasswordVisible: null == isConfirmPasswordVisible ? _self.isConfirmPasswordVisible : isConfirmPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,resultMessage: freezed == resultMessage ? _self.resultMessage : resultMessage // ignore: cast_nullable_to_non_nullable
as String?,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,showResult: null == showResult ? _self.showResult : showResult // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ChangePasswordState].
extension ChangePasswordStatePatterns on ChangePasswordState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChangePasswordState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChangePasswordState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChangePasswordState value)  $default,){
final _that = this;
switch (_that) {
case _ChangePasswordState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChangePasswordState value)?  $default,){
final _that = this;
switch (_that) {
case _ChangePasswordState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  String currentPassword,  String newPassword,  String confirmPassword,  bool isCurrentPasswordVisible,  bool isNewPasswordVisible,  bool isConfirmPasswordVisible,  String? errorMessage,  String? resultMessage,  bool isSuccess,  bool showResult)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChangePasswordState() when $default != null:
return $default(_that.isLoading,_that.currentPassword,_that.newPassword,_that.confirmPassword,_that.isCurrentPasswordVisible,_that.isNewPasswordVisible,_that.isConfirmPasswordVisible,_that.errorMessage,_that.resultMessage,_that.isSuccess,_that.showResult);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  String currentPassword,  String newPassword,  String confirmPassword,  bool isCurrentPasswordVisible,  bool isNewPasswordVisible,  bool isConfirmPasswordVisible,  String? errorMessage,  String? resultMessage,  bool isSuccess,  bool showResult)  $default,) {final _that = this;
switch (_that) {
case _ChangePasswordState():
return $default(_that.isLoading,_that.currentPassword,_that.newPassword,_that.confirmPassword,_that.isCurrentPasswordVisible,_that.isNewPasswordVisible,_that.isConfirmPasswordVisible,_that.errorMessage,_that.resultMessage,_that.isSuccess,_that.showResult);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  String currentPassword,  String newPassword,  String confirmPassword,  bool isCurrentPasswordVisible,  bool isNewPasswordVisible,  bool isConfirmPasswordVisible,  String? errorMessage,  String? resultMessage,  bool isSuccess,  bool showResult)?  $default,) {final _that = this;
switch (_that) {
case _ChangePasswordState() when $default != null:
return $default(_that.isLoading,_that.currentPassword,_that.newPassword,_that.confirmPassword,_that.isCurrentPasswordVisible,_that.isNewPasswordVisible,_that.isConfirmPasswordVisible,_that.errorMessage,_that.resultMessage,_that.isSuccess,_that.showResult);case _:
  return null;

}
}

}

/// @nodoc


class _ChangePasswordState implements ChangePasswordState {
  const _ChangePasswordState({this.isLoading = false, this.currentPassword = '', this.newPassword = '', this.confirmPassword = '', this.isCurrentPasswordVisible = false, this.isNewPasswordVisible = false, this.isConfirmPasswordVisible = false, this.errorMessage, this.resultMessage, this.isSuccess = false, this.showResult = false});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  String currentPassword;
@override@JsonKey() final  String newPassword;
@override@JsonKey() final  String confirmPassword;
@override@JsonKey() final  bool isCurrentPasswordVisible;
@override@JsonKey() final  bool isNewPasswordVisible;
@override@JsonKey() final  bool isConfirmPasswordVisible;
@override final  String? errorMessage;
@override final  String? resultMessage;
@override@JsonKey() final  bool isSuccess;
@override@JsonKey() final  bool showResult;

/// Create a copy of ChangePasswordState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangePasswordStateCopyWith<_ChangePasswordState> get copyWith => __$ChangePasswordStateCopyWithImpl<_ChangePasswordState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangePasswordState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.currentPassword, currentPassword) || other.currentPassword == currentPassword)&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword)&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword)&&(identical(other.isCurrentPasswordVisible, isCurrentPasswordVisible) || other.isCurrentPasswordVisible == isCurrentPasswordVisible)&&(identical(other.isNewPasswordVisible, isNewPasswordVisible) || other.isNewPasswordVisible == isNewPasswordVisible)&&(identical(other.isConfirmPasswordVisible, isConfirmPasswordVisible) || other.isConfirmPasswordVisible == isConfirmPasswordVisible)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.resultMessage, resultMessage) || other.resultMessage == resultMessage)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.showResult, showResult) || other.showResult == showResult));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,currentPassword,newPassword,confirmPassword,isCurrentPasswordVisible,isNewPasswordVisible,isConfirmPasswordVisible,errorMessage,resultMessage,isSuccess,showResult);

@override
String toString() {
  return 'ChangePasswordState(isLoading: $isLoading, currentPassword: $currentPassword, newPassword: $newPassword, confirmPassword: $confirmPassword, isCurrentPasswordVisible: $isCurrentPasswordVisible, isNewPasswordVisible: $isNewPasswordVisible, isConfirmPasswordVisible: $isConfirmPasswordVisible, errorMessage: $errorMessage, resultMessage: $resultMessage, isSuccess: $isSuccess, showResult: $showResult)';
}


}

/// @nodoc
abstract mixin class _$ChangePasswordStateCopyWith<$Res> implements $ChangePasswordStateCopyWith<$Res> {
  factory _$ChangePasswordStateCopyWith(_ChangePasswordState value, $Res Function(_ChangePasswordState) _then) = __$ChangePasswordStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, String currentPassword, String newPassword, String confirmPassword, bool isCurrentPasswordVisible, bool isNewPasswordVisible, bool isConfirmPasswordVisible, String? errorMessage, String? resultMessage, bool isSuccess, bool showResult
});




}
/// @nodoc
class __$ChangePasswordStateCopyWithImpl<$Res>
    implements _$ChangePasswordStateCopyWith<$Res> {
  __$ChangePasswordStateCopyWithImpl(this._self, this._then);

  final _ChangePasswordState _self;
  final $Res Function(_ChangePasswordState) _then;

/// Create a copy of ChangePasswordState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? currentPassword = null,Object? newPassword = null,Object? confirmPassword = null,Object? isCurrentPasswordVisible = null,Object? isNewPasswordVisible = null,Object? isConfirmPasswordVisible = null,Object? errorMessage = freezed,Object? resultMessage = freezed,Object? isSuccess = null,Object? showResult = null,}) {
  return _then(_ChangePasswordState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,currentPassword: null == currentPassword ? _self.currentPassword : currentPassword // ignore: cast_nullable_to_non_nullable
as String,newPassword: null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,confirmPassword: null == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String,isCurrentPasswordVisible: null == isCurrentPasswordVisible ? _self.isCurrentPasswordVisible : isCurrentPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,isNewPasswordVisible: null == isNewPasswordVisible ? _self.isNewPasswordVisible : isNewPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,isConfirmPasswordVisible: null == isConfirmPasswordVisible ? _self.isConfirmPasswordVisible : isConfirmPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,resultMessage: freezed == resultMessage ? _self.resultMessage : resultMessage // ignore: cast_nullable_to_non_nullable
as String?,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,showResult: null == showResult ? _self.showResult : showResult // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
