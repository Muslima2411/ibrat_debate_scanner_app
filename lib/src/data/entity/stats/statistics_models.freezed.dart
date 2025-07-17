// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'statistics_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegionsResponse {

 int get count; List<Region> get results; String? get next; String? get previous;
/// Create a copy of RegionsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegionsResponseCopyWith<RegionsResponse> get copyWith => _$RegionsResponseCopyWithImpl<RegionsResponse>(this as RegionsResponse, _$identity);

  /// Serializes this RegionsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegionsResponse&&(identical(other.count, count) || other.count == count)&&const DeepCollectionEquality().equals(other.results, results)&&(identical(other.next, next) || other.next == next)&&(identical(other.previous, previous) || other.previous == previous));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count,const DeepCollectionEquality().hash(results),next,previous);

@override
String toString() {
  return 'RegionsResponse(count: $count, results: $results, next: $next, previous: $previous)';
}


}

/// @nodoc
abstract mixin class $RegionsResponseCopyWith<$Res>  {
  factory $RegionsResponseCopyWith(RegionsResponse value, $Res Function(RegionsResponse) _then) = _$RegionsResponseCopyWithImpl;
@useResult
$Res call({
 int count, List<Region> results, String? next, String? previous
});




}
/// @nodoc
class _$RegionsResponseCopyWithImpl<$Res>
    implements $RegionsResponseCopyWith<$Res> {
  _$RegionsResponseCopyWithImpl(this._self, this._then);

  final RegionsResponse _self;
  final $Res Function(RegionsResponse) _then;

/// Create a copy of RegionsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? results = null,Object? next = freezed,Object? previous = freezed,}) {
  return _then(_self.copyWith(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<Region>,next: freezed == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as String?,previous: freezed == previous ? _self.previous : previous // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RegionsResponse].
extension RegionsResponsePatterns on RegionsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegionsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegionsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegionsResponse value)  $default,){
final _that = this;
switch (_that) {
case _RegionsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegionsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _RegionsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count,  List<Region> results,  String? next,  String? previous)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegionsResponse() when $default != null:
return $default(_that.count,_that.results,_that.next,_that.previous);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count,  List<Region> results,  String? next,  String? previous)  $default,) {final _that = this;
switch (_that) {
case _RegionsResponse():
return $default(_that.count,_that.results,_that.next,_that.previous);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count,  List<Region> results,  String? next,  String? previous)?  $default,) {final _that = this;
switch (_that) {
case _RegionsResponse() when $default != null:
return $default(_that.count,_that.results,_that.next,_that.previous);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegionsResponse implements RegionsResponse {
  const _RegionsResponse({required this.count, required final  List<Region> results, this.next, this.previous}): _results = results;
  factory _RegionsResponse.fromJson(Map<String, dynamic> json) => _$RegionsResponseFromJson(json);

@override final  int count;
 final  List<Region> _results;
@override List<Region> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

@override final  String? next;
@override final  String? previous;

/// Create a copy of RegionsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegionsResponseCopyWith<_RegionsResponse> get copyWith => __$RegionsResponseCopyWithImpl<_RegionsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegionsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegionsResponse&&(identical(other.count, count) || other.count == count)&&const DeepCollectionEquality().equals(other._results, _results)&&(identical(other.next, next) || other.next == next)&&(identical(other.previous, previous) || other.previous == previous));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count,const DeepCollectionEquality().hash(_results),next,previous);

@override
String toString() {
  return 'RegionsResponse(count: $count, results: $results, next: $next, previous: $previous)';
}


}

/// @nodoc
abstract mixin class _$RegionsResponseCopyWith<$Res> implements $RegionsResponseCopyWith<$Res> {
  factory _$RegionsResponseCopyWith(_RegionsResponse value, $Res Function(_RegionsResponse) _then) = __$RegionsResponseCopyWithImpl;
@override @useResult
$Res call({
 int count, List<Region> results, String? next, String? previous
});




}
/// @nodoc
class __$RegionsResponseCopyWithImpl<$Res>
    implements _$RegionsResponseCopyWith<$Res> {
  __$RegionsResponseCopyWithImpl(this._self, this._then);

  final _RegionsResponse _self;
  final $Res Function(_RegionsResponse) _then;

/// Create a copy of RegionsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? results = null,Object? next = freezed,Object? previous = freezed,}) {
  return _then(_RegionsResponse(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<Region>,next: freezed == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as String?,previous: freezed == previous ? _self.previous : previous // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$StatisticsResponse {

@JsonKey(name: 'all_count') int get allCount;@JsonKey(name: 'has_come_count') int get hasComeCount;
/// Create a copy of StatisticsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatisticsResponseCopyWith<StatisticsResponse> get copyWith => _$StatisticsResponseCopyWithImpl<StatisticsResponse>(this as StatisticsResponse, _$identity);

  /// Serializes this StatisticsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatisticsResponse&&(identical(other.allCount, allCount) || other.allCount == allCount)&&(identical(other.hasComeCount, hasComeCount) || other.hasComeCount == hasComeCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,allCount,hasComeCount);

@override
String toString() {
  return 'StatisticsResponse(allCount: $allCount, hasComeCount: $hasComeCount)';
}


}

/// @nodoc
abstract mixin class $StatisticsResponseCopyWith<$Res>  {
  factory $StatisticsResponseCopyWith(StatisticsResponse value, $Res Function(StatisticsResponse) _then) = _$StatisticsResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'all_count') int allCount,@JsonKey(name: 'has_come_count') int hasComeCount
});




}
/// @nodoc
class _$StatisticsResponseCopyWithImpl<$Res>
    implements $StatisticsResponseCopyWith<$Res> {
  _$StatisticsResponseCopyWithImpl(this._self, this._then);

  final StatisticsResponse _self;
  final $Res Function(StatisticsResponse) _then;

/// Create a copy of StatisticsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? allCount = null,Object? hasComeCount = null,}) {
  return _then(_self.copyWith(
allCount: null == allCount ? _self.allCount : allCount // ignore: cast_nullable_to_non_nullable
as int,hasComeCount: null == hasComeCount ? _self.hasComeCount : hasComeCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [StatisticsResponse].
extension StatisticsResponsePatterns on StatisticsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StatisticsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StatisticsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StatisticsResponse value)  $default,){
final _that = this;
switch (_that) {
case _StatisticsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StatisticsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _StatisticsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'all_count')  int allCount, @JsonKey(name: 'has_come_count')  int hasComeCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StatisticsResponse() when $default != null:
return $default(_that.allCount,_that.hasComeCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'all_count')  int allCount, @JsonKey(name: 'has_come_count')  int hasComeCount)  $default,) {final _that = this;
switch (_that) {
case _StatisticsResponse():
return $default(_that.allCount,_that.hasComeCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'all_count')  int allCount, @JsonKey(name: 'has_come_count')  int hasComeCount)?  $default,) {final _that = this;
switch (_that) {
case _StatisticsResponse() when $default != null:
return $default(_that.allCount,_that.hasComeCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StatisticsResponse implements StatisticsResponse {
  const _StatisticsResponse({@JsonKey(name: 'all_count') required this.allCount, @JsonKey(name: 'has_come_count') required this.hasComeCount});
  factory _StatisticsResponse.fromJson(Map<String, dynamic> json) => _$StatisticsResponseFromJson(json);

@override@JsonKey(name: 'all_count') final  int allCount;
@override@JsonKey(name: 'has_come_count') final  int hasComeCount;

/// Create a copy of StatisticsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatisticsResponseCopyWith<_StatisticsResponse> get copyWith => __$StatisticsResponseCopyWithImpl<_StatisticsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StatisticsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatisticsResponse&&(identical(other.allCount, allCount) || other.allCount == allCount)&&(identical(other.hasComeCount, hasComeCount) || other.hasComeCount == hasComeCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,allCount,hasComeCount);

@override
String toString() {
  return 'StatisticsResponse(allCount: $allCount, hasComeCount: $hasComeCount)';
}


}

/// @nodoc
abstract mixin class _$StatisticsResponseCopyWith<$Res> implements $StatisticsResponseCopyWith<$Res> {
  factory _$StatisticsResponseCopyWith(_StatisticsResponse value, $Res Function(_StatisticsResponse) _then) = __$StatisticsResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'all_count') int allCount,@JsonKey(name: 'has_come_count') int hasComeCount
});




}
/// @nodoc
class __$StatisticsResponseCopyWithImpl<$Res>
    implements _$StatisticsResponseCopyWith<$Res> {
  __$StatisticsResponseCopyWithImpl(this._self, this._then);

  final _StatisticsResponse _self;
  final $Res Function(_StatisticsResponse) _then;

/// Create a copy of StatisticsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? allCount = null,Object? hasComeCount = null,}) {
  return _then(_StatisticsResponse(
allCount: null == allCount ? _self.allCount : allCount // ignore: cast_nullable_to_non_nullable
as int,hasComeCount: null == hasComeCount ? _self.hasComeCount : hasComeCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$StatisticsState {

 List<Region> get regions; bool get isLoadingRegions; bool get isLoadingStats; Region? get selectedRegion; District? get selectedDistrict; StatisticsResponse? get statistics; String? get error;
/// Create a copy of StatisticsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatisticsStateCopyWith<StatisticsState> get copyWith => _$StatisticsStateCopyWithImpl<StatisticsState>(this as StatisticsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatisticsState&&const DeepCollectionEquality().equals(other.regions, regions)&&(identical(other.isLoadingRegions, isLoadingRegions) || other.isLoadingRegions == isLoadingRegions)&&(identical(other.isLoadingStats, isLoadingStats) || other.isLoadingStats == isLoadingStats)&&(identical(other.selectedRegion, selectedRegion) || other.selectedRegion == selectedRegion)&&(identical(other.selectedDistrict, selectedDistrict) || other.selectedDistrict == selectedDistrict)&&(identical(other.statistics, statistics) || other.statistics == statistics)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(regions),isLoadingRegions,isLoadingStats,selectedRegion,selectedDistrict,statistics,error);

@override
String toString() {
  return 'StatisticsState(regions: $regions, isLoadingRegions: $isLoadingRegions, isLoadingStats: $isLoadingStats, selectedRegion: $selectedRegion, selectedDistrict: $selectedDistrict, statistics: $statistics, error: $error)';
}


}

/// @nodoc
abstract mixin class $StatisticsStateCopyWith<$Res>  {
  factory $StatisticsStateCopyWith(StatisticsState value, $Res Function(StatisticsState) _then) = _$StatisticsStateCopyWithImpl;
@useResult
$Res call({
 List<Region> regions, bool isLoadingRegions, bool isLoadingStats, Region? selectedRegion, District? selectedDistrict, StatisticsResponse? statistics, String? error
});


$RegionCopyWith<$Res>? get selectedRegion;$DistrictCopyWith<$Res>? get selectedDistrict;$StatisticsResponseCopyWith<$Res>? get statistics;

}
/// @nodoc
class _$StatisticsStateCopyWithImpl<$Res>
    implements $StatisticsStateCopyWith<$Res> {
  _$StatisticsStateCopyWithImpl(this._self, this._then);

  final StatisticsState _self;
  final $Res Function(StatisticsState) _then;

/// Create a copy of StatisticsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? regions = null,Object? isLoadingRegions = null,Object? isLoadingStats = null,Object? selectedRegion = freezed,Object? selectedDistrict = freezed,Object? statistics = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
regions: null == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<Region>,isLoadingRegions: null == isLoadingRegions ? _self.isLoadingRegions : isLoadingRegions // ignore: cast_nullable_to_non_nullable
as bool,isLoadingStats: null == isLoadingStats ? _self.isLoadingStats : isLoadingStats // ignore: cast_nullable_to_non_nullable
as bool,selectedRegion: freezed == selectedRegion ? _self.selectedRegion : selectedRegion // ignore: cast_nullable_to_non_nullable
as Region?,selectedDistrict: freezed == selectedDistrict ? _self.selectedDistrict : selectedDistrict // ignore: cast_nullable_to_non_nullable
as District?,statistics: freezed == statistics ? _self.statistics : statistics // ignore: cast_nullable_to_non_nullable
as StatisticsResponse?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of StatisticsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegionCopyWith<$Res>? get selectedRegion {
    if (_self.selectedRegion == null) {
    return null;
  }

  return $RegionCopyWith<$Res>(_self.selectedRegion!, (value) {
    return _then(_self.copyWith(selectedRegion: value));
  });
}/// Create a copy of StatisticsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DistrictCopyWith<$Res>? get selectedDistrict {
    if (_self.selectedDistrict == null) {
    return null;
  }

  return $DistrictCopyWith<$Res>(_self.selectedDistrict!, (value) {
    return _then(_self.copyWith(selectedDistrict: value));
  });
}/// Create a copy of StatisticsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatisticsResponseCopyWith<$Res>? get statistics {
    if (_self.statistics == null) {
    return null;
  }

  return $StatisticsResponseCopyWith<$Res>(_self.statistics!, (value) {
    return _then(_self.copyWith(statistics: value));
  });
}
}


/// Adds pattern-matching-related methods to [StatisticsState].
extension StatisticsStatePatterns on StatisticsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StatisticsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StatisticsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StatisticsState value)  $default,){
final _that = this;
switch (_that) {
case _StatisticsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StatisticsState value)?  $default,){
final _that = this;
switch (_that) {
case _StatisticsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Region> regions,  bool isLoadingRegions,  bool isLoadingStats,  Region? selectedRegion,  District? selectedDistrict,  StatisticsResponse? statistics,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StatisticsState() when $default != null:
return $default(_that.regions,_that.isLoadingRegions,_that.isLoadingStats,_that.selectedRegion,_that.selectedDistrict,_that.statistics,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Region> regions,  bool isLoadingRegions,  bool isLoadingStats,  Region? selectedRegion,  District? selectedDistrict,  StatisticsResponse? statistics,  String? error)  $default,) {final _that = this;
switch (_that) {
case _StatisticsState():
return $default(_that.regions,_that.isLoadingRegions,_that.isLoadingStats,_that.selectedRegion,_that.selectedDistrict,_that.statistics,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Region> regions,  bool isLoadingRegions,  bool isLoadingStats,  Region? selectedRegion,  District? selectedDistrict,  StatisticsResponse? statistics,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _StatisticsState() when $default != null:
return $default(_that.regions,_that.isLoadingRegions,_that.isLoadingStats,_that.selectedRegion,_that.selectedDistrict,_that.statistics,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _StatisticsState implements StatisticsState {
  const _StatisticsState({final  List<Region> regions = const [], this.isLoadingRegions = false, this.isLoadingStats = false, this.selectedRegion, this.selectedDistrict, this.statistics, this.error}): _regions = regions;
  

 final  List<Region> _regions;
@override@JsonKey() List<Region> get regions {
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regions);
}

@override@JsonKey() final  bool isLoadingRegions;
@override@JsonKey() final  bool isLoadingStats;
@override final  Region? selectedRegion;
@override final  District? selectedDistrict;
@override final  StatisticsResponse? statistics;
@override final  String? error;

/// Create a copy of StatisticsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatisticsStateCopyWith<_StatisticsState> get copyWith => __$StatisticsStateCopyWithImpl<_StatisticsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatisticsState&&const DeepCollectionEquality().equals(other._regions, _regions)&&(identical(other.isLoadingRegions, isLoadingRegions) || other.isLoadingRegions == isLoadingRegions)&&(identical(other.isLoadingStats, isLoadingStats) || other.isLoadingStats == isLoadingStats)&&(identical(other.selectedRegion, selectedRegion) || other.selectedRegion == selectedRegion)&&(identical(other.selectedDistrict, selectedDistrict) || other.selectedDistrict == selectedDistrict)&&(identical(other.statistics, statistics) || other.statistics == statistics)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_regions),isLoadingRegions,isLoadingStats,selectedRegion,selectedDistrict,statistics,error);

@override
String toString() {
  return 'StatisticsState(regions: $regions, isLoadingRegions: $isLoadingRegions, isLoadingStats: $isLoadingStats, selectedRegion: $selectedRegion, selectedDistrict: $selectedDistrict, statistics: $statistics, error: $error)';
}


}

/// @nodoc
abstract mixin class _$StatisticsStateCopyWith<$Res> implements $StatisticsStateCopyWith<$Res> {
  factory _$StatisticsStateCopyWith(_StatisticsState value, $Res Function(_StatisticsState) _then) = __$StatisticsStateCopyWithImpl;
@override @useResult
$Res call({
 List<Region> regions, bool isLoadingRegions, bool isLoadingStats, Region? selectedRegion, District? selectedDistrict, StatisticsResponse? statistics, String? error
});


@override $RegionCopyWith<$Res>? get selectedRegion;@override $DistrictCopyWith<$Res>? get selectedDistrict;@override $StatisticsResponseCopyWith<$Res>? get statistics;

}
/// @nodoc
class __$StatisticsStateCopyWithImpl<$Res>
    implements _$StatisticsStateCopyWith<$Res> {
  __$StatisticsStateCopyWithImpl(this._self, this._then);

  final _StatisticsState _self;
  final $Res Function(_StatisticsState) _then;

/// Create a copy of StatisticsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? regions = null,Object? isLoadingRegions = null,Object? isLoadingStats = null,Object? selectedRegion = freezed,Object? selectedDistrict = freezed,Object? statistics = freezed,Object? error = freezed,}) {
  return _then(_StatisticsState(
regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<Region>,isLoadingRegions: null == isLoadingRegions ? _self.isLoadingRegions : isLoadingRegions // ignore: cast_nullable_to_non_nullable
as bool,isLoadingStats: null == isLoadingStats ? _self.isLoadingStats : isLoadingStats // ignore: cast_nullable_to_non_nullable
as bool,selectedRegion: freezed == selectedRegion ? _self.selectedRegion : selectedRegion // ignore: cast_nullable_to_non_nullable
as Region?,selectedDistrict: freezed == selectedDistrict ? _self.selectedDistrict : selectedDistrict // ignore: cast_nullable_to_non_nullable
as District?,statistics: freezed == statistics ? _self.statistics : statistics // ignore: cast_nullable_to_non_nullable
as StatisticsResponse?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of StatisticsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RegionCopyWith<$Res>? get selectedRegion {
    if (_self.selectedRegion == null) {
    return null;
  }

  return $RegionCopyWith<$Res>(_self.selectedRegion!, (value) {
    return _then(_self.copyWith(selectedRegion: value));
  });
}/// Create a copy of StatisticsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DistrictCopyWith<$Res>? get selectedDistrict {
    if (_self.selectedDistrict == null) {
    return null;
  }

  return $DistrictCopyWith<$Res>(_self.selectedDistrict!, (value) {
    return _then(_self.copyWith(selectedDistrict: value));
  });
}/// Create a copy of StatisticsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatisticsResponseCopyWith<$Res>? get statistics {
    if (_self.statistics == null) {
    return null;
  }

  return $StatisticsResponseCopyWith<$Res>(_self.statistics!, (value) {
    return _then(_self.copyWith(statistics: value));
  });
}
}

// dart format on
