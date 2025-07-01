// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'places_search_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlacesSearchState {

 List<Place> get places; bool get isLoading; String? get error; String? get searchQuery; String? get selectedCategoryId; Place? get selectedPlace; LatLng? get userLocation; LatLng? get mapCenter; double get mapZoom; bool get isMapStyleDark; double get maxDistance;// metros
 double get minRating;
/// Create a copy of PlacesSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlacesSearchStateCopyWith<PlacesSearchState> get copyWith => _$PlacesSearchStateCopyWithImpl<PlacesSearchState>(this as PlacesSearchState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlacesSearchState&&const DeepCollectionEquality().equals(other.places, places)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.selectedCategoryId, selectedCategoryId) || other.selectedCategoryId == selectedCategoryId)&&(identical(other.selectedPlace, selectedPlace) || other.selectedPlace == selectedPlace)&&(identical(other.userLocation, userLocation) || other.userLocation == userLocation)&&(identical(other.mapCenter, mapCenter) || other.mapCenter == mapCenter)&&(identical(other.mapZoom, mapZoom) || other.mapZoom == mapZoom)&&(identical(other.isMapStyleDark, isMapStyleDark) || other.isMapStyleDark == isMapStyleDark)&&(identical(other.maxDistance, maxDistance) || other.maxDistance == maxDistance)&&(identical(other.minRating, minRating) || other.minRating == minRating));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(places),isLoading,error,searchQuery,selectedCategoryId,selectedPlace,userLocation,mapCenter,mapZoom,isMapStyleDark,maxDistance,minRating);

@override
String toString() {
  return 'PlacesSearchState(places: $places, isLoading: $isLoading, error: $error, searchQuery: $searchQuery, selectedCategoryId: $selectedCategoryId, selectedPlace: $selectedPlace, userLocation: $userLocation, mapCenter: $mapCenter, mapZoom: $mapZoom, isMapStyleDark: $isMapStyleDark, maxDistance: $maxDistance, minRating: $minRating)';
}


}

/// @nodoc
abstract mixin class $PlacesSearchStateCopyWith<$Res>  {
  factory $PlacesSearchStateCopyWith(PlacesSearchState value, $Res Function(PlacesSearchState) _then) = _$PlacesSearchStateCopyWithImpl;
@useResult
$Res call({
 List<Place> places, bool isLoading, String? error, String? searchQuery, String? selectedCategoryId, Place? selectedPlace, LatLng? userLocation, LatLng? mapCenter, double mapZoom, bool isMapStyleDark, double maxDistance, double minRating
});


$PlaceCopyWith<$Res>? get selectedPlace;

}
/// @nodoc
class _$PlacesSearchStateCopyWithImpl<$Res>
    implements $PlacesSearchStateCopyWith<$Res> {
  _$PlacesSearchStateCopyWithImpl(this._self, this._then);

  final PlacesSearchState _self;
  final $Res Function(PlacesSearchState) _then;

/// Create a copy of PlacesSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? places = null,Object? isLoading = null,Object? error = freezed,Object? searchQuery = freezed,Object? selectedCategoryId = freezed,Object? selectedPlace = freezed,Object? userLocation = freezed,Object? mapCenter = freezed,Object? mapZoom = null,Object? isMapStyleDark = null,Object? maxDistance = null,Object? minRating = null,}) {
  return _then(_self.copyWith(
places: null == places ? _self.places : places // ignore: cast_nullable_to_non_nullable
as List<Place>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,selectedCategoryId: freezed == selectedCategoryId ? _self.selectedCategoryId : selectedCategoryId // ignore: cast_nullable_to_non_nullable
as String?,selectedPlace: freezed == selectedPlace ? _self.selectedPlace : selectedPlace // ignore: cast_nullable_to_non_nullable
as Place?,userLocation: freezed == userLocation ? _self.userLocation : userLocation // ignore: cast_nullable_to_non_nullable
as LatLng?,mapCenter: freezed == mapCenter ? _self.mapCenter : mapCenter // ignore: cast_nullable_to_non_nullable
as LatLng?,mapZoom: null == mapZoom ? _self.mapZoom : mapZoom // ignore: cast_nullable_to_non_nullable
as double,isMapStyleDark: null == isMapStyleDark ? _self.isMapStyleDark : isMapStyleDark // ignore: cast_nullable_to_non_nullable
as bool,maxDistance: null == maxDistance ? _self.maxDistance : maxDistance // ignore: cast_nullable_to_non_nullable
as double,minRating: null == minRating ? _self.minRating : minRating // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of PlacesSearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlaceCopyWith<$Res>? get selectedPlace {
    if (_self.selectedPlace == null) {
    return null;
  }

  return $PlaceCopyWith<$Res>(_self.selectedPlace!, (value) {
    return _then(_self.copyWith(selectedPlace: value));
  });
}
}


/// @nodoc


class _PlacesSearchState implements PlacesSearchState {
  const _PlacesSearchState({final  List<Place> places = const [], this.isLoading = false, this.error, this.searchQuery, this.selectedCategoryId, this.selectedPlace, this.userLocation, this.mapCenter, this.mapZoom = 14.0, this.isMapStyleDark = false, this.maxDistance = 5000.0, this.minRating = 0.0}): _places = places;
  

 final  List<Place> _places;
@override@JsonKey() List<Place> get places {
  if (_places is EqualUnmodifiableListView) return _places;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_places);
}

@override@JsonKey() final  bool isLoading;
@override final  String? error;
@override final  String? searchQuery;
@override final  String? selectedCategoryId;
@override final  Place? selectedPlace;
@override final  LatLng? userLocation;
@override final  LatLng? mapCenter;
@override@JsonKey() final  double mapZoom;
@override@JsonKey() final  bool isMapStyleDark;
@override@JsonKey() final  double maxDistance;
// metros
@override@JsonKey() final  double minRating;

/// Create a copy of PlacesSearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlacesSearchStateCopyWith<_PlacesSearchState> get copyWith => __$PlacesSearchStateCopyWithImpl<_PlacesSearchState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlacesSearchState&&const DeepCollectionEquality().equals(other._places, _places)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.selectedCategoryId, selectedCategoryId) || other.selectedCategoryId == selectedCategoryId)&&(identical(other.selectedPlace, selectedPlace) || other.selectedPlace == selectedPlace)&&(identical(other.userLocation, userLocation) || other.userLocation == userLocation)&&(identical(other.mapCenter, mapCenter) || other.mapCenter == mapCenter)&&(identical(other.mapZoom, mapZoom) || other.mapZoom == mapZoom)&&(identical(other.isMapStyleDark, isMapStyleDark) || other.isMapStyleDark == isMapStyleDark)&&(identical(other.maxDistance, maxDistance) || other.maxDistance == maxDistance)&&(identical(other.minRating, minRating) || other.minRating == minRating));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_places),isLoading,error,searchQuery,selectedCategoryId,selectedPlace,userLocation,mapCenter,mapZoom,isMapStyleDark,maxDistance,minRating);

@override
String toString() {
  return 'PlacesSearchState(places: $places, isLoading: $isLoading, error: $error, searchQuery: $searchQuery, selectedCategoryId: $selectedCategoryId, selectedPlace: $selectedPlace, userLocation: $userLocation, mapCenter: $mapCenter, mapZoom: $mapZoom, isMapStyleDark: $isMapStyleDark, maxDistance: $maxDistance, minRating: $minRating)';
}


}

/// @nodoc
abstract mixin class _$PlacesSearchStateCopyWith<$Res> implements $PlacesSearchStateCopyWith<$Res> {
  factory _$PlacesSearchStateCopyWith(_PlacesSearchState value, $Res Function(_PlacesSearchState) _then) = __$PlacesSearchStateCopyWithImpl;
@override @useResult
$Res call({
 List<Place> places, bool isLoading, String? error, String? searchQuery, String? selectedCategoryId, Place? selectedPlace, LatLng? userLocation, LatLng? mapCenter, double mapZoom, bool isMapStyleDark, double maxDistance, double minRating
});


@override $PlaceCopyWith<$Res>? get selectedPlace;

}
/// @nodoc
class __$PlacesSearchStateCopyWithImpl<$Res>
    implements _$PlacesSearchStateCopyWith<$Res> {
  __$PlacesSearchStateCopyWithImpl(this._self, this._then);

  final _PlacesSearchState _self;
  final $Res Function(_PlacesSearchState) _then;

/// Create a copy of PlacesSearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? places = null,Object? isLoading = null,Object? error = freezed,Object? searchQuery = freezed,Object? selectedCategoryId = freezed,Object? selectedPlace = freezed,Object? userLocation = freezed,Object? mapCenter = freezed,Object? mapZoom = null,Object? isMapStyleDark = null,Object? maxDistance = null,Object? minRating = null,}) {
  return _then(_PlacesSearchState(
places: null == places ? _self._places : places // ignore: cast_nullable_to_non_nullable
as List<Place>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,selectedCategoryId: freezed == selectedCategoryId ? _self.selectedCategoryId : selectedCategoryId // ignore: cast_nullable_to_non_nullable
as String?,selectedPlace: freezed == selectedPlace ? _self.selectedPlace : selectedPlace // ignore: cast_nullable_to_non_nullable
as Place?,userLocation: freezed == userLocation ? _self.userLocation : userLocation // ignore: cast_nullable_to_non_nullable
as LatLng?,mapCenter: freezed == mapCenter ? _self.mapCenter : mapCenter // ignore: cast_nullable_to_non_nullable
as LatLng?,mapZoom: null == mapZoom ? _self.mapZoom : mapZoom // ignore: cast_nullable_to_non_nullable
as double,isMapStyleDark: null == isMapStyleDark ? _self.isMapStyleDark : isMapStyleDark // ignore: cast_nullable_to_non_nullable
as bool,maxDistance: null == maxDistance ? _self.maxDistance : maxDistance // ignore: cast_nullable_to_non_nullable
as double,minRating: null == minRating ? _self.minRating : minRating // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of PlacesSearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlaceCopyWith<$Res>? get selectedPlace {
    if (_self.selectedPlace == null) {
    return null;
  }

  return $PlaceCopyWith<$Res>(_self.selectedPlace!, (value) {
    return _then(_self.copyWith(selectedPlace: value));
  });
}
}

// dart format on
