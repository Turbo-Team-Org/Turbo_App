import 'package:flutter/material.dart';

import '../../../reviews/review_repository/models/review.dart';
import '../../place_repository/models/place/place.dart';

class AddReviewModal extends StatelessWidget {
  final Place place;

  const AddReviewModal({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final TextEditingController commentController = TextEditingController();
    int rating = 1;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Agregar Reseña",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Calificación
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: Colors.yellow,
                  ),
                  onPressed: () {
                    rating = index + 1;
                  },
                );
              }),
            ),
            const SizedBox(height: 20),
            // Comentario
            TextField(
              controller: commentController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Escribe tu reseña...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Botón de Enviar
            ElevatedButton(
              onPressed: () {
                if (commentController.text.isNotEmpty && rating > 0) {
                  // Aquí puedes agregar la lógica para enviar la reseña
                  place.reviews.add(
                    Review(
                      id: '1',
                      userName:
                          'Usuario', // Esto lo podrías obtener del usuario logueado
                      comment: commentController.text,
                      rating: rating.toDouble(),
                      userAvatar: 'https://via.placeholder.com/150',
                      date: DateTime.now(),
                    ),
                  );

                  Navigator.pop(
                    context,
                  ); // Cierra el modal después de agregar la reseña
                }
              },
              child: const Text("Enviar Reseña"),
            ),
          ],
        ),
      ),
    );
  }
}
