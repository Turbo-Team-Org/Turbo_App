// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_management_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ImageManagementState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageManagementState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ImageManagementState()';
}


}

/// @nodoc
class $ImageManagementStateCopyWith<$Res>  {
$ImageManagementStateCopyWith(ImageManagementState _, $Res Function(ImageManagementState) __);
}


/// Adds pattern-matching-related methods to [ImageManagementState].
extension ImageManagementStatePatterns on ImageManagementState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Initial value)?  initial,TResult Function( Loading value)?  loading,TResult Function( Compressed value)?  compressed,TResult Function( MultipleCompressed value)?  multipleCompressed,TResult Function( Uploaded value)?  uploaded,TResult Function( MultipleUploaded value)?  multipleUploaded,TResult Function( Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case Compressed() when compressed != null:
return compressed(_that);case MultipleCompressed() when multipleCompressed != null:
return multipleCompressed(_that);case Uploaded() when uploaded != null:
return uploaded(_that);case MultipleUploaded() when multipleUploaded != null:
return multipleUploaded(_that);case Error() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Initial value)  initial,required TResult Function( Loading value)  loading,required TResult Function( Compressed value)  compressed,required TResult Function( MultipleCompressed value)  multipleCompressed,required TResult Function( Uploaded value)  uploaded,required TResult Function( MultipleUploaded value)  multipleUploaded,required TResult Function( Error value)  error,}){
final _that = this;
switch (_that) {
case Initial():
return initial(_that);case Loading():
return loading(_that);case Compressed():
return compressed(_that);case MultipleCompressed():
return multipleCompressed(_that);case Uploaded():
return uploaded(_that);case MultipleUploaded():
return multipleUploaded(_that);case Error():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Initial value)?  initial,TResult? Function( Loading value)?  loading,TResult? Function( Compressed value)?  compressed,TResult? Function( MultipleCompressed value)?  multipleCompressed,TResult? Function( Uploaded value)?  uploaded,TResult? Function( MultipleUploaded value)?  multipleUploaded,TResult? Function( Error value)?  error,}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case Compressed() when compressed != null:
return compressed(_that);case MultipleCompressed() when multipleCompressed != null:
return multipleCompressed(_that);case Uploaded() when uploaded != null:
return uploaded(_that);case MultipleUploaded() when multipleUploaded != null:
return multipleUploaded(_that);case Error() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( ImageCompressionResult result)?  compressed,TResult Function( List<ImageCompressionResult> results)?  multipleCompressed,TResult Function( String url)?  uploaded,TResult Function( List<String> urls)?  multipleUploaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial();case Loading() when loading != null:
return loading();case Compressed() when compressed != null:
return compressed(_that.result);case MultipleCompressed() when multipleCompressed != null:
return multipleCompressed(_that.results);case Uploaded() when uploaded != null:
return uploaded(_that.url);case MultipleUploaded() when multipleUploaded != null:
return multipleUploaded(_that.urls);case Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( ImageCompressionResult result)  compressed,required TResult Function( List<ImageCompressionResult> results)  multipleCompressed,required TResult Function( String url)  uploaded,required TResult Function( List<String> urls)  multipleUploaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case Initial():
return initial();case Loading():
return loading();case Compressed():
return compressed(_that.result);case MultipleCompressed():
return multipleCompressed(_that.results);case Uploaded():
return uploaded(_that.url);case MultipleUploaded():
return multipleUploaded(_that.urls);case Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( ImageCompressionResult result)?  compressed,TResult? Function( List<ImageCompressionResult> results)?  multipleCompressed,TResult? Function( String url)?  uploaded,TResult? Function( List<String> urls)?  multipleUploaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial();case Loading() when loading != null:
return loading();case Compressed() when compressed != null:
return compressed(_that.result);case MultipleCompressed() when multipleCompressed != null:
return multipleCompressed(_that.results);case Uploaded() when uploaded != null:
return uploaded(_that.url);case MultipleUploaded() when multipleUploaded != null:
return multipleUploaded(_that.urls);case Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class Initial implements ImageManagementState {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ImageManagementState.initial()';
}


}




/// @nodoc


class Loading implements ImageManagementState {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ImageManagementState.loading()';
}


}




/// @nodoc


class Compressed implements ImageManagementState {
  const Compressed(this.result);
  

 final  ImageCompressionResult result;

/// Create a copy of ImageManagementState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompressedCopyWith<Compressed> get copyWith => _$CompressedCopyWithImpl<Compressed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Compressed&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,result);

@override
String toString() {
  return 'ImageManagementState.compressed(result: $result)';
}


}

/// @nodoc
abstract mixin class $CompressedCopyWith<$Res> implements $ImageManagementStateCopyWith<$Res> {
  factory $CompressedCopyWith(Compressed value, $Res Function(Compressed) _then) = _$CompressedCopyWithImpl;
@useResult
$Res call({
 ImageCompressionResult result
});


$ImageCompressionResultCopyWith<$Res> get result;

}
/// @nodoc
class _$CompressedCopyWithImpl<$Res>
    implements $CompressedCopyWith<$Res> {
  _$CompressedCopyWithImpl(this._self, this._then);

  final Compressed _self;
  final $Res Function(Compressed) _then;

/// Create a copy of ImageManagementState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? result = null,}) {
  return _then(Compressed(
null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as ImageCompressionResult,
  ));
}

/// Create a copy of ImageManagementState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ImageCompressionResultCopyWith<$Res> get result {
  
  return $ImageCompressionResultCopyWith<$Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}

/// @nodoc


class MultipleCompressed implements ImageManagementState {
  const MultipleCompressed(final  List<ImageCompressionResult> results): _results = results;
  

 final  List<ImageCompressionResult> _results;
 List<ImageCompressionResult> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}


/// Create a copy of ImageManagementState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MultipleCompressedCopyWith<MultipleCompressed> get copyWith => _$MultipleCompressedCopyWithImpl<MultipleCompressed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MultipleCompressed&&const DeepCollectionEquality().equals(other._results, _results));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_results));

@override
String toString() {
  return 'ImageManagementState.multipleCompressed(results: $results)';
}


}

/// @nodoc
abstract mixin class $MultipleCompressedCopyWith<$Res> implements $ImageManagementStateCopyWith<$Res> {
  factory $MultipleCompressedCopyWith(MultipleCompressed value, $Res Function(MultipleCompressed) _then) = _$MultipleCompressedCopyWithImpl;
@useResult
$Res call({
 List<ImageCompressionResult> results
});




}
/// @nodoc
class _$MultipleCompressedCopyWithImpl<$Res>
    implements $MultipleCompressedCopyWith<$Res> {
  _$MultipleCompressedCopyWithImpl(this._self, this._then);

  final MultipleCompressed _self;
  final $Res Function(MultipleCompressed) _then;

/// Create a copy of ImageManagementState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? results = null,}) {
  return _then(MultipleCompressed(
null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<ImageCompressionResult>,
  ));
}


}

/// @nodoc


class Uploaded implements ImageManagementState {
  const Uploaded(this.url);
  

 final  String url;

/// Create a copy of ImageManagementState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UploadedCopyWith<Uploaded> get copyWith => _$UploadedCopyWithImpl<Uploaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Uploaded&&(identical(other.url, url) || other.url == url));
}


@override
int get hashCode => Object.hash(runtimeType,url);

@override
String toString() {
  return 'ImageManagementState.uploaded(url: $url)';
}


}

/// @nodoc
abstract mixin class $UploadedCopyWith<$Res> implements $ImageManagementStateCopyWith<$Res> {
  factory $UploadedCopyWith(Uploaded value, $Res Function(Uploaded) _then) = _$UploadedCopyWithImpl;
@useResult
$Res call({
 String url
});




}
/// @nodoc
class _$UploadedCopyWithImpl<$Res>
    implements $UploadedCopyWith<$Res> {
  _$UploadedCopyWithImpl(this._self, this._then);

  final Uploaded _self;
  final $Res Function(Uploaded) _then;

/// Create a copy of ImageManagementState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? url = null,}) {
  return _then(Uploaded(
null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class MultipleUploaded implements ImageManagementState {
  const MultipleUploaded(final  List<String> urls): _urls = urls;
  

 final  List<String> _urls;
 List<String> get urls {
  if (_urls is EqualUnmodifiableListView) return _urls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_urls);
}


/// Create a copy of ImageManagementState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MultipleUploadedCopyWith<MultipleUploaded> get copyWith => _$MultipleUploadedCopyWithImpl<MultipleUploaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MultipleUploaded&&const DeepCollectionEquality().equals(other._urls, _urls));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_urls));

@override
String toString() {
  return 'ImageManagementState.multipleUploaded(urls: $urls)';
}


}

/// @nodoc
abstract mixin class $MultipleUploadedCopyWith<$Res> implements $ImageManagementStateCopyWith<$Res> {
  factory $MultipleUploadedCopyWith(MultipleUploaded value, $Res Function(MultipleUploaded) _then) = _$MultipleUploadedCopyWithImpl;
@useResult
$Res call({
 List<String> urls
});




}
/// @nodoc
class _$MultipleUploadedCopyWithImpl<$Res>
    implements $MultipleUploadedCopyWith<$Res> {
  _$MultipleUploadedCopyWithImpl(this._self, this._then);

  final MultipleUploaded _self;
  final $Res Function(MultipleUploaded) _then;

/// Create a copy of ImageManagementState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? urls = null,}) {
  return _then(MultipleUploaded(
null == urls ? _self._urls : urls // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc


class Error implements ImageManagementState {
  const Error(this.message);
  

 final  String message;

/// Create a copy of ImageManagementState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorCopyWith<Error> get copyWith => _$ErrorCopyWithImpl<Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ImageManagementState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorCopyWith<$Res> implements $ImageManagementStateCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) _then) = _$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ErrorCopyWithImpl<$Res>
    implements $ErrorCopyWith<$Res> {
  _$ErrorCopyWithImpl(this._self, this._then);

  final Error _self;
  final $Res Function(Error) _then;

/// Create a copy of ImageManagementState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
