// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocationState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LocationState()';
}


}

/// @nodoc
class $LocationStateCopyWith<$Res>  {
$LocationStateCopyWith(LocationState _, $Res Function(LocationState) __);
}


/// @nodoc


class LocationInitial implements LocationState {
  const LocationInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LocationState.initial()';
}


}




/// @nodoc


class LocationLoading implements LocationState {
  const LocationLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LocationState.loading()';
}


}




/// @nodoc


class LocationPermissionDenied implements LocationState {
  const LocationPermissionDenied();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationPermissionDenied);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LocationState.permissionDenied()';
}


}




/// @nodoc


class LocationPermissionGranted implements LocationState {
  const LocationPermissionGranted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationPermissionGranted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LocationState.permissionGranted()';
}


}




/// @nodoc


class LocationObtained implements LocationState {
  const LocationObtained({required this.location});
  

 final  LocationData location;

/// Create a copy of LocationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationObtainedCopyWith<LocationObtained> get copyWith => _$LocationObtainedCopyWithImpl<LocationObtained>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationObtained&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,location);

@override
String toString() {
  return 'LocationState.locationObtained(location: $location)';
}


}

/// @nodoc
abstract mixin class $LocationObtainedCopyWith<$Res> implements $LocationStateCopyWith<$Res> {
  factory $LocationObtainedCopyWith(LocationObtained value, $Res Function(LocationObtained) _then) = _$LocationObtainedCopyWithImpl;
@useResult
$Res call({
 LocationData location
});


$LocationDataCopyWith<$Res> get location;

}
/// @nodoc
class _$LocationObtainedCopyWithImpl<$Res>
    implements $LocationObtainedCopyWith<$Res> {
  _$LocationObtainedCopyWithImpl(this._self, this._then);

  final LocationObtained _self;
  final $Res Function(LocationObtained) _then;

/// Create a copy of LocationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? location = null,}) {
  return _then(LocationObtained(
location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LocationData,
  ));
}

/// Create a copy of LocationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationDataCopyWith<$Res> get location {
  
  return $LocationDataCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}

/// @nodoc


class LocationError implements LocationState {
  const LocationError(this.message);
  

 final  String message;

/// Create a copy of LocationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationErrorCopyWith<LocationError> get copyWith => _$LocationErrorCopyWithImpl<LocationError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'LocationState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $LocationErrorCopyWith<$Res> implements $LocationStateCopyWith<$Res> {
  factory $LocationErrorCopyWith(LocationError value, $Res Function(LocationError) _then) = _$LocationErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$LocationErrorCopyWithImpl<$Res>
    implements $LocationErrorCopyWith<$Res> {
  _$LocationErrorCopyWithImpl(this._self, this._then);

  final LocationError _self;
  final $Res Function(LocationError) _then;

/// Create a copy of LocationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(LocationError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
