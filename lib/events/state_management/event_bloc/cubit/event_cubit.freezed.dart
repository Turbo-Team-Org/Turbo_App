// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EventState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EventState()';
}


}

/// @nodoc
class $EventStateCopyWith<$Res>  {
$EventStateCopyWith(EventState _, $Res Function(EventState) __);
}


/// @nodoc


class EventInitial implements EventState {
  const EventInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EventState.initial()';
}


}




/// @nodoc


class EventLoading implements EventState {
  const EventLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EventState.loading()';
}


}




/// @nodoc


class EventLoaded implements EventState {
  const EventLoaded({required final  List<Event> events}): _events = events;
  

 final  List<Event> _events;
 List<Event> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}


/// Create a copy of EventState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventLoadedCopyWith<EventLoaded> get copyWith => _$EventLoadedCopyWithImpl<EventLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventLoaded&&const DeepCollectionEquality().equals(other._events, _events));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_events));

@override
String toString() {
  return 'EventState.loaded(events: $events)';
}


}

/// @nodoc
abstract mixin class $EventLoadedCopyWith<$Res> implements $EventStateCopyWith<$Res> {
  factory $EventLoadedCopyWith(EventLoaded value, $Res Function(EventLoaded) _then) = _$EventLoadedCopyWithImpl;
@useResult
$Res call({
 List<Event> events
});




}
/// @nodoc
class _$EventLoadedCopyWithImpl<$Res>
    implements $EventLoadedCopyWith<$Res> {
  _$EventLoadedCopyWithImpl(this._self, this._then);

  final EventLoaded _self;
  final $Res Function(EventLoaded) _then;

/// Create a copy of EventState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? events = null,}) {
  return _then(EventLoaded(
events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<Event>,
  ));
}


}

/// @nodoc


class EventError implements EventState {
  const EventError(this.message);
  

 final  String message;

/// Create a copy of EventState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventErrorCopyWith<EventError> get copyWith => _$EventErrorCopyWithImpl<EventError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'EventState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $EventErrorCopyWith<$Res> implements $EventStateCopyWith<$Res> {
  factory $EventErrorCopyWith(EventError value, $Res Function(EventError) _then) = _$EventErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$EventErrorCopyWithImpl<$Res>
    implements $EventErrorCopyWith<$Res> {
  _$EventErrorCopyWithImpl(this._self, this._then);

  final EventError _self;
  final $Res Function(EventError) _then;

/// Create a copy of EventState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(EventError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class TodayEventsLoaded implements EventState {
  const TodayEventsLoaded({required final  List<Event> events}): _events = events;
  

 final  List<Event> _events;
 List<Event> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}


/// Create a copy of EventState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodayEventsLoadedCopyWith<TodayEventsLoaded> get copyWith => _$TodayEventsLoadedCopyWithImpl<TodayEventsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodayEventsLoaded&&const DeepCollectionEquality().equals(other._events, _events));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_events));

@override
String toString() {
  return 'EventState.todayEventsLoaded(events: $events)';
}


}

/// @nodoc
abstract mixin class $TodayEventsLoadedCopyWith<$Res> implements $EventStateCopyWith<$Res> {
  factory $TodayEventsLoadedCopyWith(TodayEventsLoaded value, $Res Function(TodayEventsLoaded) _then) = _$TodayEventsLoadedCopyWithImpl;
@useResult
$Res call({
 List<Event> events
});




}
/// @nodoc
class _$TodayEventsLoadedCopyWithImpl<$Res>
    implements $TodayEventsLoadedCopyWith<$Res> {
  _$TodayEventsLoadedCopyWithImpl(this._self, this._then);

  final TodayEventsLoaded _self;
  final $Res Function(TodayEventsLoaded) _then;

/// Create a copy of EventState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? events = null,}) {
  return _then(TodayEventsLoaded(
events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<Event>,
  ));
}


}

// dart format on
