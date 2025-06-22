// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookingState {

 bool get isLoading; List<ReservationTimeSlot> get availableSlots; List<ReservationTimeSlot> get nextAvailableSlots; ReservationTimeSlot? get selectedSlot; DateTime? get selectedDate; String? get error; String? get success;
/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingStateCopyWith<BookingState> get copyWith => _$BookingStateCopyWithImpl<BookingState>(this as BookingState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.availableSlots, availableSlots)&&const DeepCollectionEquality().equals(other.nextAvailableSlots, nextAvailableSlots)&&(identical(other.selectedSlot, selectedSlot) || other.selectedSlot == selectedSlot)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.error, error) || other.error == error)&&(identical(other.success, success) || other.success == success));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(availableSlots),const DeepCollectionEquality().hash(nextAvailableSlots),selectedSlot,selectedDate,error,success);

@override
String toString() {
  return 'BookingState(isLoading: $isLoading, availableSlots: $availableSlots, nextAvailableSlots: $nextAvailableSlots, selectedSlot: $selectedSlot, selectedDate: $selectedDate, error: $error, success: $success)';
}


}

/// @nodoc
abstract mixin class $BookingStateCopyWith<$Res>  {
  factory $BookingStateCopyWith(BookingState value, $Res Function(BookingState) _then) = _$BookingStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<ReservationTimeSlot> availableSlots, List<ReservationTimeSlot> nextAvailableSlots, ReservationTimeSlot? selectedSlot, DateTime? selectedDate, String? error, String? success
});


$ReservationTimeSlotCopyWith<$Res>? get selectedSlot;

}
/// @nodoc
class _$BookingStateCopyWithImpl<$Res>
    implements $BookingStateCopyWith<$Res> {
  _$BookingStateCopyWithImpl(this._self, this._then);

  final BookingState _self;
  final $Res Function(BookingState) _then;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? availableSlots = null,Object? nextAvailableSlots = null,Object? selectedSlot = freezed,Object? selectedDate = freezed,Object? error = freezed,Object? success = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,availableSlots: null == availableSlots ? _self.availableSlots : availableSlots // ignore: cast_nullable_to_non_nullable
as List<ReservationTimeSlot>,nextAvailableSlots: null == nextAvailableSlots ? _self.nextAvailableSlots : nextAvailableSlots // ignore: cast_nullable_to_non_nullable
as List<ReservationTimeSlot>,selectedSlot: freezed == selectedSlot ? _self.selectedSlot : selectedSlot // ignore: cast_nullable_to_non_nullable
as ReservationTimeSlot?,selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReservationTimeSlotCopyWith<$Res>? get selectedSlot {
    if (_self.selectedSlot == null) {
    return null;
  }

  return $ReservationTimeSlotCopyWith<$Res>(_self.selectedSlot!, (value) {
    return _then(_self.copyWith(selectedSlot: value));
  });
}
}


/// @nodoc


class _BookingState implements BookingState {
  const _BookingState({this.isLoading = false, final  List<ReservationTimeSlot> availableSlots = const [], final  List<ReservationTimeSlot> nextAvailableSlots = const [], this.selectedSlot, this.selectedDate, this.error, this.success}): _availableSlots = availableSlots,_nextAvailableSlots = nextAvailableSlots;
  

@override@JsonKey() final  bool isLoading;
 final  List<ReservationTimeSlot> _availableSlots;
@override@JsonKey() List<ReservationTimeSlot> get availableSlots {
  if (_availableSlots is EqualUnmodifiableListView) return _availableSlots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableSlots);
}

 final  List<ReservationTimeSlot> _nextAvailableSlots;
@override@JsonKey() List<ReservationTimeSlot> get nextAvailableSlots {
  if (_nextAvailableSlots is EqualUnmodifiableListView) return _nextAvailableSlots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_nextAvailableSlots);
}

@override final  ReservationTimeSlot? selectedSlot;
@override final  DateTime? selectedDate;
@override final  String? error;
@override final  String? success;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingStateCopyWith<_BookingState> get copyWith => __$BookingStateCopyWithImpl<_BookingState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._availableSlots, _availableSlots)&&const DeepCollectionEquality().equals(other._nextAvailableSlots, _nextAvailableSlots)&&(identical(other.selectedSlot, selectedSlot) || other.selectedSlot == selectedSlot)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.error, error) || other.error == error)&&(identical(other.success, success) || other.success == success));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_availableSlots),const DeepCollectionEquality().hash(_nextAvailableSlots),selectedSlot,selectedDate,error,success);

@override
String toString() {
  return 'BookingState(isLoading: $isLoading, availableSlots: $availableSlots, nextAvailableSlots: $nextAvailableSlots, selectedSlot: $selectedSlot, selectedDate: $selectedDate, error: $error, success: $success)';
}


}

/// @nodoc
abstract mixin class _$BookingStateCopyWith<$Res> implements $BookingStateCopyWith<$Res> {
  factory _$BookingStateCopyWith(_BookingState value, $Res Function(_BookingState) _then) = __$BookingStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<ReservationTimeSlot> availableSlots, List<ReservationTimeSlot> nextAvailableSlots, ReservationTimeSlot? selectedSlot, DateTime? selectedDate, String? error, String? success
});


@override $ReservationTimeSlotCopyWith<$Res>? get selectedSlot;

}
/// @nodoc
class __$BookingStateCopyWithImpl<$Res>
    implements _$BookingStateCopyWith<$Res> {
  __$BookingStateCopyWithImpl(this._self, this._then);

  final _BookingState _self;
  final $Res Function(_BookingState) _then;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? availableSlots = null,Object? nextAvailableSlots = null,Object? selectedSlot = freezed,Object? selectedDate = freezed,Object? error = freezed,Object? success = freezed,}) {
  return _then(_BookingState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,availableSlots: null == availableSlots ? _self._availableSlots : availableSlots // ignore: cast_nullable_to_non_nullable
as List<ReservationTimeSlot>,nextAvailableSlots: null == nextAvailableSlots ? _self._nextAvailableSlots : nextAvailableSlots // ignore: cast_nullable_to_non_nullable
as List<ReservationTimeSlot>,selectedSlot: freezed == selectedSlot ? _self.selectedSlot : selectedSlot // ignore: cast_nullable_to_non_nullable
as ReservationTimeSlot?,selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReservationTimeSlotCopyWith<$Res>? get selectedSlot {
    if (_self.selectedSlot == null) {
    return null;
  }

  return $ReservationTimeSlotCopyWith<$Res>(_self.selectedSlot!, (value) {
    return _then(_self.copyWith(selectedSlot: value));
  });
}
}

// dart format on
