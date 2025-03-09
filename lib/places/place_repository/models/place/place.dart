import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:turbo/places/place_repository/models/offer/offer.dart';

import '../../../../reviews/review_repository/models/review.dart';

part 'place.freezed.dart';
part 'place.g.dart';

@Freezed()
sealed class Place with _$Place {
  const factory Place({
    required int id,
    required String name,
    required String description,
    required String address,
    required double averagePrice,
    required List<String> imageUrls,
    required double rating,
    required List<Review> reviews,
    Offer? offer,
  }) = _Place;

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);

  //Custom Conversor for Firestore
  factory Place.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Place(
      id: data['id'],
      name: data['name'],
      description: data['description'],
      address: data['address'],
      averagePrice: (data['averagePrice'] as num).toDouble(),
      imageUrls: List<String>.from(data['imageUrls']),
      rating: (data['rating'] as num).toDouble(),
      reviews: [],
      offer: data['offer'] != null ? Offer.fromJson(data['offer']) : null,
    );
  }
}
