// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReviewState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReviewState()';
}


}

/// @nodoc
class $ReviewStateCopyWith<$Res>  {
$ReviewStateCopyWith(ReviewState _, $Res Function(ReviewState) __);
}


/// Adds pattern-matching-related methods to [ReviewState].
extension ReviewStatePatterns on ReviewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ReviewInitial value)?  initial,TResult Function( ReviewLoading value)?  loading,TResult Function( ReviewLoaded value)?  loaded,TResult Function( ReviewError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ReviewInitial() when initial != null:
return initial(_that);case ReviewLoading() when loading != null:
return loading(_that);case ReviewLoaded() when loaded != null:
return loaded(_that);case ReviewError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ReviewInitial value)  initial,required TResult Function( ReviewLoading value)  loading,required TResult Function( ReviewLoaded value)  loaded,required TResult Function( ReviewError value)  error,}){
final _that = this;
switch (_that) {
case ReviewInitial():
return initial(_that);case ReviewLoading():
return loading(_that);case ReviewLoaded():
return loaded(_that);case ReviewError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ReviewInitial value)?  initial,TResult? Function( ReviewLoading value)?  loading,TResult? Function( ReviewLoaded value)?  loaded,TResult? Function( ReviewError value)?  error,}){
final _that = this;
switch (_that) {
case ReviewInitial() when initial != null:
return initial(_that);case ReviewLoading() when loading != null:
return loading(_that);case ReviewLoaded() when loaded != null:
return loaded(_that);case ReviewError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Review> reviews)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ReviewInitial() when initial != null:
return initial();case ReviewLoading() when loading != null:
return loading();case ReviewLoaded() when loaded != null:
return loaded(_that.reviews);case ReviewError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Review> reviews)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case ReviewInitial():
return initial();case ReviewLoading():
return loading();case ReviewLoaded():
return loaded(_that.reviews);case ReviewError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Review> reviews)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case ReviewInitial() when initial != null:
return initial();case ReviewLoading() when loading != null:
return loading();case ReviewLoaded() when loaded != null:
return loaded(_that.reviews);case ReviewError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ReviewInitial implements ReviewState {
  const ReviewInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReviewState.initial()';
}


}




/// @nodoc


class ReviewLoading implements ReviewState {
  const ReviewLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReviewState.loading()';
}


}




/// @nodoc


class ReviewLoaded implements ReviewState {
  const ReviewLoaded(final  List<Review> reviews): _reviews = reviews;
  

 final  List<Review> _reviews;
 List<Review> get reviews {
  if (_reviews is EqualUnmodifiableListView) return _reviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reviews);
}


/// Create a copy of ReviewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewLoadedCopyWith<ReviewLoaded> get copyWith => _$ReviewLoadedCopyWithImpl<ReviewLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewLoaded&&const DeepCollectionEquality().equals(other._reviews, _reviews));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_reviews));

@override
String toString() {
  return 'ReviewState.loaded(reviews: $reviews)';
}


}

/// @nodoc
abstract mixin class $ReviewLoadedCopyWith<$Res> implements $ReviewStateCopyWith<$Res> {
  factory $ReviewLoadedCopyWith(ReviewLoaded value, $Res Function(ReviewLoaded) _then) = _$ReviewLoadedCopyWithImpl;
@useResult
$Res call({
 List<Review> reviews
});




}
/// @nodoc
class _$ReviewLoadedCopyWithImpl<$Res>
    implements $ReviewLoadedCopyWith<$Res> {
  _$ReviewLoadedCopyWithImpl(this._self, this._then);

  final ReviewLoaded _self;
  final $Res Function(ReviewLoaded) _then;

/// Create a copy of ReviewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reviews = null,}) {
  return _then(ReviewLoaded(
null == reviews ? _self._reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<Review>,
  ));
}


}

/// @nodoc


class ReviewError implements ReviewState {
  const ReviewError(this.message);
  

 final  String message;

/// Create a copy of ReviewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewErrorCopyWith<ReviewError> get copyWith => _$ReviewErrorCopyWithImpl<ReviewError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ReviewState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ReviewErrorCopyWith<$Res> implements $ReviewStateCopyWith<$Res> {
  factory $ReviewErrorCopyWith(ReviewError value, $Res Function(ReviewError) _then) = _$ReviewErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ReviewErrorCopyWithImpl<$Res>
    implements $ReviewErrorCopyWith<$Res> {
  _$ReviewErrorCopyWithImpl(this._self, this._then);

  final ReviewError _self;
  final $Res Function(ReviewError) _then;

/// Create a copy of ReviewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ReviewError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
