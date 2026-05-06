import 'package:flutter/material.dart';

import '../../../app/utils/date_utils/date_utils.dart';
import 'package:core/core.dart';

class OfferDetailsDialog extends StatelessWidget {
  final Offer offer;

  const OfferDetailsDialog({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color.fromARGB(0, 31, 31, 31),
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 65, 62, 62).withOpacity(0.4),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título de la oferta
            Text(
              offer.offerTitle,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            // Descripción de la oferta
            Text(
              offer.offerDescription,
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 20),
            // Detalles adicionales
            _buildDetailRow(
              Icons.calendar_today,
              "Válido hasta: ${TurboDateUtils.formatDate(offer.offerValidUntil)}",
            ),
            _buildDetailRow(
              Icons.attach_money,
              "Descuento: ${offer.offerPrice}%",
            ),
            _buildDetailRow(
              Icons.location_on,
              "Condiciones: ${offer.offerConditions}",
            ),
            const SizedBox(height: 20),
            // Botón para cerrar
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Cerrar",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir una fila de detalles
  Widget _buildDetailRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, color: Colors.white),
              overflow:
                  TextOverflow
                      .ellipsis, // Truncar el texto si es demasiado largo
              maxLines: 1, // Limitar a una sola línea
            ),
          ),
        ],
      ),
    );
  }
}
