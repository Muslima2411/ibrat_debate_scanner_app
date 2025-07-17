// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HistoryState {

 List<TicketModel> get tickets; List<Region> get regions; bool get isLoadingRegions; bool get isLoadingTickets; Region? get selectedRegion; District? get selectedDistrict; String? get error;
/// Create a copy of HistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryStateCopyWith<HistoryState> get copyWith => _$HistoryStateCopyWithImpl<HistoryState>(this as HistoryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryState&&const DeepCollectionEquality().equals(other.tickets, tickets)&&const DeepCollectionEquality().equals(other.regions, regions)&&(identical(other.isLoadingRegions, isLoadingRegions) || other.isLoadingRegions == isLoadingRegions)&&(identical(other.isLoadingTickets, isLoadingTickets) || other.isLoadingTickets == isLoadingTickets)&&(identical(other.selectedRegion, selectedRegion) || other.selectedRegion == selectedRegion)&&(identical(other.selectedDistrict, selectedDistrict) || other.selectedDistrict == selectedDistrict)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(tickets),const DeepCollectionEquality().hash(regions),isLoadingRegions,isLoadingTickets,selectedRegion,selectedDistrict,error);

@override
String toString() {
  return 'HistoryState(tickets: $tickets, regions: $regions, isLoadingRegions: $isLoadingRegions, isLoadingTickets: $isLoadingTickets, selectedRegion: $selectedRegion, selectedDistrict: $selectedDistrict, error: $error)';
}


}

/// @nodoc
abstract mixin class $HistoryStateCopyWith<$Res>  {
  factory $HistoryStateCopyWith(HistoryState value, $Res Function(HistoryState) _then) = _$HistoryStateCopyWithImpl;
@useResult
$Res call({
 List<TicketModel> tickets, List<Region> regions, bool isLoadingRegions, bool isLoadingTickets, Region? selectedRegion, District? selectedDistrict, String? error
});


$RegionCopyWith<$Res>? get selectedRegion;$DistrictCopyWith<$Res>? get selectedDistrict;

}
/// @nodoc
class _$HistoryStateCopyWithImpl<$Res>
    implements $HistoryStateCopyWith<$Res> {
  _$HistoryStateCopyWithImpl(this._self, this._then);

  final HistoryState _self;
  final $Res Function(HistoryState) _then;

/// Create a copy of HistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tickets = null,Object? regions = null,Object? isLoadingRegions = null,Object? isLoadingTickets = null,Object? selectedRegion = freezed,Object? selectedDistrict = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
tickets: null == tickets ? _self.tickets : tickets // ignore: cast_nullable_to_non_nullable
as List<TicketModel>,regions: null == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<Region>,isLoadingRegions: null == isLoadingRegions ? _self.isLoadingRegions : isLoadingRegions // ignore: cast_nullable_to_non_nullable
as bool,isLoadingTickets: null == isLoadingTickets ? _self.isLoadingTickets : isLoadingTickets // ignore: cast_nullable_to_non_nullable
as bool,selectedRegion: freezed == selectedRegion ? _self.selectedRegion : selectedRegion // ignore: cast_nullable_to_non_nullable
as Region?,selectedDistrict: freezed == selectedDistrict ? _self.selectedDistrict : selectedDistrict // ignore: cast_nullable_to_non_nullable
as District?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of HistoryState
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
}/// Create a copy of HistoryState
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
}
}


/// Adds pattern-matching-related methods to [HistoryState].
extension HistoryStatePatterns on HistoryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HistoryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistoryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HistoryState value)  $default,){
final _that = this;
switch (_that) {
case _HistoryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HistoryState value)?  $default,){
final _that = this;
switch (_that) {
case _HistoryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TicketModel> tickets,  List<Region> regions,  bool isLoadingRegions,  bool isLoadingTickets,  Region? selectedRegion,  District? selectedDistrict,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HistoryState() when $default != null:
return $default(_that.tickets,_that.regions,_that.isLoadingRegions,_that.isLoadingTickets,_that.selectedRegion,_that.selectedDistrict,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TicketModel> tickets,  List<Region> regions,  bool isLoadingRegions,  bool isLoadingTickets,  Region? selectedRegion,  District? selectedDistrict,  String? error)  $default,) {final _that = this;
switch (_that) {
case _HistoryState():
return $default(_that.tickets,_that.regions,_that.isLoadingRegions,_that.isLoadingTickets,_that.selectedRegion,_that.selectedDistrict,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TicketModel> tickets,  List<Region> regions,  bool isLoadingRegions,  bool isLoadingTickets,  Region? selectedRegion,  District? selectedDistrict,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _HistoryState() when $default != null:
return $default(_that.tickets,_that.regions,_that.isLoadingRegions,_that.isLoadingTickets,_that.selectedRegion,_that.selectedDistrict,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _HistoryState implements HistoryState {
  const _HistoryState({final  List<TicketModel> tickets = const [], final  List<Region> regions = const [], this.isLoadingRegions = false, this.isLoadingTickets = false, this.selectedRegion, this.selectedDistrict, this.error}): _tickets = tickets,_regions = regions;
  

 final  List<TicketModel> _tickets;
@override@JsonKey() List<TicketModel> get tickets {
  if (_tickets is EqualUnmodifiableListView) return _tickets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tickets);
}

 final  List<Region> _regions;
@override@JsonKey() List<Region> get regions {
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regions);
}

@override@JsonKey() final  bool isLoadingRegions;
@override@JsonKey() final  bool isLoadingTickets;
@override final  Region? selectedRegion;
@override final  District? selectedDistrict;
@override final  String? error;

/// Create a copy of HistoryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoryStateCopyWith<_HistoryState> get copyWith => __$HistoryStateCopyWithImpl<_HistoryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoryState&&const DeepCollectionEquality().equals(other._tickets, _tickets)&&const DeepCollectionEquality().equals(other._regions, _regions)&&(identical(other.isLoadingRegions, isLoadingRegions) || other.isLoadingRegions == isLoadingRegions)&&(identical(other.isLoadingTickets, isLoadingTickets) || other.isLoadingTickets == isLoadingTickets)&&(identical(other.selectedRegion, selectedRegion) || other.selectedRegion == selectedRegion)&&(identical(other.selectedDistrict, selectedDistrict) || other.selectedDistrict == selectedDistrict)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_tickets),const DeepCollectionEquality().hash(_regions),isLoadingRegions,isLoadingTickets,selectedRegion,selectedDistrict,error);

@override
String toString() {
  return 'HistoryState(tickets: $tickets, regions: $regions, isLoadingRegions: $isLoadingRegions, isLoadingTickets: $isLoadingTickets, selectedRegion: $selectedRegion, selectedDistrict: $selectedDistrict, error: $error)';
}


}

/// @nodoc
abstract mixin class _$HistoryStateCopyWith<$Res> implements $HistoryStateCopyWith<$Res> {
  factory _$HistoryStateCopyWith(_HistoryState value, $Res Function(_HistoryState) _then) = __$HistoryStateCopyWithImpl;
@override @useResult
$Res call({
 List<TicketModel> tickets, List<Region> regions, bool isLoadingRegions, bool isLoadingTickets, Region? selectedRegion, District? selectedDistrict, String? error
});


@override $RegionCopyWith<$Res>? get selectedRegion;@override $DistrictCopyWith<$Res>? get selectedDistrict;

}
/// @nodoc
class __$HistoryStateCopyWithImpl<$Res>
    implements _$HistoryStateCopyWith<$Res> {
  __$HistoryStateCopyWithImpl(this._self, this._then);

  final _HistoryState _self;
  final $Res Function(_HistoryState) _then;

/// Create a copy of HistoryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tickets = null,Object? regions = null,Object? isLoadingRegions = null,Object? isLoadingTickets = null,Object? selectedRegion = freezed,Object? selectedDistrict = freezed,Object? error = freezed,}) {
  return _then(_HistoryState(
tickets: null == tickets ? _self._tickets : tickets // ignore: cast_nullable_to_non_nullable
as List<TicketModel>,regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<Region>,isLoadingRegions: null == isLoadingRegions ? _self.isLoadingRegions : isLoadingRegions // ignore: cast_nullable_to_non_nullable
as bool,isLoadingTickets: null == isLoadingTickets ? _self.isLoadingTickets : isLoadingTickets // ignore: cast_nullable_to_non_nullable
as bool,selectedRegion: freezed == selectedRegion ? _self.selectedRegion : selectedRegion // ignore: cast_nullable_to_non_nullable
as Region?,selectedDistrict: freezed == selectedDistrict ? _self.selectedDistrict : selectedDistrict // ignore: cast_nullable_to_non_nullable
as District?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of HistoryState
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
}/// Create a copy of HistoryState
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
}
}

// dart format on
