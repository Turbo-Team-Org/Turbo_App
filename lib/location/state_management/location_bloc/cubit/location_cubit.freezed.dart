// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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


/// Adds pattern-matching-related methods to [LocationState].
extension LocationStatePatterns on LocationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LocationInitial value)?  initial,TResult Function( LocationLoading value)?  loading,TResult Function( LocationPermissionDenied value)?  permissionDenied,TResult Function( LocationPermissionGranted value)?  permissionGranted,TResult Function( LocationObtained value)?  locationObtained,TResult Function( LocationError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LocationInitial() when initial != null:
return initial(_that);case LocationLoading() when loading != null:
return loading(_that);case LocationPermissionDenied() when permissionDenied != null:
return permissionDenied(_that);case LocationPermissionGranted() when permissionGranted != null:
return permissionGranted(_that);case LocationObtained() when locationObtained != null:
return locationObtained(_that);case LocationError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LocationInitial value)  initial,required TResult Function( LocationLoading value)  loading,required TResult Function( LocationPermissionDenied value)  permissionDenied,required TResult Function( LocationPermissionGranted value)  permissionGranted,required TResult Function( LocationObtained value)  locationObtained,required TResult Function( LocationError value)  error,}){
final _that = this;
switch (_that) {
case LocationInitial():
return initial(_that);case LocationLoading():
return loading(_that);case LocationPermissionDenied():
return permissionDenied(_that);case LocationPermissionGranted():
return permissionGranted(_that);case LocationObtained():
return locationObtained(_that);case LocationError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LocationInitial value)?  initial,TResult? Function( LocationLoading value)?  loading,TResult? Function( LocationPermissionDenied value)?  permissionDenied,TResult? Function( LocationPermissionGranted value)?  permissionGranted,TResult? Function( LocationObtained value)?  locationObtained,TResult? Function( LocationError value)?  error,}){
final _that = this;
switch (_that) {
case LocationInitial() when initial != null:
return initial(_that);case LocationLoading() when loading != null:
return loading(_that);case LocationPermissionDenied() when permissionDenied != null:
return permissionDenied(_that);case LocationPermissionGranted() when permissionGranted != null:
return permissionGranted(_that);case LocationObtained() when locationObtained != null:
return locationObtained(_that);case LocationError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  permissionDenied,TResult Function()?  permissionGranted,TResult Function( LocationData location)?  locationObtained,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LocationInitial() when initial != null:
return initial();case LocationLoading() when loading != null:
return loading();case LocationPermissionDenied() when permissionDenied != null:
return permissionDenied();case LocationPermissionGranted() when permissionGranted != null:
return permissionGranted();case LocationObtained() when locationObtained != null:
return locationObtained(_that.location);case LocationError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  permissionDenied,required TResult Function()  permissionGranted,required TResult Function( LocationData location)  locationObtained,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case LocationInitial():
return initial();case LocationLoading():
return loading();case LocationPermissionDenied():
return permissionDenied();case LocationPermissionGranted():
return permissionGranted();case LocationObtained():
return locationObtained(_that.location);case LocationError():
return error(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  permissionDenied,TResult? Function()?  permissionGranted,TResult? Function( LocationData location)?  locationObtained,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case LocationInitial() when initial != null:
return initial();case LocationLoading() when loading != null:
return loading();case LocationPermissionDenied() when permissionDenied != null:
return permissionDenied();case LocationPermissionGranted() when permissionGranted != null:
return permissionGranted();case LocationObtained() when locationObtained != null:
return locationObtained(_that.location);case LocationError() when error != null:
return error(_that.message);case _:
  return null;

}
}

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
