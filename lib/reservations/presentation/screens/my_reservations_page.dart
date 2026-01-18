import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:core/core.dart';
import 'package:turbo/reservations/state_management/my_reservations_cubit/my_reservations_cubit.dart';
import 'package:turbo/reservations/state_management/my_reservations_cubit/my_reservations_state.dart';
import 'package:turbo/reservations/presentation/widgets/reservation_card.dart';
import 'package:turbo/app/routes/router/app_router.gr.dart';

@RoutePage()
class MyReservationsPage extends StatefulWidget {
  const MyReservationsPage({super.key});

  @override
  State<MyReservationsPage> createState() => _MyReservationsPageState();
}

class _MyReservationsPageState extends State<MyReservationsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Cargar reservas al iniciar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MyReservationsCubit>().loadUserReservations();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Reservas'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.upcoming), text: 'Próximas'),
            Tab(icon: Icon(Icons.history), text: 'Pasadas'),
            Tab(icon: Icon(Icons.cancel_outlined), text: 'Canceladas'),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<MyReservationsCubit>().refreshReservations();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: BlocConsumer<MyReservationsCubit, MyReservationsState>(
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: Colors.red,
              ),
            );
          }

          if (state.success != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.success!),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Cargando tus reservas...'),
                ],
              ),
            );
          }

          return TabBarView(
            controller: _tabController,
            children: [
              // Tab de próximas reservas
              _UpcomingReservationsTab(
                reservations: state.upcomingReservations,
                onCancel: _showCancelDialog,
                onTap: _showReservationDetails,
                canBeCancelled: _canBeCancelled,
              ),

              // Tab de reservas pasadas
              _PastReservationsTab(
                reservations: state.pastReservations,
                onTap: _showReservationDetails,
              ),

              // Tab de reservas canceladas
              _CancelledReservationsTab(
                reservations: state.cancelledReservations,
                onTap: _showReservationDetails,
              ),
            ],
          );
        },
      ),
    );
  }

  void _showCancelDialog(Reservation reservation) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Cancelar Reserva'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '¿Estás seguro de que quieres cancelar esta reserva?',
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reservation.placeName ?? 'Restaurante',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(_formatDate(reservation.reservationDate)),
                      Text('${reservation.partySize} personas'),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Mantener'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<MyReservationsCubit>().cancelReservation(
                    reservation.id,
                    'Cancelada por el usuario',
                  );
                },
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Cancelar Reserva'),
              ),
            ],
          ),
    );
  }

  void _showReservationDetails(Reservation reservation) {
    context.router.push(ReservationDetailsRoute(reservationId: reservation.id));
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  bool _canBeCancelled(Reservation reservation) {
    // Una reserva se puede cancelar si está confirmada o pendiente y es futura
    final now = DateTime.now();
    final canCancel =
        (reservation.status == ReservationStatus.confirmed ||
            reservation.status == ReservationStatus.pending) &&
        reservation.reservationDate.isAfter(now);
    return canCancel;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

// Tab para próximas reservas
class _UpcomingReservationsTab extends StatelessWidget {
  final List<Reservation> reservations;
  final Function(Reservation) onCancel;
  final Function(Reservation) onTap;
  final bool Function(Reservation) canBeCancelled;

  const _UpcomingReservationsTab({
    required this.reservations,
    required this.onCancel,
    required this.onTap,
    required this.canBeCancelled,
  });

  @override
  Widget build(BuildContext context) {
    if (reservations.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_busy, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No tienes reservas próximas',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '¡Haz tu próxima reserva ahora!',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        // Refresh logic will be handled by the parent
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: reservations.length,
        itemBuilder: (context, index) {
          final reservation = reservations[index];
          return ReservationCard(
            reservation: reservation,
            showCancelButton: canBeCancelled(reservation),
            onCancel: () => onCancel(reservation),
            onTap: () => onTap(reservation),
          );
        },
      ),
    );
  }
}

// Tab para reservas pasadas
class _PastReservationsTab extends StatelessWidget {
  final List<Reservation> reservations;
  final Function(Reservation) onTap;

  const _PastReservationsTab({required this.reservations, required this.onTap});

  @override
  Widget build(BuildContext context) {
    if (reservations.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No tienes reservas pasadas',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: reservations.length,
      itemBuilder: (context, index) {
        final reservation = reservations[index];
        return ReservationCard(
          reservation: reservation,
          showCancelButton: false,
          onTap: () => onTap(reservation),
        );
      },
    );
  }
}

// Tab para reservas canceladas
class _CancelledReservationsTab extends StatelessWidget {
  final List<Reservation> reservations;
  final Function(Reservation) onTap;

  const _CancelledReservationsTab({
    required this.reservations,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (reservations.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 64, color: Colors.green),
            SizedBox(height: 16),
            Text(
              'No tienes reservas canceladas',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '¡Excelente historial!',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: reservations.length,
      itemBuilder: (context, index) {
        final reservation = reservations[index];
        return ReservationCard(
          reservation: reservation,
          showCancelButton: false,
          onTap: () => onTap(reservation),
        );
      },
    );
  }
}
