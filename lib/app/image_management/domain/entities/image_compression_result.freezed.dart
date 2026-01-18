// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_compression_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ImageCompressionResult {

 File get compressedFile; int get originalSize; int get compressedSize; double get compressionRatio;
/// Create a copy of ImageCompressionResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageCompressionResultCopyWith<ImageCompressionResult> get copyWith => _$ImageCompressionResultCopyWithImpl<ImageCompressionResult>(this as ImageCompressionResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageCompressionResult&&(identical(other.compressedFile, compressedFile) || other.compressedFile == compressedFile)&&(identical(other.originalSize, originalSize) || other.originalSize == originalSize)&&(identical(other.compressedSize, compressedSize) || other.compressedSize == compressedSize)&&(identical(other.compressionRatio, compressionRatio) || other.compressionRatio == compressionRatio));
}


@override
int get hashCode => Object.hash(runtimeType,compressedFile,originalSize,compressedSize,compressionRatio);

@override
String toString() {
  return 'ImageCompressionResult(compressedFile: $compressedFile, originalSize: $originalSize, compressedSize: $compressedSize, compressionRatio: $compressionRatio)';
}


}

/// @nodoc
abstract mixin class $ImageCompressionResultCopyWith<$Res>  {
  factory $ImageCompressionResultCopyWith(ImageCompressionResult value, $Res Function(ImageCompressionResult) _then) = _$ImageCompressionResultCopyWithImpl;
@useResult
$Res call({
 File compressedFile, int originalSize, int compressedSize, double compressionRatio
});




}
/// @nodoc
class _$ImageCompressionResultCopyWithImpl<$Res>
    implements $ImageCompressionResultCopyWith<$Res> {
  _$ImageCompressionResultCopyWithImpl(this._self, this._then);

  final ImageCompressionResult _self;
  final $Res Function(ImageCompressionResult) _then;

/// Create a copy of ImageCompressionResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? compressedFile = null,Object? originalSize = null,Object? compressedSize = null,Object? compressionRatio = null,}) {
  return _then(_self.copyWith(
compressedFile: null == compressedFile ? _self.compressedFile : compressedFile // ignore: cast_nullable_to_non_nullable
as File,originalSize: null == originalSize ? _self.originalSize : originalSize // ignore: cast_nullable_to_non_nullable
as int,compressedSize: null == compressedSize ? _self.compressedSize : compressedSize // ignore: cast_nullable_to_non_nullable
as int,compressionRatio: null == compressionRatio ? _self.compressionRatio : compressionRatio // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// @nodoc


class _ImageCompressionResult implements ImageCompressionResult {
  const _ImageCompressionResult({required this.compressedFile, required this.originalSize, required this.compressedSize, required this.compressionRatio});
  

@override final  File compressedFile;
@override final  int originalSize;
@override final  int compressedSize;
@override final  double compressionRatio;

/// Create a copy of ImageCompressionResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImageCompressionResultCopyWith<_ImageCompressionResult> get copyWith => __$ImageCompressionResultCopyWithImpl<_ImageCompressionResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImageCompressionResult&&(identical(other.compressedFile, compressedFile) || other.compressedFile == compressedFile)&&(identical(other.originalSize, originalSize) || other.originalSize == originalSize)&&(identical(other.compressedSize, compressedSize) || other.compressedSize == compressedSize)&&(identical(other.compressionRatio, compressionRatio) || other.compressionRatio == compressionRatio));
}


@override
int get hashCode => Object.hash(runtimeType,compressedFile,originalSize,compressedSize,compressionRatio);

@override
String toString() {
  return 'ImageCompressionResult(compressedFile: $compressedFile, originalSize: $originalSize, compressedSize: $compressedSize, compressionRatio: $compressionRatio)';
}


}

/// @nodoc
abstract mixin class _$ImageCompressionResultCopyWith<$Res> implements $ImageCompressionResultCopyWith<$Res> {
  factory _$ImageCompressionResultCopyWith(_ImageCompressionResult value, $Res Function(_ImageCompressionResult) _then) = __$ImageCompressionResultCopyWithImpl;
@override @useResult
$Res call({
 File compressedFile, int originalSize, int compressedSize, double compressionRatio
});




}
/// @nodoc
class __$ImageCompressionResultCopyWithImpl<$Res>
    implements _$ImageCompressionResultCopyWith<$Res> {
  __$ImageCompressionResultCopyWithImpl(this._self, this._then);

  final _ImageCompressionResult _self;
  final $Res Function(_ImageCompressionResult) _then;

/// Create a copy of ImageCompressionResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? compressedFile = null,Object? originalSize = null,Object? compressedSize = null,Object? compressionRatio = null,}) {
  return _then(_ImageCompressionResult(
compressedFile: null == compressedFile ? _self.compressedFile : compressedFile // ignore: cast_nullable_to_non_nullable
as File,originalSize: null == originalSize ? _self.originalSize : originalSize // ignore: cast_nullable_to_non_nullable
as int,compressedSize: null == compressedSize ? _self.compressedSize : compressedSize // ignore: cast_nullable_to_non_nullable
as int,compressionRatio: null == compressionRatio ? _self.compressionRatio : compressionRatio // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
