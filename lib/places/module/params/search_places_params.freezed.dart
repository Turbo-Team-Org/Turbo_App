// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_places_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SearchPlacesParams {

 String get query; LatLng? get location; double? get maxDistance; double? get minRating; double? get maxPrice; double? get minPrice; String? get categoryId;
/// Create a copy of SearchPlacesParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchPlacesParamsCopyWith<SearchPlacesParams> get copyWith => _$SearchPlacesParamsCopyWithImpl<SearchPlacesParams>(this as SearchPlacesParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchPlacesParams&&(identical(other.query, query) || other.query == query)&&(identical(other.location, location) || other.location == location)&&(identical(other.maxDistance, maxDistance) || other.maxDistance == maxDistance)&&(identical(other.minRating, minRating) || other.minRating == minRating)&&(identical(other.maxPrice, maxPrice) || other.maxPrice == maxPrice)&&(identical(other.minPrice, minPrice) || other.minPrice == minPrice)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId));
}


@override
int get hashCode => Object.hash(runtimeType,query,location,maxDistance,minRating,maxPrice,minPrice,categoryId);

@override
String toString() {
  return 'SearchPlacesParams(query: $query, location: $location, maxDistance: $maxDistance, minRating: $minRating, maxPrice: $maxPrice, minPrice: $minPrice, categoryId: $categoryId)';
}


}

/// @nodoc
abstract mixin class $SearchPlacesParamsCopyWith<$Res>  {
  factory $SearchPlacesParamsCopyWith(SearchPlacesParams value, $Res Function(SearchPlacesParams) _then) = _$SearchPlacesParamsCopyWithImpl;
@useResult
$Res call({
 String query, LatLng? location, double? maxDistance, double? minRating, double? maxPrice, double? minPrice, String? categoryId
});




}
/// @nodoc
class _$SearchPlacesParamsCopyWithImpl<$Res>
    implements $SearchPlacesParamsCopyWith<$Res> {
  _$SearchPlacesParamsCopyWithImpl(this._self, this._then);

  final SearchPlacesParams _self;
  final $Res Function(SearchPlacesParams) _then;

/// Create a copy of SearchPlacesParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? location = freezed,Object? maxDistance = freezed,Object? minRating = freezed,Object? maxPrice = freezed,Object? minPrice = freezed,Object? categoryId = freezed,}) {
  return _then(_self.copyWith(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng?,maxDistance: freezed == maxDistance ? _self.maxDistance : maxDistance // ignore: cast_nullable_to_non_nullable
as double?,minRating: freezed == minRating ? _self.minRating : minRating // ignore: cast_nullable_to_non_nullable
as double?,maxPrice: freezed == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as double?,minPrice: freezed == minPrice ? _self.minPrice : minPrice // ignore: cast_nullable_to_non_nullable
as double?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _SearchPlacesParams implements SearchPlacesParams {
  const _SearchPlacesParams({required this.query, this.location, this.maxDistance, this.minRating, this.maxPrice, this.minPrice, this.categoryId});
  

@override final  String query;
@override final  LatLng? location;
@override final  double? maxDistance;
@override final  double? minRating;
@override final  double? maxPrice;
@override final  double? minPrice;
@override final  String? categoryId;

/// Create a copy of SearchPlacesParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchPlacesParamsCopyWith<_SearchPlacesParams> get copyWith => __$SearchPlacesParamsCopyWithImpl<_SearchPlacesParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchPlacesParams&&(identical(other.query, query) || other.query == query)&&(identical(other.location, location) || other.location == location)&&(identical(other.maxDistance, maxDistance) || other.maxDistance == maxDistance)&&(identical(other.minRating, minRating) || other.minRating == minRating)&&(identical(other.maxPrice, maxPrice) || other.maxPrice == maxPrice)&&(identical(other.minPrice, minPrice) || other.minPrice == minPrice)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId));
}


@override
int get hashCode => Object.hash(runtimeType,query,location,maxDistance,minRating,maxPrice,minPrice,categoryId);

@override
String toString() {
  return 'SearchPlacesParams(query: $query, location: $location, maxDistance: $maxDistance, minRating: $minRating, maxPrice: $maxPrice, minPrice: $minPrice, categoryId: $categoryId)';
}


}

/// @nodoc
abstract mixin class _$SearchPlacesParamsCopyWith<$Res> implements $SearchPlacesParamsCopyWith<$Res> {
  factory _$SearchPlacesParamsCopyWith(_SearchPlacesParams value, $Res Function(_SearchPlacesParams) _then) = __$SearchPlacesParamsCopyWithImpl;
@override @useResult
$Res call({
 String query, LatLng? location, double? maxDistance, double? minRating, double? maxPrice, double? minPrice, String? categoryId
});




}
/// @nodoc
class __$SearchPlacesParamsCopyWithImpl<$Res>
    implements _$SearchPlacesParamsCopyWith<$Res> {
  __$SearchPlacesParamsCopyWithImpl(this._self, this._then);

  final _SearchPlacesParams _self;
  final $Res Function(_SearchPlacesParams) _then;

/// Create a copy of SearchPlacesParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? location = freezed,Object? maxDistance = freezed,Object? minRating = freezed,Object? maxPrice = freezed,Object? minPrice = freezed,Object? categoryId = freezed,}) {
  return _then(_SearchPlacesParams(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng?,maxDistance: freezed == maxDistance ? _self.maxDistance : maxDistance // ignore: cast_nullable_to_non_nullable
as double?,minRating: freezed == minRating ? _self.minRating : minRating // ignore: cast_nullable_to_non_nullable
as double?,maxPrice: freezed == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as double?,minPrice: freezed == minPrice ? _self.minPrice : minPrice // ignore: cast_nullable_to_non_nullable
as double?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$GetPlacesByLocationParams {

 LatLng get location; double get radius; double? get minRating; double? get maxPrice; double? get minPrice; String? get categoryId; int get limit; String get sortBy;
/// Create a copy of GetPlacesByLocationParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetPlacesByLocationParamsCopyWith<GetPlacesByLocationParams> get copyWith => _$GetPlacesByLocationParamsCopyWithImpl<GetPlacesByLocationParams>(this as GetPlacesByLocationParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetPlacesByLocationParams&&(identical(other.location, location) || other.location == location)&&(identical(other.radius, radius) || other.radius == radius)&&(identical(other.minRating, minRating) || other.minRating == minRating)&&(identical(other.maxPrice, maxPrice) || other.maxPrice == maxPrice)&&(identical(other.minPrice, minPrice) || other.minPrice == minPrice)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy));
}


@override
int get hashCode => Object.hash(runtimeType,location,radius,minRating,maxPrice,minPrice,categoryId,limit,sortBy);

@override
String toString() {
  return 'GetPlacesByLocationParams(location: $location, radius: $radius, minRating: $minRating, maxPrice: $maxPrice, minPrice: $minPrice, categoryId: $categoryId, limit: $limit, sortBy: $sortBy)';
}


}

/// @nodoc
abstract mixin class $GetPlacesByLocationParamsCopyWith<$Res>  {
  factory $GetPlacesByLocationParamsCopyWith(GetPlacesByLocationParams value, $Res Function(GetPlacesByLocationParams) _then) = _$GetPlacesByLocationParamsCopyWithImpl;
@useResult
$Res call({
 LatLng location, double radius, double? minRating, double? maxPrice, double? minPrice, String? categoryId, int limit, String sortBy
});




}
/// @nodoc
class _$GetPlacesByLocationParamsCopyWithImpl<$Res>
    implements $GetPlacesByLocationParamsCopyWith<$Res> {
  _$GetPlacesByLocationParamsCopyWithImpl(this._self, this._then);

  final GetPlacesByLocationParams _self;
  final $Res Function(GetPlacesByLocationParams) _then;

/// Create a copy of GetPlacesByLocationParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? location = null,Object? radius = null,Object? minRating = freezed,Object? maxPrice = freezed,Object? minPrice = freezed,Object? categoryId = freezed,Object? limit = null,Object? sortBy = null,}) {
  return _then(_self.copyWith(
location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as double,minRating: freezed == minRating ? _self.minRating : minRating // ignore: cast_nullable_to_non_nullable
as double?,maxPrice: freezed == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as double?,minPrice: freezed == minPrice ? _self.minPrice : minPrice // ignore: cast_nullable_to_non_nullable
as double?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class _GetPlacesByLocationParams implements GetPlacesByLocationParams {
  const _GetPlacesByLocationParams({required this.location, this.radius = 5000.0, this.minRating, this.maxPrice, this.minPrice, this.categoryId, this.limit = 20, this.sortBy = 'distance'});
  

@override final  LatLng location;
@override@JsonKey() final  double radius;
@override final  double? minRating;
@override final  double? maxPrice;
@override final  double? minPrice;
@override final  String? categoryId;
@override@JsonKey() final  int limit;
@override@JsonKey() final  String sortBy;

/// Create a copy of GetPlacesByLocationParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetPlacesByLocationParamsCopyWith<_GetPlacesByLocationParams> get copyWith => __$GetPlacesByLocationParamsCopyWithImpl<_GetPlacesByLocationParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetPlacesByLocationParams&&(identical(other.location, location) || other.location == location)&&(identical(other.radius, radius) || other.radius == radius)&&(identical(other.minRating, minRating) || other.minRating == minRating)&&(identical(other.maxPrice, maxPrice) || other.maxPrice == maxPrice)&&(identical(other.minPrice, minPrice) || other.minPrice == minPrice)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy));
}


@override
int get hashCode => Object.hash(runtimeType,location,radius,minRating,maxPrice,minPrice,categoryId,limit,sortBy);

@override
String toString() {
  return 'GetPlacesByLocationParams(location: $location, radius: $radius, minRating: $minRating, maxPrice: $maxPrice, minPrice: $minPrice, categoryId: $categoryId, limit: $limit, sortBy: $sortBy)';
}


}

/// @nodoc
abstract mixin class _$GetPlacesByLocationParamsCopyWith<$Res> implements $GetPlacesByLocationParamsCopyWith<$Res> {
  factory _$GetPlacesByLocationParamsCopyWith(_GetPlacesByLocationParams value, $Res Function(_GetPlacesByLocationParams) _then) = __$GetPlacesByLocationParamsCopyWithImpl;
@override @useResult
$Res call({
 LatLng location, double radius, double? minRating, double? maxPrice, double? minPrice, String? categoryId, int limit, String sortBy
});




}
/// @nodoc
class __$GetPlacesByLocationParamsCopyWithImpl<$Res>
    implements _$GetPlacesByLocationParamsCopyWith<$Res> {
  __$GetPlacesByLocationParamsCopyWithImpl(this._self, this._then);

  final _GetPlacesByLocationParams _self;
  final $Res Function(_GetPlacesByLocationParams) _then;

/// Create a copy of GetPlacesByLocationParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? location = null,Object? radius = null,Object? minRating = freezed,Object? maxPrice = freezed,Object? minPrice = freezed,Object? categoryId = freezed,Object? limit = null,Object? sortBy = null,}) {
  return _then(_GetPlacesByLocationParams(
location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as double,minRating: freezed == minRating ? _self.minRating : minRating // ignore: cast_nullable_to_non_nullable
as double?,maxPrice: freezed == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as double?,minPrice: freezed == minPrice ? _self.minPrice : minPrice // ignore: cast_nullable_to_non_nullable
as double?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$SearchNearbyPlacesParams {

 LatLng get location; double get radius; String? get keyword; String? get categoryId; double? get minRating; int get limit;
/// Create a copy of SearchNearbyPlacesParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchNearbyPlacesParamsCopyWith<SearchNearbyPlacesParams> get copyWith => _$SearchNearbyPlacesParamsCopyWithImpl<SearchNearbyPlacesParams>(this as SearchNearbyPlacesParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchNearbyPlacesParams&&(identical(other.location, location) || other.location == location)&&(identical(other.radius, radius) || other.radius == radius)&&(identical(other.keyword, keyword) || other.keyword == keyword)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.minRating, minRating) || other.minRating == minRating)&&(identical(other.limit, limit) || other.limit == limit));
}


@override
int get hashCode => Object.hash(runtimeType,location,radius,keyword,categoryId,minRating,limit);

@override
String toString() {
  return 'SearchNearbyPlacesParams(location: $location, radius: $radius, keyword: $keyword, categoryId: $categoryId, minRating: $minRating, limit: $limit)';
}


}

/// @nodoc
abstract mixin class $SearchNearbyPlacesParamsCopyWith<$Res>  {
  factory $SearchNearbyPlacesParamsCopyWith(SearchNearbyPlacesParams value, $Res Function(SearchNearbyPlacesParams) _then) = _$SearchNearbyPlacesParamsCopyWithImpl;
@useResult
$Res call({
 LatLng location, double radius, String? keyword, String? categoryId, double? minRating, int limit
});




}
/// @nodoc
class _$SearchNearbyPlacesParamsCopyWithImpl<$Res>
    implements $SearchNearbyPlacesParamsCopyWith<$Res> {
  _$SearchNearbyPlacesParamsCopyWithImpl(this._self, this._then);

  final SearchNearbyPlacesParams _self;
  final $Res Function(SearchNearbyPlacesParams) _then;

/// Create a copy of SearchNearbyPlacesParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? location = null,Object? radius = null,Object? keyword = freezed,Object? categoryId = freezed,Object? minRating = freezed,Object? limit = null,}) {
  return _then(_self.copyWith(
location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as double,keyword: freezed == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,minRating: freezed == minRating ? _self.minRating : minRating // ignore: cast_nullable_to_non_nullable
as double?,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc


class _SearchNearbyPlacesParams implements SearchNearbyPlacesParams {
  const _SearchNearbyPlacesParams({required this.location, this.radius = 5000.0, this.keyword, this.categoryId, this.minRating, this.limit = 20});
  

@override final  LatLng location;
@override@JsonKey() final  double radius;
@override final  String? keyword;
@override final  String? categoryId;
@override final  double? minRating;
@override@JsonKey() final  int limit;

/// Create a copy of SearchNearbyPlacesParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchNearbyPlacesParamsCopyWith<_SearchNearbyPlacesParams> get copyWith => __$SearchNearbyPlacesParamsCopyWithImpl<_SearchNearbyPlacesParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchNearbyPlacesParams&&(identical(other.location, location) || other.location == location)&&(identical(other.radius, radius) || other.radius == radius)&&(identical(other.keyword, keyword) || other.keyword == keyword)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.minRating, minRating) || other.minRating == minRating)&&(identical(other.limit, limit) || other.limit == limit));
}


@override
int get hashCode => Object.hash(runtimeType,location,radius,keyword,categoryId,minRating,limit);

@override
String toString() {
  return 'SearchNearbyPlacesParams(location: $location, radius: $radius, keyword: $keyword, categoryId: $categoryId, minRating: $minRating, limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$SearchNearbyPlacesParamsCopyWith<$Res> implements $SearchNearbyPlacesParamsCopyWith<$Res> {
  factory _$SearchNearbyPlacesParamsCopyWith(_SearchNearbyPlacesParams value, $Res Function(_SearchNearbyPlacesParams) _then) = __$SearchNearbyPlacesParamsCopyWithImpl;
@override @useResult
$Res call({
 LatLng location, double radius, String? keyword, String? categoryId, double? minRating, int limit
});




}
/// @nodoc
class __$SearchNearbyPlacesParamsCopyWithImpl<$Res>
    implements _$SearchNearbyPlacesParamsCopyWith<$Res> {
  __$SearchNearbyPlacesParamsCopyWithImpl(this._self, this._then);

  final _SearchNearbyPlacesParams _self;
  final $Res Function(_SearchNearbyPlacesParams) _then;

/// Create a copy of SearchNearbyPlacesParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? location = null,Object? radius = null,Object? keyword = freezed,Object? categoryId = freezed,Object? minRating = freezed,Object? limit = null,}) {
  return _then(_SearchNearbyPlacesParams(
location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as double,keyword: freezed == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,minRating: freezed == minRating ? _self.minRating : minRating // ignore: cast_nullable_to_non_nullable
as double?,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$GetPlacesByCategoryParams {

 String get categoryId; LatLng? get location; double? get maxDistance; double? get minRating; double? get maxPrice; double? get minPrice; int get limit; String get sortBy;
/// Create a copy of GetPlacesByCategoryParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetPlacesByCategoryParamsCopyWith<GetPlacesByCategoryParams> get copyWith => _$GetPlacesByCategoryParamsCopyWithImpl<GetPlacesByCategoryParams>(this as GetPlacesByCategoryParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetPlacesByCategoryParams&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.location, location) || other.location == location)&&(identical(other.maxDistance, maxDistance) || other.maxDistance == maxDistance)&&(identical(other.minRating, minRating) || other.minRating == minRating)&&(identical(other.maxPrice, maxPrice) || other.maxPrice == maxPrice)&&(identical(other.minPrice, minPrice) || other.minPrice == minPrice)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy));
}


@override
int get hashCode => Object.hash(runtimeType,categoryId,location,maxDistance,minRating,maxPrice,minPrice,limit,sortBy);

@override
String toString() {
  return 'GetPlacesByCategoryParams(categoryId: $categoryId, location: $location, maxDistance: $maxDistance, minRating: $minRating, maxPrice: $maxPrice, minPrice: $minPrice, limit: $limit, sortBy: $sortBy)';
}


}

/// @nodoc
abstract mixin class $GetPlacesByCategoryParamsCopyWith<$Res>  {
  factory $GetPlacesByCategoryParamsCopyWith(GetPlacesByCategoryParams value, $Res Function(GetPlacesByCategoryParams) _then) = _$GetPlacesByCategoryParamsCopyWithImpl;
@useResult
$Res call({
 String categoryId, LatLng? location, double? maxDistance, double? minRating, double? maxPrice, double? minPrice, int limit, String sortBy
});




}
/// @nodoc
class _$GetPlacesByCategoryParamsCopyWithImpl<$Res>
    implements $GetPlacesByCategoryParamsCopyWith<$Res> {
  _$GetPlacesByCategoryParamsCopyWithImpl(this._self, this._then);

  final GetPlacesByCategoryParams _self;
  final $Res Function(GetPlacesByCategoryParams) _then;

/// Create a copy of GetPlacesByCategoryParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categoryId = null,Object? location = freezed,Object? maxDistance = freezed,Object? minRating = freezed,Object? maxPrice = freezed,Object? minPrice = freezed,Object? limit = null,Object? sortBy = null,}) {
  return _then(_self.copyWith(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng?,maxDistance: freezed == maxDistance ? _self.maxDistance : maxDistance // ignore: cast_nullable_to_non_nullable
as double?,minRating: freezed == minRating ? _self.minRating : minRating // ignore: cast_nullable_to_non_nullable
as double?,maxPrice: freezed == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as double?,minPrice: freezed == minPrice ? _self.minPrice : minPrice // ignore: cast_nullable_to_non_nullable
as double?,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class _GetPlacesByCategoryParams implements GetPlacesByCategoryParams {
  const _GetPlacesByCategoryParams({required this.categoryId, this.location, this.maxDistance, this.minRating, this.maxPrice, this.minPrice, this.limit = 20, this.sortBy = 'distance'});
  

@override final  String categoryId;
@override final  LatLng? location;
@override final  double? maxDistance;
@override final  double? minRating;
@override final  double? maxPrice;
@override final  double? minPrice;
@override@JsonKey() final  int limit;
@override@JsonKey() final  String sortBy;

/// Create a copy of GetPlacesByCategoryParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetPlacesByCategoryParamsCopyWith<_GetPlacesByCategoryParams> get copyWith => __$GetPlacesByCategoryParamsCopyWithImpl<_GetPlacesByCategoryParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetPlacesByCategoryParams&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.location, location) || other.location == location)&&(identical(other.maxDistance, maxDistance) || other.maxDistance == maxDistance)&&(identical(other.minRating, minRating) || other.minRating == minRating)&&(identical(other.maxPrice, maxPrice) || other.maxPrice == maxPrice)&&(identical(other.minPrice, minPrice) || other.minPrice == minPrice)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy));
}


@override
int get hashCode => Object.hash(runtimeType,categoryId,location,maxDistance,minRating,maxPrice,minPrice,limit,sortBy);

@override
String toString() {
  return 'GetPlacesByCategoryParams(categoryId: $categoryId, location: $location, maxDistance: $maxDistance, minRating: $minRating, maxPrice: $maxPrice, minPrice: $minPrice, limit: $limit, sortBy: $sortBy)';
}


}

/// @nodoc
abstract mixin class _$GetPlacesByCategoryParamsCopyWith<$Res> implements $GetPlacesByCategoryParamsCopyWith<$Res> {
  factory _$GetPlacesByCategoryParamsCopyWith(_GetPlacesByCategoryParams value, $Res Function(_GetPlacesByCategoryParams) _then) = __$GetPlacesByCategoryParamsCopyWithImpl;
@override @useResult
$Res call({
 String categoryId, LatLng? location, double? maxDistance, double? minRating, double? maxPrice, double? minPrice, int limit, String sortBy
});




}
/// @nodoc
class __$GetPlacesByCategoryParamsCopyWithImpl<$Res>
    implements _$GetPlacesByCategoryParamsCopyWith<$Res> {
  __$GetPlacesByCategoryParamsCopyWithImpl(this._self, this._then);

  final _GetPlacesByCategoryParams _self;
  final $Res Function(_GetPlacesByCategoryParams) _then;

/// Create a copy of GetPlacesByCategoryParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categoryId = null,Object? location = freezed,Object? maxDistance = freezed,Object? minRating = freezed,Object? maxPrice = freezed,Object? minPrice = freezed,Object? limit = null,Object? sortBy = null,}) {
  return _then(_GetPlacesByCategoryParams(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng?,maxDistance: freezed == maxDistance ? _self.maxDistance : maxDistance // ignore: cast_nullable_to_non_nullable
as double?,minRating: freezed == minRating ? _self.minRating : minRating // ignore: cast_nullable_to_non_nullable
as double?,maxPrice: freezed == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as double?,minPrice: freezed == minPrice ? _self.minPrice : minPrice // ignore: cast_nullable_to_non_nullable
as double?,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
