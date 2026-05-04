// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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


/// Adds pattern-matching-related methods to [SyncState].
extension SyncStatePatterns on SyncState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SyncInitial value)?  initial,TResult Function( SyncSyncing value)?  syncing,TResult Function( SyncCompleted value)?  completed,TResult Function( SyncError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SyncInitial() when initial != null:
return initial(_that);case SyncSyncing() when syncing != null:
return syncing(_that);case SyncCompleted() when completed != null:
return completed(_that);case SyncError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SyncInitial value)  initial,required TResult Function( SyncSyncing value)  syncing,required TResult Function( SyncCompleted value)  completed,required TResult Function( SyncError value)  error,}){
final _that = this;
switch (_that) {
case SyncInitial():
return initial(_that);case SyncSyncing():
return syncing(_that);case SyncCompleted():
return completed(_that);case SyncError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SyncInitial value)?  initial,TResult? Function( SyncSyncing value)?  syncing,TResult? Function( SyncCompleted value)?  completed,TResult? Function( SyncError value)?  error,}){
final _that = this;
switch (_that) {
case SyncInitial() when initial != null:
return initial(_that);case SyncSyncing() when syncing != null:
return syncing(_that);case SyncCompleted() when completed != null:
return completed(_that);case SyncError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( String message,  double progress)?  syncing,TResult Function()?  completed,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SyncInitial() when initial != null:
return initial();case SyncSyncing() when syncing != null:
return syncing(_that.message,_that.progress);case SyncCompleted() when completed != null:
return completed();case SyncError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( String message,  double progress)  syncing,required TResult Function()  completed,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case SyncInitial():
return initial();case SyncSyncing():
return syncing(_that.message,_that.progress);case SyncCompleted():
return completed();case SyncError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( String message,  double progress)?  syncing,TResult? Function()?  completed,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case SyncInitial() when initial != null:
return initial();case SyncSyncing() when syncing != null:
return syncing(_that.message,_that.progress);case SyncCompleted() when completed != null:
return completed();case SyncError() when error != null:
return error(_that.message);case _:
  return null;

}
}

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
