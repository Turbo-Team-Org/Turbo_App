// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookingFormState {

 bool get isCreating; bool get success; Reservation? get createdReservation; String? get error;
/// Create a copy of BookingFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingFormStateCopyWith<BookingFormState> get copyWith => _$BookingFormStateCopyWithImpl<BookingFormState>(this as BookingFormState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingFormState&&(identical(other.isCreating, isCreating) || other.isCreating == isCreating)&&(identical(other.success, success) || other.success == success)&&(identical(other.createdReservation, createdReservation) || other.createdReservation == createdReservation)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isCreating,success,createdReservation,error);

@override
String toString() {
  return 'BookingFormState(isCreating: $isCreating, success: $success, createdReservation: $createdReservation, error: $error)';
}


}

/// @nodoc
abstract mixin class $BookingFormStateCopyWith<$Res>  {
  factory $BookingFormStateCopyWith(BookingFormState value, $Res Function(BookingFormState) _then) = _$BookingFormStateCopyWithImpl;
@useResult
$Res call({
 bool isCreating, bool success, Reservation? createdReservation, String? error
});


$ReservationCopyWith<$Res>? get createdReservation;

}
/// @nodoc
class _$BookingFormStateCopyWithImpl<$Res>
    implements $BookingFormStateCopyWith<$Res> {
  _$BookingFormStateCopyWithImpl(this._self, this._then);

  final BookingFormState _self;
  final $Res Function(BookingFormState) _then;

/// Create a copy of BookingFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isCreating = null,Object? success = null,Object? createdReservation = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
isCreating: null == isCreating ? _self.isCreating : isCreating // ignore: cast_nullable_to_non_nullable
as bool,success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,createdReservation: freezed == createdReservation ? _self.createdReservation : createdReservation // ignore: cast_nullable_to_non_nullable
as Reservation?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of BookingFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReservationCopyWith<$Res>? get createdReservation {
    if (_self.createdReservation == null) {
    return null;
  }

  return $ReservationCopyWith<$Res>(_self.createdReservation!, (value) {
    return _then(_self.copyWith(createdReservation: value));
  });
}
}


/// Adds pattern-matching-related methods to [BookingFormState].
extension BookingFormStatePatterns on BookingFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingFormState value)  $default,){
final _that = this;
switch (_that) {
case _BookingFormState():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingFormState value)?  $default,){
final _that = this;
switch (_that) {
case _BookingFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isCreating,  bool success,  Reservation? createdReservation,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingFormState() when $default != null:
return $default(_that.isCreating,_that.success,_that.createdReservation,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isCreating,  bool success,  Reservation? createdReservation,  String? error)  $default,) {final _that = this;
switch (_that) {
case _BookingFormState():
return $default(_that.isCreating,_that.success,_that.createdReservation,_that.error);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isCreating,  bool success,  Reservation? createdReservation,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _BookingFormState() when $default != null:
return $default(_that.isCreating,_that.success,_that.createdReservation,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _BookingFormState implements BookingFormState {
  const _BookingFormState({this.isCreating = false, this.success = false, this.createdReservation, this.error});
  

@override@JsonKey() final  bool isCreating;
@override@JsonKey() final  bool success;
@override final  Reservation? createdReservation;
@override final  String? error;

/// Create a copy of BookingFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingFormStateCopyWith<_BookingFormState> get copyWith => __$BookingFormStateCopyWithImpl<_BookingFormState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingFormState&&(identical(other.isCreating, isCreating) || other.isCreating == isCreating)&&(identical(other.success, success) || other.success == success)&&(identical(other.createdReservation, createdReservation) || other.createdReservation == createdReservation)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isCreating,success,createdReservation,error);

@override
String toString() {
  return 'BookingFormState(isCreating: $isCreating, success: $success, createdReservation: $createdReservation, error: $error)';
}


}

/// @nodoc
abstract mixin class _$BookingFormStateCopyWith<$Res> implements $BookingFormStateCopyWith<$Res> {
  factory _$BookingFormStateCopyWith(_BookingFormState value, $Res Function(_BookingFormState) _then) = __$BookingFormStateCopyWithImpl;
@override @useResult
$Res call({
 bool isCreating, bool success, Reservation? createdReservation, String? error
});


@override $ReservationCopyWith<$Res>? get createdReservation;

}
/// @nodoc
class __$BookingFormStateCopyWithImpl<$Res>
    implements _$BookingFormStateCopyWith<$Res> {
  __$BookingFormStateCopyWithImpl(this._self, this._then);

  final _BookingFormState _self;
  final $Res Function(_BookingFormState) _then;

/// Create a copy of BookingFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isCreating = null,Object? success = null,Object? createdReservation = freezed,Object? error = freezed,}) {
  return _then(_BookingFormState(
isCreating: null == isCreating ? _self.isCreating : isCreating // ignore: cast_nullable_to_non_nullable
as bool,success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,createdReservation: freezed == createdReservation ? _self.createdReservation : createdReservation // ignore: cast_nullable_to_non_nullable
as Reservation?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of BookingFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReservationCopyWith<$Res>? get createdReservation {
    if (_self.createdReservation == null) {
    return null;
  }

  return $ReservationCopyWith<$Res>(_self.createdReservation!, (value) {
    return _then(_self.copyWith(createdReservation: value));
  });
}
}

// dart format on
