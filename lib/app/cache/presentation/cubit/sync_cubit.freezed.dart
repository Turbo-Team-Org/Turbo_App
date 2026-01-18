// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SyncState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SyncState()';
}


}

/// @nodoc
class $SyncStateCopyWith<$Res>  {
$SyncStateCopyWith(SyncState _, $Res Function(SyncState) __);
}


/// @nodoc


class SyncInitial implements SyncState {
  const SyncInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SyncState.initial()';
}


}




/// @nodoc


class SyncSyncing implements SyncState {
  const SyncSyncing({required this.message, required this.progress});
  

 final  String message;
 final  double progress;

/// Create a copy of SyncState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncSyncingCopyWith<SyncSyncing> get copyWith => _$SyncSyncingCopyWithImpl<SyncSyncing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncSyncing&&(identical(other.message, message) || other.message == message)&&(identical(other.progress, progress) || other.progress == progress));
}


@override
int get hashCode => Object.hash(runtimeType,message,progress);

@override
String toString() {
  return 'SyncState.syncing(message: $message, progress: $progress)';
}


}

/// @nodoc
abstract mixin class $SyncSyncingCopyWith<$Res> implements $SyncStateCopyWith<$Res> {
  factory $SyncSyncingCopyWith(SyncSyncing value, $Res Function(SyncSyncing) _then) = _$SyncSyncingCopyWithImpl;
@useResult
$Res call({
 String message, double progress
});




}
/// @nodoc
class _$SyncSyncingCopyWithImpl<$Res>
    implements $SyncSyncingCopyWith<$Res> {
  _$SyncSyncingCopyWithImpl(this._self, this._then);

  final SyncSyncing _self;
  final $Res Function(SyncSyncing) _then;

/// Create a copy of SyncState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? progress = null,}) {
  return _then(SyncSyncing(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class SyncCompleted implements SyncState {
  const SyncCompleted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncCompleted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SyncState.completed()';
}


}




/// @nodoc


class SyncError implements SyncState {
  const SyncError({required this.message});
  

 final  String message;

/// Create a copy of SyncState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncErrorCopyWith<SyncError> get copyWith => _$SyncErrorCopyWithImpl<SyncError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SyncState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $SyncErrorCopyWith<$Res> implements $SyncStateCopyWith<$Res> {
  factory $SyncErrorCopyWith(SyncError value, $Res Function(SyncError) _then) = _$SyncErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SyncErrorCopyWithImpl<$Res>
    implements $SyncErrorCopyWith<$Res> {
  _$SyncErrorCopyWithImpl(this._self, this._then);

  final SyncError _self;
  final $Res Function(SyncError) _then;

/// Create a copy of SyncState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SyncError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
