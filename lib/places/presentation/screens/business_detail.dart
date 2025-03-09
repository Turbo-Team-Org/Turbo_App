import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../../reviews/review_repository/models/review.dart';
import '../../place_repository/models/offer/offer.dart';
import '../../place_repository/models/place/place.dart';
import '../widgets/feed_widgets.dart';

@RoutePage()
class BusinessDetailsScreen extends StatelessWidget {
  final Place place;

  const BusinessDetailsScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          BusinessBackground(place: place),
          BusinessContent(place: place),
        ],
      ),
    );
  }
}

class BusinessBackground extends StatelessWidget {
  final Place place;

  const BusinessBackground({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: PageView.builder(
        itemCount: place.imageUrls.length,
        itemBuilder: (context, index) {
          return Hero(
            tag: 'place_${place.id}_image_$index',
            child: Image.network(
              place.imageUrls[index],
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          );
        },
      ),
    );
  }
}

class BusinessContent extends StatelessWidget {
  final Place place;

  const BusinessContent({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.6,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 52, 40, 40).withOpacity(0.4),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 26, 26, 26).withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: ListView(
            controller: scrollController,
            children: [
              if (place.offer != null) OfferSection(offer: place.offer!),
              const SizedBox(height: 10),
              BusinessName(place: place),
              const SizedBox(height: 10),
              BusinessDescription(place: place),
              const SizedBox(height: 10),
              BusinessRating(place: place),
              const SizedBox(height: 20),
              AddReviewButton(place: place),
              const SizedBox(height: 20),
              BusinessReviews(place: place),
            ],
          ),
        );
      },
    );
  }
}

class BusinessName extends StatelessWidget {
  final Place place;

  const BusinessName({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Text(
        place.name,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

class BusinessDescription extends StatelessWidget {
  final Place place;

  const BusinessDescription({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: const Duration(milliseconds: 200),
      child: Text(
        place.description,
        style: const TextStyle(
            fontSize: 16, color: Color.fromARGB(179, 255, 255, 255)),
      ),
    );
  }
}

class BusinessRating extends StatelessWidget {
  final Place place;

  const BusinessRating({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: const Duration(milliseconds: 400),
      child: Row(
        children: List.generate(5, (index) {
          return Icon(
            index < place.rating ? Icons.star : Icons.star_border,
            color: Colors.yellow,
          );
        }),
      ),
    );
  }
}

class AddReviewButton extends StatelessWidget {
  final Place place;

  const AddReviewButton({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: const Duration(milliseconds: 600),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => AddReviewModal(place: place),
          );
        },
        child: const Text("Agregar Reseña"),
      ),
    );
  }
}

class BusinessReviews extends StatelessWidget {
  final Place place;

  const BusinessReviews({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Mostrar la oferta si está disponible
        const SizedBox(height: 20),
        const Text(
          "Reseñas",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 10),
        ...place.reviews.map((review) => ReviewCard(review: review)),
      ],
    );
  }
}

class OfferSection extends StatelessWidget {
  final Offer offer;

  const OfferSection({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
        delay: const Duration(milliseconds: 200),
        child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => OfferDetailsDialog(offer: offer),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.local_offer,
                      color: Colors.white, size: 30), // Ícono de oferta
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Oferta Especial",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          offer.offerTitle,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          offer.offerDescription,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      color: const Color.fromARGB(255, 30, 30, 30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        title: Text(
          review.userName,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          review.comment,
          style: const TextStyle(color: Colors.white70),
        ),
        leading: const Icon(Icons.account_circle, color: Colors.white),
        trailing: const Icon(
          Icons.star,
          color: Colors.yellow,
          size: 20,
        ),
      ),
    );
  }
}
