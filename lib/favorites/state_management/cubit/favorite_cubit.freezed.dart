// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FavoriteState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FavoriteState()';
}


}

/// @nodoc
class $FavoriteStateCopyWith<$Res>  {
$FavoriteStateCopyWith(FavoriteState _, $Res Function(FavoriteState) __);
}


/// @nodoc


class FavoriteInitial implements FavoriteState {
  const FavoriteInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FavoriteState.initial()';
}


}




/// @nodoc


class FavoriteLoading implements FavoriteState {
  const FavoriteLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FavoriteState.loading()';
}


}




/// @nodoc


class FavoriteLoaded implements FavoriteState {
  const FavoriteLoaded(final  List<Favorite> favorites): _favorites = favorites;
  

 final  List<Favorite> _favorites;
 List<Favorite> get favorites {
  if (_favorites is EqualUnmodifiableListView) return _favorites;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_favorites);
}


/// Create a copy of FavoriteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoriteLoadedCopyWith<FavoriteLoaded> get copyWith => _$FavoriteLoadedCopyWithImpl<FavoriteLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteLoaded&&const DeepCollectionEquality().equals(other._favorites, _favorites));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_favorites));

@override
String toString() {
  return 'FavoriteState.loaded(favorites: $favorites)';
}


}

/// @nodoc
abstract mixin class $FavoriteLoadedCopyWith<$Res> implements $FavoriteStateCopyWith<$Res> {
  factory $FavoriteLoadedCopyWith(FavoriteLoaded value, $Res Function(FavoriteLoaded) _then) = _$FavoriteLoadedCopyWithImpl;
@useResult
$Res call({
 List<Favorite> favorites
});




}
/// @nodoc
class _$FavoriteLoadedCopyWithImpl<$Res>
    implements $FavoriteLoadedCopyWith<$Res> {
  _$FavoriteLoadedCopyWithImpl(this._self, this._then);

  final FavoriteLoaded _self;
  final $Res Function(FavoriteLoaded) _then;

/// Create a copy of FavoriteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? favorites = null,}) {
  return _then(FavoriteLoaded(
null == favorites ? _self._favorites : favorites // ignore: cast_nullable_to_non_nullable
as List<Favorite>,
  ));
}


}

/// @nodoc


class FavoriteError implements FavoriteState {
  const FavoriteError(this.message);
  

 final  String message;

/// Create a copy of FavoriteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoriteErrorCopyWith<FavoriteError> get copyWith => _$FavoriteErrorCopyWithImpl<FavoriteError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'FavoriteState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $FavoriteErrorCopyWith<$Res> implements $FavoriteStateCopyWith<$Res> {
  factory $FavoriteErrorCopyWith(FavoriteError value, $Res Function(FavoriteError) _then) = _$FavoriteErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$FavoriteErrorCopyWithImpl<$Res>
    implements $FavoriteErrorCopyWith<$Res> {
  _$FavoriteErrorCopyWithImpl(this._self, this._then);

  final FavoriteError _self;
  final $Res Function(FavoriteError) _then;

/// Create a copy of FavoriteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(FavoriteError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
