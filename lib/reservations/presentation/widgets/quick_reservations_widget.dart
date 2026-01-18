import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:turbo/reservations/state_management/my_reservations_cubit/my_reservations_cubit.dart';
import 'package:turbo/reservations/state_management/my_reservations_cubit/my_reservations_state.dart';
import 'package:turbo/reservations/presentation/widgets/reservation_card.dart';
import 'package:turbo/app/routes/router/app_router.gr.dart';

class QuickReservationsWidget extends StatelessWidget {
  const QuickReservationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Verificar si el usuario está autenticado
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const SizedBox.shrink();
    }

    // Por ahora, mostrar widget mock hasta que tengamos datos reales
    return _buildMockWidget(context);
  }

  Widget _buildMockWidget(BuildContext context) {
    return Container(
      key: const ValueKey('quick_reservations_widget'),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.calendar_today,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reservas',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Sistema de reservas disponible',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.router.push(const MyReservationsRoute());
                  },
                  child: const Text('Ver todas'),
                ),
              ],
            ),
          ),

          // Botón para hacer nueva reserva
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navegar a categorías para elegir lugar
                  context.router.push(const CategoriesRoute());
                },
                icon: const Icon(Icons.add),
                label: const Text('Hacer Nueva Reserva'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget que se usará cuando tengamos datos reales del BlocBuilder
  Widget _buildRealWidget(BuildContext context) {
    return BlocBuilder<MyReservationsCubit, MyReservationsState>(
      buildWhen: (previous, current) {
        // Solo reconstruir si cambian las reservas próximas o el estado de carga
        return previous.upcomingReservations != current.upcomingReservations ||
            previous.isLoading != current.isLoading;
      },
      builder: (context, state) {
        // Cargar reservas si no se han cargado y no está cargando
        if (state.upcomingReservations.isEmpty &&
            state.pastReservations.isEmpty &&
            state.cancelledReservations.isEmpty &&
            !state.isLoading &&
            state.error == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              context.read<MyReservationsCubit>().loadUserReservations();
            }
          });
        }

        // No mostrar nada durante la carga inicial o si no hay reservas
        if (state.isLoading || state.upcomingReservations.isEmpty) {
          return const SizedBox.shrink();
        }

        final upcomingReservations = state.upcomingReservations;

        return Container(
          key: const ValueKey('quick_reservations_widget'),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.calendar_today,
                        color: Theme.of(context).colorScheme.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Próximas Reservas',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${upcomingReservations.length} reserva${upcomingReservations.length != 1 ? 's' : ''} pendiente${upcomingReservations.length != 1 ? 's' : ''}',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.router.push(const MyReservationsRoute());
                      },
                      child: const Text('Ver todas'),
                    ),
                  ],
                ),
              ),

              // Botón para hacer nueva reserva
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Navegar a categorías para elegir lugar
                      context.router.push(const CategoriesRoute());
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Hacer Nueva Reserva'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
