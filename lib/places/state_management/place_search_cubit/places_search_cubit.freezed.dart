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
 double get minRating; double? get maxPrice; double? get minPrice; String get sortBy;// distance, rating, price, newest
 bool get showOnlyOpenNow; List<String> get selectedAmenities; PlaceSearchType get searchType; int get resultsLimit;// Filtros adicionales tipo Yelp
 bool get showOnlyWithReviews; bool get showOnlyWithPhotos; bool get showOnlyRecommended;
/// Create a copy of PlacesSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlacesSearchStateCopyWith<PlacesSearchState> get copyWith => _$PlacesSearchStateCopyWithImpl<PlacesSearchState>(this as PlacesSearchState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlacesSearchState&&const DeepCollectionEquality().equals(other.places, places)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.selectedCategoryId, selectedCategoryId) || other.selectedCategoryId == selectedCategoryId)&&(identical(other.selectedPlace, selectedPlace) || other.selectedPlace == selectedPlace)&&(identical(other.userLocation, userLocation) || other.userLocation == userLocation)&&(identical(other.mapCenter, mapCenter) || other.mapCenter == mapCenter)&&(identical(other.mapZoom, mapZoom) || other.mapZoom == mapZoom)&&(identical(other.isMapStyleDark, isMapStyleDark) || other.isMapStyleDark == isMapStyleDark)&&(identical(other.maxDistance, maxDistance) || other.maxDistance == maxDistance)&&(identical(other.minRating, minRating) || other.minRating == minRating)&&(identical(other.maxPrice, maxPrice) || other.maxPrice == maxPrice)&&(identical(other.minPrice, minPrice) || other.minPrice == minPrice)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.showOnlyOpenNow, showOnlyOpenNow) || other.showOnlyOpenNow == showOnlyOpenNow)&&const DeepCollectionEquality().equals(other.selectedAmenities, selectedAmenities)&&(identical(other.searchType, searchType) || other.searchType == searchType)&&(identical(other.resultsLimit, resultsLimit) || other.resultsLimit == resultsLimit)&&(identical(other.showOnlyWithReviews, showOnlyWithReviews) || other.showOnlyWithReviews == showOnlyWithReviews)&&(identical(other.showOnlyWithPhotos, showOnlyWithPhotos) || other.showOnlyWithPhotos == showOnlyWithPhotos)&&(identical(other.showOnlyRecommended, showOnlyRecommended) || other.showOnlyRecommended == showOnlyRecommended));
}


@override
int get hashCode => Object.hashAll([runtimeType,const DeepCollectionEquality().hash(places),isLoading,error,searchQuery,selectedCategoryId,selectedPlace,userLocation,mapCenter,mapZoom,isMapStyleDark,maxDistance,minRating,maxPrice,minPrice,sortBy,showOnlyOpenNow,const DeepCollectionEquality().hash(selectedAmenities),searchType,resultsLimit,showOnlyWithReviews,showOnlyWithPhotos,showOnlyRecommended]);

@override
String toString() {
  return 'PlacesSearchState(places: $places, isLoading: $isLoading, error: $error, searchQuery: $searchQuery, selectedCategoryId: $selectedCategoryId, selectedPlace: $selectedPlace, userLocation: $userLocation, mapCenter: $mapCenter, mapZoom: $mapZoom, isMapStyleDark: $isMapStyleDark, maxDistance: $maxDistance, minRating: $minRating, maxPrice: $maxPrice, minPrice: $minPrice, sortBy: $sortBy, showOnlyOpenNow: $showOnlyOpenNow, selectedAmenities: $selectedAmenities, searchType: $searchType, resultsLimit: $resultsLimit, showOnlyWithReviews: $showOnlyWithReviews, showOnlyWithPhotos: $showOnlyWithPhotos, showOnlyRecommended: $showOnlyRecommended)';
}


}

/// @nodoc
abstract mixin class $PlacesSearchStateCopyWith<$Res>  {
  factory $PlacesSearchStateCopyWith(PlacesSearchState value, $Res Function(PlacesSearchState) _then) = _$PlacesSearchStateCopyWithImpl;
@useResult
$Res call({
 List<Place> places, bool isLoading, String? error, String? searchQuery, String? selectedCategoryId, Place? selectedPlace, LatLng? userLocation, LatLng? mapCenter, double mapZoom, bool isMapStyleDark, double maxDistance, double minRating, double? maxPrice, double? minPrice, String sortBy, bool showOnlyOpenNow, List<String> selectedAmenities, PlaceSearchType searchType, int resultsLimit, bool showOnlyWithReviews, bool showOnlyWithPhotos, bool showOnlyRecommended
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
@pragma('vm:prefer-inline') @override $Res call({Object? places = null,Object? isLoading = null,Object? error = freezed,Object? searchQuery = freezed,Object? selectedCategoryId = freezed,Object? selectedPlace = freezed,Object? userLocation = freezed,Object? mapCenter = freezed,Object? mapZoom = null,Object? isMapStyleDark = null,Object? maxDistance = null,Object? minRating = null,Object? maxPrice = freezed,Object? minPrice = freezed,Object? sortBy = null,Object? showOnlyOpenNow = null,Object? selectedAmenities = null,Object? searchType = null,Object? resultsLimit = null,Object? showOnlyWithReviews = null,Object? showOnlyWithPhotos = null,Object? showOnlyRecommended = null,}) {
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
as double,maxPrice: freezed == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as double?,minPrice: freezed == minPrice ? _self.minPrice : minPrice // ignore: cast_nullable_to_non_nullable
as double?,sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as String,showOnlyOpenNow: null == showOnlyOpenNow ? _self.showOnlyOpenNow : showOnlyOpenNow // ignore: cast_nullable_to_non_nullable
as bool,selectedAmenities: null == selectedAmenities ? _self.selectedAmenities : selectedAmenities // ignore: cast_nullable_to_non_nullable
as List<String>,searchType: null == searchType ? _self.searchType : searchType // ignore: cast_nullable_to_non_nullable
as PlaceSearchType,resultsLimit: null == resultsLimit ? _self.resultsLimit : resultsLimit // ignore: cast_nullable_to_non_nullable
as int,showOnlyWithReviews: null == showOnlyWithReviews ? _self.showOnlyWithReviews : showOnlyWithReviews // ignore: cast_nullable_to_non_nullable
as bool,showOnlyWithPhotos: null == showOnlyWithPhotos ? _self.showOnlyWithPhotos : showOnlyWithPhotos // ignore: cast_nullable_to_non_nullable
as bool,showOnlyRecommended: null == showOnlyRecommended ? _self.showOnlyRecommended : showOnlyRecommended // ignore: cast_nullable_to_non_nullable
as bool,
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
  const _PlacesSearchState({final  List<Place> places = const [], this.isLoading = false, this.error, this.searchQuery, this.selectedCategoryId, this.selectedPlace, this.userLocation, this.mapCenter, this.mapZoom = 14.0, this.isMapStyleDark = false, this.maxDistance = 5000.0, this.minRating = 0.0, this.maxPrice, this.minPrice, this.sortBy = 'distance', this.showOnlyOpenNow = false, final  List<String> selectedAmenities = const [], this.searchType = PlaceSearchType.all, this.resultsLimit = 20, this.showOnlyWithReviews = false, this.showOnlyWithPhotos = false, this.showOnlyRecommended = false}): _places = places,_selectedAmenities = selectedAmenities;
  

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
@override final  double? maxPrice;
@override final  double? minPrice;
@override@JsonKey() final  String sortBy;
// distance, rating, price, newest
@override@JsonKey() final  bool showOnlyOpenNow;
 final  List<String> _selectedAmenities;
@override@JsonKey() List<String> get selectedAmenities {
  if (_selectedAmenities is EqualUnmodifiableListView) return _selectedAmenities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedAmenities);
}

@override@JsonKey() final  PlaceSearchType searchType;
@override@JsonKey() final  int resultsLimit;
// Filtros adicionales tipo Yelp
@override@JsonKey() final  bool showOnlyWithReviews;
@override@JsonKey() final  bool showOnlyWithPhotos;
@override@JsonKey() final  bool showOnlyRecommended;

/// Create a copy of PlacesSearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlacesSearchStateCopyWith<_PlacesSearchState> get copyWith => __$PlacesSearchStateCopyWithImpl<_PlacesSearchState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlacesSearchState&&const DeepCollectionEquality().equals(other._places, _places)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.selectedCategoryId, selectedCategoryId) || other.selectedCategoryId == selectedCategoryId)&&(identical(other.selectedPlace, selectedPlace) || other.selectedPlace == selectedPlace)&&(identical(other.userLocation, userLocation) || other.userLocation == userLocation)&&(identical(other.mapCenter, mapCenter) || other.mapCenter == mapCenter)&&(identical(other.mapZoom, mapZoom) || other.mapZoom == mapZoom)&&(identical(other.isMapStyleDark, isMapStyleDark) || other.isMapStyleDark == isMapStyleDark)&&(identical(other.maxDistance, maxDistance) || other.maxDistance == maxDistance)&&(identical(other.minRating, minRating) || other.minRating == minRating)&&(identical(other.maxPrice, maxPrice) || other.maxPrice == maxPrice)&&(identical(other.minPrice, minPrice) || other.minPrice == minPrice)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.showOnlyOpenNow, showOnlyOpenNow) || other.showOnlyOpenNow == showOnlyOpenNow)&&const DeepCollectionEquality().equals(other._selectedAmenities, _selectedAmenities)&&(identical(other.searchType, searchType) || other.searchType == searchType)&&(identical(other.resultsLimit, resultsLimit) || other.resultsLimit == resultsLimit)&&(identical(other.showOnlyWithReviews, showOnlyWithReviews) || other.showOnlyWithReviews == showOnlyWithReviews)&&(identical(other.showOnlyWithPhotos, showOnlyWithPhotos) || other.showOnlyWithPhotos == showOnlyWithPhotos)&&(identical(other.showOnlyRecommended, showOnlyRecommended) || other.showOnlyRecommended == showOnlyRecommended));
}


@override
int get hashCode => Object.hashAll([runtimeType,const DeepCollectionEquality().hash(_places),isLoading,error,searchQuery,selectedCategoryId,selectedPlace,userLocation,mapCenter,mapZoom,isMapStyleDark,maxDistance,minRating,maxPrice,minPrice,sortBy,showOnlyOpenNow,const DeepCollectionEquality().hash(_selectedAmenities),searchType,resultsLimit,showOnlyWithReviews,showOnlyWithPhotos,showOnlyRecommended]);

@override
String toString() {
  return 'PlacesSearchState(places: $places, isLoading: $isLoading, error: $error, searchQuery: $searchQuery, selectedCategoryId: $selectedCategoryId, selectedPlace: $selectedPlace, userLocation: $userLocation, mapCenter: $mapCenter, mapZoom: $mapZoom, isMapStyleDark: $isMapStyleDark, maxDistance: $maxDistance, minRating: $minRating, maxPrice: $maxPrice, minPrice: $minPrice, sortBy: $sortBy, showOnlyOpenNow: $showOnlyOpenNow, selectedAmenities: $selectedAmenities, searchType: $searchType, resultsLimit: $resultsLimit, showOnlyWithReviews: $showOnlyWithReviews, showOnlyWithPhotos: $showOnlyWithPhotos, showOnlyRecommended: $showOnlyRecommended)';
}


}

/// @nodoc
abstract mixin class _$PlacesSearchStateCopyWith<$Res> implements $PlacesSearchStateCopyWith<$Res> {
  factory _$PlacesSearchStateCopyWith(_PlacesSearchState value, $Res Function(_PlacesSearchState) _then) = __$PlacesSearchStateCopyWithImpl;
@override @useResult
$Res call({
 List<Place> places, bool isLoading, String? error, String? searchQuery, String? selectedCategoryId, Place? selectedPlace, LatLng? userLocation, LatLng? mapCenter, double mapZoom, bool isMapStyleDark, double maxDistance, double minRating, double? maxPrice, double? minPrice, String sortBy, bool showOnlyOpenNow, List<String> selectedAmenities, PlaceSearchType searchType, int resultsLimit, bool showOnlyWithReviews, bool showOnlyWithPhotos, bool showOnlyRecommended
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
@override @pragma('vm:prefer-inline') $Res call({Object? places = null,Object? isLoading = null,Object? error = freezed,Object? searchQuery = freezed,Object? selectedCategoryId = freezed,Object? selectedPlace = freezed,Object? userLocation = freezed,Object? mapCenter = freezed,Object? mapZoom = null,Object? isMapStyleDark = null,Object? maxDistance = null,Object? minRating = null,Object? maxPrice = freezed,Object? minPrice = freezed,Object? sortBy = null,Object? showOnlyOpenNow = null,Object? selectedAmenities = null,Object? searchType = null,Object? resultsLimit = null,Object? showOnlyWithReviews = null,Object? showOnlyWithPhotos = null,Object? showOnlyRecommended = null,}) {
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
as double,maxPrice: freezed == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as double?,minPrice: freezed == minPrice ? _self.minPrice : minPrice // ignore: cast_nullable_to_non_nullable
as double?,sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as String,showOnlyOpenNow: null == showOnlyOpenNow ? _self.showOnlyOpenNow : showOnlyOpenNow // ignore: cast_nullable_to_non_nullable
as bool,selectedAmenities: null == selectedAmenities ? _self._selectedAmenities : selectedAmenities // ignore: cast_nullable_to_non_nullable
as List<String>,searchType: null == searchType ? _self.searchType : searchType // ignore: cast_nullable_to_non_nullable
as PlaceSearchType,resultsLimit: null == resultsLimit ? _self.resultsLimit : resultsLimit // ignore: cast_nullable_to_non_nullable
as int,showOnlyWithReviews: null == showOnlyWithReviews ? _self.showOnlyWithReviews : showOnlyWithReviews // ignore: cast_nullable_to_non_nullable
as bool,showOnlyWithPhotos: null == showOnlyWithPhotos ? _self.showOnlyWithPhotos : showOnlyWithPhotos // ignore: cast_nullable_to_non_nullable
as bool,showOnlyRecommended: null == showOnlyRecommended ? _self.showOnlyRecommended : showOnlyRecommended // ignore: cast_nullable_to_non_nullable
as bool,
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
