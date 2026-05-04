// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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


/// Adds pattern-matching-related methods to [PlaceState].
extension PlaceStatePatterns on PlaceState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PlacesInitial value)?  initial,TResult Function( PlacesLoading value)?  loading,TResult Function( PlacesLoaded value)?  loaded,TResult Function( PlacesError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PlacesInitial() when initial != null:
return initial(_that);case PlacesLoading() when loading != null:
return loading(_that);case PlacesLoaded() when loaded != null:
return loaded(_that);case PlacesError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PlacesInitial value)  initial,required TResult Function( PlacesLoading value)  loading,required TResult Function( PlacesLoaded value)  loaded,required TResult Function( PlacesError value)  error,}){
final _that = this;
switch (_that) {
case PlacesInitial():
return initial(_that);case PlacesLoading():
return loading(_that);case PlacesLoaded():
return loaded(_that);case PlacesError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PlacesInitial value)?  initial,TResult? Function( PlacesLoading value)?  loading,TResult? Function( PlacesLoaded value)?  loaded,TResult? Function( PlacesError value)?  error,}){
final _that = this;
switch (_that) {
case PlacesInitial() when initial != null:
return initial(_that);case PlacesLoading() when loading != null:
return loading(_that);case PlacesLoaded() when loaded != null:
return loaded(_that);case PlacesError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Place> places)?  loaded,TResult Function( String error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PlacesInitial() when initial != null:
return initial();case PlacesLoading() when loading != null:
return loading();case PlacesLoaded() when loaded != null:
return loaded(_that.places);case PlacesError() when error != null:
return error(_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Place> places)  loaded,required TResult Function( String error)  error,}) {final _that = this;
switch (_that) {
case PlacesInitial():
return initial();case PlacesLoading():
return loading();case PlacesLoaded():
return loaded(_that.places);case PlacesError():
return error(_that.error);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Place> places)?  loaded,TResult? Function( String error)?  error,}) {final _that = this;
switch (_that) {
case PlacesInitial() when initial != null:
return initial();case PlacesLoading() when loading != null:
return loading();case PlacesLoaded() when loaded != null:
return loaded(_that.places);case PlacesError() when error != null:
return error(_that.error);case _:
  return null;

}
}

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
