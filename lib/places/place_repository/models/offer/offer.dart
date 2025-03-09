import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'offer.freezed.dart';
part 'offer.g.dart';

@Freezed()
sealed class Offer with _$Offer {
  const factory Offer({
    required String offerTitle,
    required String offerDescription,
    required DateTime offerValidUntil,
    double? offerPrice,
    String? offerConditions,
    String? offerImage,
  }) = _Offer;

  factory Offer.fromJson(Map<String, dynamic> json) => _$OfferFromJson(json);

  // Custom Conversor for Firestore
  factory Offer.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Offer(
      offerTitle: data['offerTitle'],
      offerDescription: data['offerDescription'],
      offerValidUntil: (data['offerValidUntil'] as Timestamp).toDate(),
      offerPrice: (data['offerPrice'] as num).toDouble() ?? 0,
      offerConditions: data['offerConditions'] ?? '',
      offerImage: data['offerImage'] ?? '',
    );
  }
}
