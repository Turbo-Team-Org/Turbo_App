// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_filters_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SearchFiltersParams {

 double get minRating; double get maxDistance; String get sortBy; bool get showOnlyOpenNow; List<String> get selectedAmenities; double? get maxPrice; double? get minPrice; bool? get showOnlyWithReviews; bool? get showOnlyWithPhotos; bool? get showOnlyRecommended; int? get resultsLimit;
/// Create a copy of SearchFiltersParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchFiltersParamsCopyWith<SearchFiltersParams> get copyWith => _$SearchFiltersParamsCopyWithImpl<SearchFiltersParams>(this as SearchFiltersParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchFiltersParams&&(identical(other.minRating, minRating) || other.minRating == minRating)&&(identical(other.maxDistance, maxDistance) || other.maxDistance == maxDistance)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.showOnlyOpenNow, showOnlyOpenNow) || other.showOnlyOpenNow == showOnlyOpenNow)&&const DeepCollectionEquality().equals(other.selectedAmenities, selectedAmenities)&&(identical(other.maxPrice, maxPrice) || other.maxPrice == maxPrice)&&(identical(other.minPrice, minPrice) || other.minPrice == minPrice)&&(identical(other.showOnlyWithReviews, showOnlyWithReviews) || other.showOnlyWithReviews == showOnlyWithReviews)&&(identical(other.showOnlyWithPhotos, showOnlyWithPhotos) || other.showOnlyWithPhotos == showOnlyWithPhotos)&&(identical(other.showOnlyRecommended, showOnlyRecommended) || other.showOnlyRecommended == showOnlyRecommended)&&(identical(other.resultsLimit, resultsLimit) || other.resultsLimit == resultsLimit));
}


@override
int get hashCode => Object.hash(runtimeType,minRating,maxDistance,sortBy,showOnlyOpenNow,const DeepCollectionEquality().hash(selectedAmenities),maxPrice,minPrice,showOnlyWithReviews,showOnlyWithPhotos,showOnlyRecommended,resultsLimit);

@override
String toString() {
  return 'SearchFiltersParams(minRating: $minRating, maxDistance: $maxDistance, sortBy: $sortBy, showOnlyOpenNow: $showOnlyOpenNow, selectedAmenities: $selectedAmenities, maxPrice: $maxPrice, minPrice: $minPrice, showOnlyWithReviews: $showOnlyWithReviews, showOnlyWithPhotos: $showOnlyWithPhotos, showOnlyRecommended: $showOnlyRecommended, resultsLimit: $resultsLimit)';
}


}

/// @nodoc
abstract mixin class $SearchFiltersParamsCopyWith<$Res>  {
  factory $SearchFiltersParamsCopyWith(SearchFiltersParams value, $Res Function(SearchFiltersParams) _then) = _$SearchFiltersParamsCopyWithImpl;
@useResult
$Res call({
 double minRating, double maxDistance, String sortBy, bool showOnlyOpenNow, List<String> selectedAmenities, double? maxPrice, double? minPrice, bool? showOnlyWithReviews, bool? showOnlyWithPhotos, bool? showOnlyRecommended, int? resultsLimit
});




}
/// @nodoc
class _$SearchFiltersParamsCopyWithImpl<$Res>
    implements $SearchFiltersParamsCopyWith<$Res> {
  _$SearchFiltersParamsCopyWithImpl(this._self, this._then);

  final SearchFiltersParams _self;
  final $Res Function(SearchFiltersParams) _then;

/// Create a copy of SearchFiltersParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? minRating = null,Object? maxDistance = null,Object? sortBy = null,Object? showOnlyOpenNow = null,Object? selectedAmenities = null,Object? maxPrice = freezed,Object? minPrice = freezed,Object? showOnlyWithReviews = freezed,Object? showOnlyWithPhotos = freezed,Object? showOnlyRecommended = freezed,Object? resultsLimit = freezed,}) {
  return _then(_self.copyWith(
minRating: null == minRating ? _self.minRating : minRating // ignore: cast_nullable_to_non_nullable
as double,maxDistance: null == maxDistance ? _self.maxDistance : maxDistance // ignore: cast_nullable_to_non_nullable
as double,sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as String,showOnlyOpenNow: null == showOnlyOpenNow ? _self.showOnlyOpenNow : showOnlyOpenNow // ignore: cast_nullable_to_non_nullable
as bool,selectedAmenities: null == selectedAmenities ? _self.selectedAmenities : selectedAmenities // ignore: cast_nullable_to_non_nullable
as List<String>,maxPrice: freezed == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as double?,minPrice: freezed == minPrice ? _self.minPrice : minPrice // ignore: cast_nullable_to_non_nullable
as double?,showOnlyWithReviews: freezed == showOnlyWithReviews ? _self.showOnlyWithReviews : showOnlyWithReviews // ignore: cast_nullable_to_non_nullable
as bool?,showOnlyWithPhotos: freezed == showOnlyWithPhotos ? _self.showOnlyWithPhotos : showOnlyWithPhotos // ignore: cast_nullable_to_non_nullable
as bool?,showOnlyRecommended: freezed == showOnlyRecommended ? _self.showOnlyRecommended : showOnlyRecommended // ignore: cast_nullable_to_non_nullable
as bool?,resultsLimit: freezed == resultsLimit ? _self.resultsLimit : resultsLimit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchFiltersParams].
extension SearchFiltersParamsPatterns on SearchFiltersParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchFiltersParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchFiltersParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchFiltersParams value)  $default,){
final _that = this;
switch (_that) {
case _SearchFiltersParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchFiltersParams value)?  $default,){
final _that = this;
switch (_that) {
case _SearchFiltersParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double minRating,  double maxDistance,  String sortBy,  bool showOnlyOpenNow,  List<String> selectedAmenities,  double? maxPrice,  double? minPrice,  bool? showOnlyWithReviews,  bool? showOnlyWithPhotos,  bool? showOnlyRecommended,  int? resultsLimit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchFiltersParams() when $default != null:
return $default(_that.minRating,_that.maxDistance,_that.sortBy,_that.showOnlyOpenNow,_that.selectedAmenities,_that.maxPrice,_that.minPrice,_that.showOnlyWithReviews,_that.showOnlyWithPhotos,_that.showOnlyRecommended,_that.resultsLimit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double minRating,  double maxDistance,  String sortBy,  bool showOnlyOpenNow,  List<String> selectedAmenities,  double? maxPrice,  double? minPrice,  bool? showOnlyWithReviews,  bool? showOnlyWithPhotos,  bool? showOnlyRecommended,  int? resultsLimit)  $default,) {final _that = this;
switch (_that) {
case _SearchFiltersParams():
return $default(_that.minRating,_that.maxDistance,_that.sortBy,_that.showOnlyOpenNow,_that.selectedAmenities,_that.maxPrice,_that.minPrice,_that.showOnlyWithReviews,_that.showOnlyWithPhotos,_that.showOnlyRecommended,_that.resultsLimit);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double minRating,  double maxDistance,  String sortBy,  bool showOnlyOpenNow,  List<String> selectedAmenities,  double? maxPrice,  double? minPrice,  bool? showOnlyWithReviews,  bool? showOnlyWithPhotos,  bool? showOnlyRecommended,  int? resultsLimit)?  $default,) {final _that = this;
switch (_that) {
case _SearchFiltersParams() when $default != null:
return $default(_that.minRating,_that.maxDistance,_that.sortBy,_that.showOnlyOpenNow,_that.selectedAmenities,_that.maxPrice,_that.minPrice,_that.showOnlyWithReviews,_that.showOnlyWithPhotos,_that.showOnlyRecommended,_that.resultsLimit);case _:
  return null;

}
}

}

/// @nodoc


class _SearchFiltersParams implements SearchFiltersParams {
  const _SearchFiltersParams({this.minRating = 0.0, this.maxDistance = 5000.0, this.sortBy = 'distance', this.showOnlyOpenNow = false, final  List<String> selectedAmenities = const <String>[], this.maxPrice, this.minPrice, this.showOnlyWithReviews, this.showOnlyWithPhotos, this.showOnlyRecommended, this.resultsLimit}): _selectedAmenities = selectedAmenities;
  

@override@JsonKey() final  double minRating;
@override@JsonKey() final  double maxDistance;
@override@JsonKey() final  String sortBy;
@override@JsonKey() final  bool showOnlyOpenNow;
 final  List<String> _selectedAmenities;
@override@JsonKey() List<String> get selectedAmenities {
  if (_selectedAmenities is EqualUnmodifiableListView) return _selectedAmenities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedAmenities);
}

@override final  double? maxPrice;
@override final  double? minPrice;
@override final  bool? showOnlyWithReviews;
@override final  bool? showOnlyWithPhotos;
@override final  bool? showOnlyRecommended;
@override final  int? resultsLimit;

/// Create a copy of SearchFiltersParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchFiltersParamsCopyWith<_SearchFiltersParams> get copyWith => __$SearchFiltersParamsCopyWithImpl<_SearchFiltersParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchFiltersParams&&(identical(other.minRating, minRating) || other.minRating == minRating)&&(identical(other.maxDistance, maxDistance) || other.maxDistance == maxDistance)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.showOnlyOpenNow, showOnlyOpenNow) || other.showOnlyOpenNow == showOnlyOpenNow)&&const DeepCollectionEquality().equals(other._selectedAmenities, _selectedAmenities)&&(identical(other.maxPrice, maxPrice) || other.maxPrice == maxPrice)&&(identical(other.minPrice, minPrice) || other.minPrice == minPrice)&&(identical(other.showOnlyWithReviews, showOnlyWithReviews) || other.showOnlyWithReviews == showOnlyWithReviews)&&(identical(other.showOnlyWithPhotos, showOnlyWithPhotos) || other.showOnlyWithPhotos == showOnlyWithPhotos)&&(identical(other.showOnlyRecommended, showOnlyRecommended) || other.showOnlyRecommended == showOnlyRecommended)&&(identical(other.resultsLimit, resultsLimit) || other.resultsLimit == resultsLimit));
}


@override
int get hashCode => Object.hash(runtimeType,minRating,maxDistance,sortBy,showOnlyOpenNow,const DeepCollectionEquality().hash(_selectedAmenities),maxPrice,minPrice,showOnlyWithReviews,showOnlyWithPhotos,showOnlyRecommended,resultsLimit);

@override
String toString() {
  return 'SearchFiltersParams(minRating: $minRating, maxDistance: $maxDistance, sortBy: $sortBy, showOnlyOpenNow: $showOnlyOpenNow, selectedAmenities: $selectedAmenities, maxPrice: $maxPrice, minPrice: $minPrice, showOnlyWithReviews: $showOnlyWithReviews, showOnlyWithPhotos: $showOnlyWithPhotos, showOnlyRecommended: $showOnlyRecommended, resultsLimit: $resultsLimit)';
}


}

/// @nodoc
abstract mixin class _$SearchFiltersParamsCopyWith<$Res> implements $SearchFiltersParamsCopyWith<$Res> {
  factory _$SearchFiltersParamsCopyWith(_SearchFiltersParams value, $Res Function(_SearchFiltersParams) _then) = __$SearchFiltersParamsCopyWithImpl;
@override @useResult
$Res call({
 double minRating, double maxDistance, String sortBy, bool showOnlyOpenNow, List<String> selectedAmenities, double? maxPrice, double? minPrice, bool? showOnlyWithReviews, bool? showOnlyWithPhotos, bool? showOnlyRecommended, int? resultsLimit
});




}
/// @nodoc
class __$SearchFiltersParamsCopyWithImpl<$Res>
    implements _$SearchFiltersParamsCopyWith<$Res> {
  __$SearchFiltersParamsCopyWithImpl(this._self, this._then);

  final _SearchFiltersParams _self;
  final $Res Function(_SearchFiltersParams) _then;

/// Create a copy of SearchFiltersParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? minRating = null,Object? maxDistance = null,Object? sortBy = null,Object? showOnlyOpenNow = null,Object? selectedAmenities = null,Object? maxPrice = freezed,Object? minPrice = freezed,Object? showOnlyWithReviews = freezed,Object? showOnlyWithPhotos = freezed,Object? showOnlyRecommended = freezed,Object? resultsLimit = freezed,}) {
  return _then(_SearchFiltersParams(
minRating: null == minRating ? _self.minRating : minRating // ignore: cast_nullable_to_non_nullable
as double,maxDistance: null == maxDistance ? _self.maxDistance : maxDistance // ignore: cast_nullable_to_non_nullable
as double,sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as String,showOnlyOpenNow: null == showOnlyOpenNow ? _self.showOnlyOpenNow : showOnlyOpenNow // ignore: cast_nullable_to_non_nullable
as bool,selectedAmenities: null == selectedAmenities ? _self._selectedAmenities : selectedAmenities // ignore: cast_nullable_to_non_nullable
as List<String>,maxPrice: freezed == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as double?,minPrice: freezed == minPrice ? _self.minPrice : minPrice // ignore: cast_nullable_to_non_nullable
as double?,showOnlyWithReviews: freezed == showOnlyWithReviews ? _self.showOnlyWithReviews : showOnlyWithReviews // ignore: cast_nullable_to_non_nullable
as bool?,showOnlyWithPhotos: freezed == showOnlyWithPhotos ? _self.showOnlyWithPhotos : showOnlyWithPhotos // ignore: cast_nullable_to_non_nullable
as bool?,showOnlyRecommended: freezed == showOnlyRecommended ? _self.showOnlyRecommended : showOnlyRecommended // ignore: cast_nullable_to_non_nullable
as bool?,resultsLimit: freezed == resultsLimit ? _self.resultsLimit : resultsLimit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
