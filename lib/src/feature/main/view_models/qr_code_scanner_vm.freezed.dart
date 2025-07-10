// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qr_code_scanner_vm.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QrCodeScannerState implements DiagnosticableTreeMixin {

 bool get isScanning; bool get isLoading; bool get isDisposed; bool get isConfirming;// Loading state for confirmation
 String? get scannedCode; TicketModel? get ticket; UserModel? get user; String? get errorMessage; bool get shouldNavigateBack;
/// Create a copy of QrCodeScannerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QrCodeScannerStateCopyWith<QrCodeScannerState> get copyWith => _$QrCodeScannerStateCopyWithImpl<QrCodeScannerState>(this as QrCodeScannerState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'QrCodeScannerState'))
    ..add(DiagnosticsProperty('isScanning', isScanning))..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('isDisposed', isDisposed))..add(DiagnosticsProperty('isConfirming', isConfirming))..add(DiagnosticsProperty('scannedCode', scannedCode))..add(DiagnosticsProperty('ticket', ticket))..add(DiagnosticsProperty('user', user))..add(DiagnosticsProperty('errorMessage', errorMessage))..add(DiagnosticsProperty('shouldNavigateBack', shouldNavigateBack));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QrCodeScannerState&&(identical(other.isScanning, isScanning) || other.isScanning == isScanning)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isDisposed, isDisposed) || other.isDisposed == isDisposed)&&(identical(other.isConfirming, isConfirming) || other.isConfirming == isConfirming)&&(identical(other.scannedCode, scannedCode) || other.scannedCode == scannedCode)&&(identical(other.ticket, ticket) || other.ticket == ticket)&&(identical(other.user, user) || other.user == user)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.shouldNavigateBack, shouldNavigateBack) || other.shouldNavigateBack == shouldNavigateBack));
}


@override
int get hashCode => Object.hash(runtimeType,isScanning,isLoading,isDisposed,isConfirming,scannedCode,ticket,user,errorMessage,shouldNavigateBack);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'QrCodeScannerState(isScanning: $isScanning, isLoading: $isLoading, isDisposed: $isDisposed, isConfirming: $isConfirming, scannedCode: $scannedCode, ticket: $ticket, user: $user, errorMessage: $errorMessage, shouldNavigateBack: $shouldNavigateBack)';
}


}

/// @nodoc
abstract mixin class $QrCodeScannerStateCopyWith<$Res>  {
  factory $QrCodeScannerStateCopyWith(QrCodeScannerState value, $Res Function(QrCodeScannerState) _then) = _$QrCodeScannerStateCopyWithImpl;
@useResult
$Res call({
 bool isScanning, bool isLoading, bool isDisposed, bool isConfirming, String? scannedCode, TicketModel? ticket, UserModel? user, String? errorMessage, bool shouldNavigateBack
});


$TicketModelCopyWith<$Res>? get ticket;

}
/// @nodoc
class _$QrCodeScannerStateCopyWithImpl<$Res>
    implements $QrCodeScannerStateCopyWith<$Res> {
  _$QrCodeScannerStateCopyWithImpl(this._self, this._then);

  final QrCodeScannerState _self;
  final $Res Function(QrCodeScannerState) _then;

/// Create a copy of QrCodeScannerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isScanning = null,Object? isLoading = null,Object? isDisposed = null,Object? isConfirming = null,Object? scannedCode = freezed,Object? ticket = freezed,Object? user = freezed,Object? errorMessage = freezed,Object? shouldNavigateBack = null,}) {
  return _then(_self.copyWith(
isScanning: null == isScanning ? _self.isScanning : isScanning // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isDisposed: null == isDisposed ? _self.isDisposed : isDisposed // ignore: cast_nullable_to_non_nullable
as bool,isConfirming: null == isConfirming ? _self.isConfirming : isConfirming // ignore: cast_nullable_to_non_nullable
as bool,scannedCode: freezed == scannedCode ? _self.scannedCode : scannedCode // ignore: cast_nullable_to_non_nullable
as String?,ticket: freezed == ticket ? _self.ticket : ticket // ignore: cast_nullable_to_non_nullable
as TicketModel?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserModel?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,shouldNavigateBack: null == shouldNavigateBack ? _self.shouldNavigateBack : shouldNavigateBack // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of QrCodeScannerState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TicketModelCopyWith<$Res>? get ticket {
    if (_self.ticket == null) {
    return null;
  }

  return $TicketModelCopyWith<$Res>(_self.ticket!, (value) {
    return _then(_self.copyWith(ticket: value));
  });
}
}


/// Adds pattern-matching-related methods to [QrCodeScannerState].
extension QrCodeScannerStatePatterns on QrCodeScannerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QrCodeScannerState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QrCodeScannerState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QrCodeScannerState value)  $default,){
final _that = this;
switch (_that) {
case _QrCodeScannerState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QrCodeScannerState value)?  $default,){
final _that = this;
switch (_that) {
case _QrCodeScannerState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isScanning,  bool isLoading,  bool isDisposed,  bool isConfirming,  String? scannedCode,  TicketModel? ticket,  UserModel? user,  String? errorMessage,  bool shouldNavigateBack)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QrCodeScannerState() when $default != null:
return $default(_that.isScanning,_that.isLoading,_that.isDisposed,_that.isConfirming,_that.scannedCode,_that.ticket,_that.user,_that.errorMessage,_that.shouldNavigateBack);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isScanning,  bool isLoading,  bool isDisposed,  bool isConfirming,  String? scannedCode,  TicketModel? ticket,  UserModel? user,  String? errorMessage,  bool shouldNavigateBack)  $default,) {final _that = this;
switch (_that) {
case _QrCodeScannerState():
return $default(_that.isScanning,_that.isLoading,_that.isDisposed,_that.isConfirming,_that.scannedCode,_that.ticket,_that.user,_that.errorMessage,_that.shouldNavigateBack);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isScanning,  bool isLoading,  bool isDisposed,  bool isConfirming,  String? scannedCode,  TicketModel? ticket,  UserModel? user,  String? errorMessage,  bool shouldNavigateBack)?  $default,) {final _that = this;
switch (_that) {
case _QrCodeScannerState() when $default != null:
return $default(_that.isScanning,_that.isLoading,_that.isDisposed,_that.isConfirming,_that.scannedCode,_that.ticket,_that.user,_that.errorMessage,_that.shouldNavigateBack);case _:
  return null;

}
}

}

/// @nodoc


class _QrCodeScannerState with DiagnosticableTreeMixin implements QrCodeScannerState {
  const _QrCodeScannerState({this.isScanning = false, this.isLoading = false, this.isDisposed = false, this.isConfirming = false, this.scannedCode, this.ticket, this.user, this.errorMessage, this.shouldNavigateBack = false});
  

@override@JsonKey() final  bool isScanning;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isDisposed;
@override@JsonKey() final  bool isConfirming;
// Loading state for confirmation
@override final  String? scannedCode;
@override final  TicketModel? ticket;
@override final  UserModel? user;
@override final  String? errorMessage;
@override@JsonKey() final  bool shouldNavigateBack;

/// Create a copy of QrCodeScannerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QrCodeScannerStateCopyWith<_QrCodeScannerState> get copyWith => __$QrCodeScannerStateCopyWithImpl<_QrCodeScannerState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'QrCodeScannerState'))
    ..add(DiagnosticsProperty('isScanning', isScanning))..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('isDisposed', isDisposed))..add(DiagnosticsProperty('isConfirming', isConfirming))..add(DiagnosticsProperty('scannedCode', scannedCode))..add(DiagnosticsProperty('ticket', ticket))..add(DiagnosticsProperty('user', user))..add(DiagnosticsProperty('errorMessage', errorMessage))..add(DiagnosticsProperty('shouldNavigateBack', shouldNavigateBack));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QrCodeScannerState&&(identical(other.isScanning, isScanning) || other.isScanning == isScanning)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isDisposed, isDisposed) || other.isDisposed == isDisposed)&&(identical(other.isConfirming, isConfirming) || other.isConfirming == isConfirming)&&(identical(other.scannedCode, scannedCode) || other.scannedCode == scannedCode)&&(identical(other.ticket, ticket) || other.ticket == ticket)&&(identical(other.user, user) || other.user == user)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.shouldNavigateBack, shouldNavigateBack) || other.shouldNavigateBack == shouldNavigateBack));
}


@override
int get hashCode => Object.hash(runtimeType,isScanning,isLoading,isDisposed,isConfirming,scannedCode,ticket,user,errorMessage,shouldNavigateBack);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'QrCodeScannerState(isScanning: $isScanning, isLoading: $isLoading, isDisposed: $isDisposed, isConfirming: $isConfirming, scannedCode: $scannedCode, ticket: $ticket, user: $user, errorMessage: $errorMessage, shouldNavigateBack: $shouldNavigateBack)';
}


}

/// @nodoc
abstract mixin class _$QrCodeScannerStateCopyWith<$Res> implements $QrCodeScannerStateCopyWith<$Res> {
  factory _$QrCodeScannerStateCopyWith(_QrCodeScannerState value, $Res Function(_QrCodeScannerState) _then) = __$QrCodeScannerStateCopyWithImpl;
@override @useResult
$Res call({
 bool isScanning, bool isLoading, bool isDisposed, bool isConfirming, String? scannedCode, TicketModel? ticket, UserModel? user, String? errorMessage, bool shouldNavigateBack
});


@override $TicketModelCopyWith<$Res>? get ticket;

}
/// @nodoc
class __$QrCodeScannerStateCopyWithImpl<$Res>
    implements _$QrCodeScannerStateCopyWith<$Res> {
  __$QrCodeScannerStateCopyWithImpl(this._self, this._then);

  final _QrCodeScannerState _self;
  final $Res Function(_QrCodeScannerState) _then;

/// Create a copy of QrCodeScannerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isScanning = null,Object? isLoading = null,Object? isDisposed = null,Object? isConfirming = null,Object? scannedCode = freezed,Object? ticket = freezed,Object? user = freezed,Object? errorMessage = freezed,Object? shouldNavigateBack = null,}) {
  return _then(_QrCodeScannerState(
isScanning: null == isScanning ? _self.isScanning : isScanning // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isDisposed: null == isDisposed ? _self.isDisposed : isDisposed // ignore: cast_nullable_to_non_nullable
as bool,isConfirming: null == isConfirming ? _self.isConfirming : isConfirming // ignore: cast_nullable_to_non_nullable
as bool,scannedCode: freezed == scannedCode ? _self.scannedCode : scannedCode // ignore: cast_nullable_to_non_nullable
as String?,ticket: freezed == ticket ? _self.ticket : ticket // ignore: cast_nullable_to_non_nullable
as TicketModel?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserModel?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,shouldNavigateBack: null == shouldNavigateBack ? _self.shouldNavigateBack : shouldNavigateBack // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of QrCodeScannerState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TicketModelCopyWith<$Res>? get ticket {
    if (_self.ticket == null) {
    return null;
  }

  return $TicketModelCopyWith<$Res>(_self.ticket!, (value) {
    return _then(_self.copyWith(ticket: value));
  });
}
}

// dart format on
