import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:turbo/places/place_repository/models/offer/offer.dart';
import 'package:turbo/places/place_repository/models/schedule/schedule.dart';

import '../../../../reviews/review_repository/models/review.dart';

part 'place.freezed.dart';
part 'place.g.dart';

@Freezed()
sealed class Place with _$Place {
  const factory Place({
    required String id,
    required String name,
    required String description,
    required String address,
    required double averagePrice,
    required List<String> imageUrls,
    required double rating,
    required List<Review> reviews,
    @Default([]) List<Offer> offers,
    @Default([]) List<String> tags,
    @Default(false) bool isOpen,
    @Default([]) List<Schedule> schedules,
    @Default("") String mainImage,
    @Default(0) int favoriteCount,
    @Default("") String menuUrl,
  }) = _Place;

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);

  //Custom Conversor for Firestore
  factory Place.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Place(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      address: data['address'] ?? '',
      averagePrice: ((data['averagePrice'] ?? 0) as num).toDouble(),
      imageUrls: List<String>.from(data['imageUrls'] ?? []),
      rating: ((data['rating'] ?? 0) as num).toDouble(),
      reviews: [],
      offers:
          data['offers'] != null
              ? List<Map<String, dynamic>>.from(
                data['offers'],
              ).map((offerData) => Offer.fromJson(offerData)).toList()
              : [],
      tags: List<String>.from(data['tags'] ?? []),
      isOpen: data['isOpen'] ?? false,
      schedules:
          data['schedules'] != null
              ? List<Map<String, dynamic>>.from(
                data['schedules'],
              ).map((scheduleData) => Schedule.fromJson(scheduleData)).toList()
              : [],
      mainImage:
          data['mainImage'] ??
          (data['imageUrls'] != null && (data['imageUrls'] as List).isNotEmpty
              ? (data['imageUrls'] as List).first.toString()
              : ''),
      favoriteCount: data['favoriteCount'] ?? 0,
      menuUrl: data['menuUrl'] ?? '',
    );
  }
}
