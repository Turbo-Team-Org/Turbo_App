// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CategoryState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CategoryState()';
}


}

/// @nodoc
class $CategoryStateCopyWith<$Res>  {
$CategoryStateCopyWith(CategoryState _, $Res Function(CategoryState) __);
}


/// @nodoc


class CategoryInitial implements CategoryState {
  const CategoryInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CategoryState.initial()';
}


}




/// @nodoc


class CategoryLoading implements CategoryState {
  const CategoryLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CategoryState.loading()';
}


}




/// @nodoc


class CategoryLoaded implements CategoryState {
  const CategoryLoaded({required final  List<Category> categories}): _categories = categories;
  

 final  List<Category> _categories;
 List<Category> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}


/// Create a copy of CategoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryLoadedCopyWith<CategoryLoaded> get copyWith => _$CategoryLoadedCopyWithImpl<CategoryLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryLoaded&&const DeepCollectionEquality().equals(other._categories, _categories));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_categories));

@override
String toString() {
  return 'CategoryState.loaded(categories: $categories)';
}


}

/// @nodoc
abstract mixin class $CategoryLoadedCopyWith<$Res> implements $CategoryStateCopyWith<$Res> {
  factory $CategoryLoadedCopyWith(CategoryLoaded value, $Res Function(CategoryLoaded) _then) = _$CategoryLoadedCopyWithImpl;
@useResult
$Res call({
 List<Category> categories
});




}
/// @nodoc
class _$CategoryLoadedCopyWithImpl<$Res>
    implements $CategoryLoadedCopyWith<$Res> {
  _$CategoryLoadedCopyWithImpl(this._self, this._then);

  final CategoryLoaded _self;
  final $Res Function(CategoryLoaded) _then;

/// Create a copy of CategoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? categories = null,}) {
  return _then(CategoryLoaded(
categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,
  ));
}


}

/// @nodoc


class CategoryError implements CategoryState {
  const CategoryError(this.message);
  

 final  String message;

/// Create a copy of CategoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryErrorCopyWith<CategoryError> get copyWith => _$CategoryErrorCopyWithImpl<CategoryError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CategoryState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $CategoryErrorCopyWith<$Res> implements $CategoryStateCopyWith<$Res> {
  factory $CategoryErrorCopyWith(CategoryError value, $Res Function(CategoryError) _then) = _$CategoryErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CategoryErrorCopyWithImpl<$Res>
    implements $CategoryErrorCopyWith<$Res> {
  _$CategoryErrorCopyWithImpl(this._self, this._then);

  final CategoryError _self;
  final $Res Function(CategoryError) _then;

/// Create a copy of CategoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CategoryError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SelectedCategory implements CategoryState {
  const SelectedCategory({required this.category});
  

 final  Category category;

/// Create a copy of CategoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectedCategoryCopyWith<SelectedCategory> get copyWith => _$SelectedCategoryCopyWithImpl<SelectedCategory>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectedCategory&&(identical(other.category, category) || other.category == category));
}


@override
int get hashCode => Object.hash(runtimeType,category);

@override
String toString() {
  return 'CategoryState.selectedCategory(category: $category)';
}


}

/// @nodoc
abstract mixin class $SelectedCategoryCopyWith<$Res> implements $CategoryStateCopyWith<$Res> {
  factory $SelectedCategoryCopyWith(SelectedCategory value, $Res Function(SelectedCategory) _then) = _$SelectedCategoryCopyWithImpl;
@useResult
$Res call({
 Category category
});


$CategoryCopyWith<$Res> get category;

}
/// @nodoc
class _$SelectedCategoryCopyWithImpl<$Res>
    implements $SelectedCategoryCopyWith<$Res> {
  _$SelectedCategoryCopyWithImpl(this._self, this._then);

  final SelectedCategory _self;
  final $Res Function(SelectedCategory) _then;

/// Create a copy of CategoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? category = null,}) {
  return _then(SelectedCategory(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as Category,
  ));
}

/// Create a copy of CategoryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryCopyWith<$Res> get category {
  
  return $CategoryCopyWith<$Res>(_self.category, (value) {
    return _then(_self.copyWith(category: value));
  });
}
}

/// @nodoc


class PlacesInCategory implements CategoryState {
  const PlacesInCategory({required this.places});
  

 final  PlaceCategory places;

/// Create a copy of CategoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlacesInCategoryCopyWith<PlacesInCategory> get copyWith => _$PlacesInCategoryCopyWithImpl<PlacesInCategory>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlacesInCategory&&(identical(other.places, places) || other.places == places));
}


@override
int get hashCode => Object.hash(runtimeType,places);

@override
String toString() {
  return 'CategoryState.placesInCategory(places: $places)';
}


}

/// @nodoc
abstract mixin class $PlacesInCategoryCopyWith<$Res> implements $CategoryStateCopyWith<$Res> {
  factory $PlacesInCategoryCopyWith(PlacesInCategory value, $Res Function(PlacesInCategory) _then) = _$PlacesInCategoryCopyWithImpl;
@useResult
$Res call({
 PlaceCategory places
});




}
/// @nodoc
class _$PlacesInCategoryCopyWithImpl<$Res>
    implements $PlacesInCategoryCopyWith<$Res> {
  _$PlacesInCategoryCopyWithImpl(this._self, this._then);

  final PlacesInCategory _self;
  final $Res Function(PlacesInCategory) _then;

/// Create a copy of CategoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? places = null,}) {
  return _then(PlacesInCategory(
places: null == places ? _self.places : places // ignore: cast_nullable_to_non_nullable
as PlaceCategory,
  ));
}


}

// dart format on
