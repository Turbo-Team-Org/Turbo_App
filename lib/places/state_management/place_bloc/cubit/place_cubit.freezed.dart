// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlaceState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PlaceState()';
}


}

/// @nodoc
class $PlaceStateCopyWith<$Res>  {
$PlaceStateCopyWith(PlaceState _, $Res Function(PlaceState) __);
}


/// @nodoc


class PlacesInitial implements PlaceState {
  const PlacesInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlacesInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PlaceState.initial()';
}


}




/// @nodoc


class PlacesLoading implements PlaceState {
  const PlacesLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlacesLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PlaceState.loading()';
}


}




/// @nodoc


class PlacesLoaded implements PlaceState {
  const PlacesLoaded({required final  List<Place> places}): _places = places;
  

 final  List<Place> _places;
 List<Place> get places {
  if (_places is EqualUnmodifiableListView) return _places;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_places);
}


/// Create a copy of PlaceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlacesLoadedCopyWith<PlacesLoaded> get copyWith => _$PlacesLoadedCopyWithImpl<PlacesLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlacesLoaded&&const DeepCollectionEquality().equals(other._places, _places));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_places));

@override
String toString() {
  return 'PlaceState.loaded(places: $places)';
}


}

/// @nodoc
abstract mixin class $PlacesLoadedCopyWith<$Res> implements $PlaceStateCopyWith<$Res> {
  factory $PlacesLoadedCopyWith(PlacesLoaded value, $Res Function(PlacesLoaded) _then) = _$PlacesLoadedCopyWithImpl;
@useResult
$Res call({
 List<Place> places
});




}
/// @nodoc
class _$PlacesLoadedCopyWithImpl<$Res>
    implements $PlacesLoadedCopyWith<$Res> {
  _$PlacesLoadedCopyWithImpl(this._self, this._then);

  final PlacesLoaded _self;
  final $Res Function(PlacesLoaded) _then;

/// Create a copy of PlaceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? places = null,}) {
  return _then(PlacesLoaded(
places: null == places ? _self._places : places // ignore: cast_nullable_to_non_nullable
as List<Place>,
  ));
}


}

/// @nodoc


class PlacesError implements PlaceState {
  const PlacesError(this.error);
  

 final  String error;

/// Create a copy of PlaceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlacesErrorCopyWith<PlacesError> get copyWith => _$PlacesErrorCopyWithImpl<PlacesError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlacesError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'PlaceState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $PlacesErrorCopyWith<$Res> implements $PlaceStateCopyWith<$Res> {
  factory $PlacesErrorCopyWith(PlacesError value, $Res Function(PlacesError) _then) = _$PlacesErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$PlacesErrorCopyWithImpl<$Res>
    implements $PlacesErrorCopyWith<$Res> {
  _$PlacesErrorCopyWithImpl(this._self, this._then);

  final PlacesError _self;
  final $Res Function(PlacesError) _then;

/// Create a copy of PlaceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(PlacesError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
