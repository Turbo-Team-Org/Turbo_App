import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbo/app/utils/theme/style.dart';
import 'package:turbo/location/state_management/location_bloc/cubit/location_cubit.dart';

class LocationPermissionDialog extends StatelessWidget {
  const LocationPermissionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/location_permission.png',
            height: 120,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.location_on_rounded,
                size: 80,
                color: Styles.turboRed,
              );
            },
          ),
          const SizedBox(height: 20),
          Text(
            '¿Permitir acceso a tu ubicación?',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'Turbo necesita acceso a tu ubicación para mostrarte los lugares cercanos y ofrecerte mejores recomendaciones',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Ahora no'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<LocationCubit>().requestLocationPermission();
                  Navigator.of(context).pop(true);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Styles.turboRed,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Permitir'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Muestra el diálogo de solicitud de permisos y devuelve true si el usuario acepta
Future<bool> showLocationPermissionDialog(BuildContext context) async {
  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => const LocationPermissionDialog(),
  );

  return result ?? false;
}
