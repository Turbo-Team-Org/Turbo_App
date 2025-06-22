// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_reservations_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MyReservationsState {

 bool get isLoading; bool get isCancelling; List<Reservation> get upcomingReservations; List<Reservation> get pastReservations; List<Reservation> get cancelledReservations; String? get error; String? get success;
/// Create a copy of MyReservationsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyReservationsStateCopyWith<MyReservationsState> get copyWith => _$MyReservationsStateCopyWithImpl<MyReservationsState>(this as MyReservationsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyReservationsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isCancelling, isCancelling) || other.isCancelling == isCancelling)&&const DeepCollectionEquality().equals(other.upcomingReservations, upcomingReservations)&&const DeepCollectionEquality().equals(other.pastReservations, pastReservations)&&const DeepCollectionEquality().equals(other.cancelledReservations, cancelledReservations)&&(identical(other.error, error) || other.error == error)&&(identical(other.success, success) || other.success == success));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isCancelling,const DeepCollectionEquality().hash(upcomingReservations),const DeepCollectionEquality().hash(pastReservations),const DeepCollectionEquality().hash(cancelledReservations),error,success);

@override
String toString() {
  return 'MyReservationsState(isLoading: $isLoading, isCancelling: $isCancelling, upcomingReservations: $upcomingReservations, pastReservations: $pastReservations, cancelledReservations: $cancelledReservations, error: $error, success: $success)';
}


}

/// @nodoc
abstract mixin class $MyReservationsStateCopyWith<$Res>  {
  factory $MyReservationsStateCopyWith(MyReservationsState value, $Res Function(MyReservationsState) _then) = _$MyReservationsStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isCancelling, List<Reservation> upcomingReservations, List<Reservation> pastReservations, List<Reservation> cancelledReservations, String? error, String? success
});




}
/// @nodoc
class _$MyReservationsStateCopyWithImpl<$Res>
    implements $MyReservationsStateCopyWith<$Res> {
  _$MyReservationsStateCopyWithImpl(this._self, this._then);

  final MyReservationsState _self;
  final $Res Function(MyReservationsState) _then;

/// Create a copy of MyReservationsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isCancelling = null,Object? upcomingReservations = null,Object? pastReservations = null,Object? cancelledReservations = null,Object? error = freezed,Object? success = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isCancelling: null == isCancelling ? _self.isCancelling : isCancelling // ignore: cast_nullable_to_non_nullable
as bool,upcomingReservations: null == upcomingReservations ? _self.upcomingReservations : upcomingReservations // ignore: cast_nullable_to_non_nullable
as List<Reservation>,pastReservations: null == pastReservations ? _self.pastReservations : pastReservations // ignore: cast_nullable_to_non_nullable
as List<Reservation>,cancelledReservations: null == cancelledReservations ? _self.cancelledReservations : cancelledReservations // ignore: cast_nullable_to_non_nullable
as List<Reservation>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _MyReservationsState implements MyReservationsState {
  const _MyReservationsState({this.isLoading = false, this.isCancelling = false, final  List<Reservation> upcomingReservations = const [], final  List<Reservation> pastReservations = const [], final  List<Reservation> cancelledReservations = const [], this.error, this.success}): _upcomingReservations = upcomingReservations,_pastReservations = pastReservations,_cancelledReservations = cancelledReservations;
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isCancelling;
 final  List<Reservation> _upcomingReservations;
@override@JsonKey() List<Reservation> get upcomingReservations {
  if (_upcomingReservations is EqualUnmodifiableListView) return _upcomingReservations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_upcomingReservations);
}

 final  List<Reservation> _pastReservations;
@override@JsonKey() List<Reservation> get pastReservations {
  if (_pastReservations is EqualUnmodifiableListView) return _pastReservations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pastReservations);
}

 final  List<Reservation> _cancelledReservations;
@override@JsonKey() List<Reservation> get cancelledReservations {
  if (_cancelledReservations is EqualUnmodifiableListView) return _cancelledReservations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cancelledReservations);
}

@override final  String? error;
@override final  String? success;

/// Create a copy of MyReservationsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyReservationsStateCopyWith<_MyReservationsState> get copyWith => __$MyReservationsStateCopyWithImpl<_MyReservationsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyReservationsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isCancelling, isCancelling) || other.isCancelling == isCancelling)&&const DeepCollectionEquality().equals(other._upcomingReservations, _upcomingReservations)&&const DeepCollectionEquality().equals(other._pastReservations, _pastReservations)&&const DeepCollectionEquality().equals(other._cancelledReservations, _cancelledReservations)&&(identical(other.error, error) || other.error == error)&&(identical(other.success, success) || other.success == success));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isCancelling,const DeepCollectionEquality().hash(_upcomingReservations),const DeepCollectionEquality().hash(_pastReservations),const DeepCollectionEquality().hash(_cancelledReservations),error,success);

@override
String toString() {
  return 'MyReservationsState(isLoading: $isLoading, isCancelling: $isCancelling, upcomingReservations: $upcomingReservations, pastReservations: $pastReservations, cancelledReservations: $cancelledReservations, error: $error, success: $success)';
}


}

/// @nodoc
abstract mixin class _$MyReservationsStateCopyWith<$Res> implements $MyReservationsStateCopyWith<$Res> {
  factory _$MyReservationsStateCopyWith(_MyReservationsState value, $Res Function(_MyReservationsState) _then) = __$MyReservationsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isCancelling, List<Reservation> upcomingReservations, List<Reservation> pastReservations, List<Reservation> cancelledReservations, String? error, String? success
});




}
/// @nodoc
class __$MyReservationsStateCopyWithImpl<$Res>
    implements _$MyReservationsStateCopyWith<$Res> {
  __$MyReservationsStateCopyWithImpl(this._self, this._then);

  final _MyReservationsState _self;
  final $Res Function(_MyReservationsState) _then;

/// Create a copy of MyReservationsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isCancelling = null,Object? upcomingReservations = null,Object? pastReservations = null,Object? cancelledReservations = null,Object? error = freezed,Object? success = freezed,}) {
  return _then(_MyReservationsState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isCancelling: null == isCancelling ? _self.isCancelling : isCancelling // ignore: cast_nullable_to_non_nullable
as bool,upcomingReservations: null == upcomingReservations ? _self._upcomingReservations : upcomingReservations // ignore: cast_nullable_to_non_nullable
as List<Reservation>,pastReservations: null == pastReservations ? _self._pastReservations : pastReservations // ignore: cast_nullable_to_non_nullable
as List<Reservation>,cancelledReservations: null == cancelledReservations ? _self._cancelledReservations : cancelledReservations // ignore: cast_nullable_to_non_nullable
as List<Reservation>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
