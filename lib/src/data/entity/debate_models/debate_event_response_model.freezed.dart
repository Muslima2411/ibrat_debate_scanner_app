// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'debate_event_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DebateEventResponse {

 int get count; String? get next; String? get previous; List<DebateEvent> get results;
/// Create a copy of DebateEventResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DebateEventResponseCopyWith<DebateEventResponse> get copyWith => _$DebateEventResponseCopyWithImpl<DebateEventResponse>(this as DebateEventResponse, _$identity);

  /// Serializes this DebateEventResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DebateEventResponse&&(identical(other.count, count) || other.count == count)&&(identical(other.next, next) || other.next == next)&&(identical(other.previous, previous) || other.previous == previous)&&const DeepCollectionEquality().equals(other.results, results));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count,next,previous,const DeepCollectionEquality().hash(results));

@override
String toString() {
  return 'DebateEventResponse(count: $count, next: $next, previous: $previous, results: $results)';
}


}

/// @nodoc
abstract mixin class $DebateEventResponseCopyWith<$Res>  {
  factory $DebateEventResponseCopyWith(DebateEventResponse value, $Res Function(DebateEventResponse) _then) = _$DebateEventResponseCopyWithImpl;
@useResult
$Res call({
 int count, String? next, String? previous, List<DebateEvent> results
});




}
/// @nodoc
class _$DebateEventResponseCopyWithImpl<$Res>
    implements $DebateEventResponseCopyWith<$Res> {
  _$DebateEventResponseCopyWithImpl(this._self, this._then);

  final DebateEventResponse _self;
  final $Res Function(DebateEventResponse) _then;

/// Create a copy of DebateEventResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? next = freezed,Object? previous = freezed,Object? results = null,}) {
  return _then(_self.copyWith(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,next: freezed == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as String?,previous: freezed == previous ? _self.previous : previous // ignore: cast_nullable_to_non_nullable
as String?,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<DebateEvent>,
  ));
}

}


/// Adds pattern-matching-related methods to [DebateEventResponse].
extension DebateEventResponsePatterns on DebateEventResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DebateEventResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DebateEventResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DebateEventResponse value)  $default,){
final _that = this;
switch (_that) {
case _DebateEventResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DebateEventResponse value)?  $default,){
final _that = this;
switch (_that) {
case _DebateEventResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count,  String? next,  String? previous,  List<DebateEvent> results)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DebateEventResponse() when $default != null:
return $default(_that.count,_that.next,_that.previous,_that.results);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count,  String? next,  String? previous,  List<DebateEvent> results)  $default,) {final _that = this;
switch (_that) {
case _DebateEventResponse():
return $default(_that.count,_that.next,_that.previous,_that.results);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count,  String? next,  String? previous,  List<DebateEvent> results)?  $default,) {final _that = this;
switch (_that) {
case _DebateEventResponse() when $default != null:
return $default(_that.count,_that.next,_that.previous,_that.results);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DebateEventResponse implements DebateEventResponse {
  const _DebateEventResponse({required this.count, required this.next, required this.previous, required final  List<DebateEvent> results}): _results = results;
  factory _DebateEventResponse.fromJson(Map<String, dynamic> json) => _$DebateEventResponseFromJson(json);

@override final  int count;
@override final  String? next;
@override final  String? previous;
 final  List<DebateEvent> _results;
@override List<DebateEvent> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}


/// Create a copy of DebateEventResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DebateEventResponseCopyWith<_DebateEventResponse> get copyWith => __$DebateEventResponseCopyWithImpl<_DebateEventResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DebateEventResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DebateEventResponse&&(identical(other.count, count) || other.count == count)&&(identical(other.next, next) || other.next == next)&&(identical(other.previous, previous) || other.previous == previous)&&const DeepCollectionEquality().equals(other._results, _results));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count,next,previous,const DeepCollectionEquality().hash(_results));

@override
String toString() {
  return 'DebateEventResponse(count: $count, next: $next, previous: $previous, results: $results)';
}


}

/// @nodoc
abstract mixin class _$DebateEventResponseCopyWith<$Res> implements $DebateEventResponseCopyWith<$Res> {
  factory _$DebateEventResponseCopyWith(_DebateEventResponse value, $Res Function(_DebateEventResponse) _then) = __$DebateEventResponseCopyWithImpl;
@override @useResult
$Res call({
 int count, String? next, String? previous, List<DebateEvent> results
});




}
/// @nodoc
class __$DebateEventResponseCopyWithImpl<$Res>
    implements _$DebateEventResponseCopyWith<$Res> {
  __$DebateEventResponseCopyWithImpl(this._self, this._then);

  final _DebateEventResponse _self;
  final $Res Function(_DebateEventResponse) _then;

/// Create a copy of DebateEventResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? next = freezed,Object? previous = freezed,Object? results = null,}) {
  return _then(_DebateEventResponse(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,next: freezed == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as String?,previous: freezed == previous ? _self.previous : previous // ignore: cast_nullable_to_non_nullable
as String?,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<DebateEvent>,
  ));
}


}

// dart format on
