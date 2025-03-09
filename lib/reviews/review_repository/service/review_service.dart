import 'package:cloud_firestore/cloud_firestore.dart';

import '../interface/review_interface.dart';
import '../models/review.dart';

class ReviewService implements ReviewInterface {
  final FirebaseFirestore firestore;

  ReviewService({required this.firestore});

  @override
  Future<List<Review>> getReviews() async {
    return [];
  }

  @override
  Future<List<Review>> getReviewsFromAPlace(String placeId) async {
    return [];
  }

  @override
  Future<void> addReview(Review review, String placeId) async {
    try {
      final placeRef = firestore.collection('places').doc(placeId);
      final reviewRef = placeRef.collection('reviews');
      await reviewRef.add(review.toJson());
      // Transaction para actualizar el reviews_count de forma atómica
      await firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(placeRef);
        final currentCount = snapshot.data()?['reviews_count'] ?? 0;
        transaction.update(placeRef, {'reviews_count': currentCount + 1});
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> updateReview(Review review) async {
    return;
  }

  @override
  Future<void> deleteReview(String id) async {
    return;
  }
}
