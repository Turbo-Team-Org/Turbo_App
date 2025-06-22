import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:core/core.dart';
import 'package:turbo/reservations/state_management/booking_cubit/booking_cubit.dart';
import 'package:turbo/reservations/state_management/booking_cubit/booking_state.dart';
import 'package:turbo/reservations/presentation/widgets/time_slot_card.dart';
import 'package:turbo/reservations/presentation/widgets/booking_calendar.dart';
import 'package:turbo/app/core/theme/app_themes.dart';

@RoutePage()
class BookingPage extends StatefulWidget {
  final String placeId;
  final String placeName;
  final String? placeImage;

  const BookingPage({
    super.key,
    required this.placeId,
    required this.placeName,
    this.placeImage,
  });

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Cargar slots para hoy
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookingCubit>().getAvailableSlotsForDate(
        widget.placeId,
        selectedDate,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservar en ${widget.placeName}'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: BlocConsumer<BookingCubit, BookingState>(
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              // Header con información del lugar
              _buildPlaceHeader(),

              // Calendario de selección de fecha
              _buildDateSelector(state),

              const Divider(height: 1),

              // Lista de horarios disponibles
              Expanded(child: _buildTimeSlotsSection(state)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPlaceHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
      child: Row(
        children: [
          // Imagen del lugar
          if (widget.placeImage != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.placeImage!,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.restaurant, color: Colors.grey),
                  );
                },
              ),
            )
          else
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.restaurant, color: Colors.grey),
            ),

          const SizedBox(width: 16),

          // Información del lugar
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.placeName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Selecciona fecha y horario',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector(BookingState state) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: BookingCalendar(
        selectedDate: selectedDate,
        onDateSelected: (date) {
          setState(() {
            selectedDate = date;
          });
          context.read<BookingCubit>().getAvailableSlotsForDate(
            widget.placeId,
            date,
          );
        },
      ),
    );
  }

  Widget _buildTimeSlotsSection(BookingState state) {
    if (state.isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Cargando horarios disponibles...'),
          ],
        ),
      );
    }

    if (state.availableSlots.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_busy, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'No hay horarios disponibles',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Intenta con otra fecha',
              style: TextStyle(color: Colors.grey.shade500),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                // Sugerir próximas fechas disponibles
                context.read<BookingCubit>().getNextAvailableSlots(
                  widget.placeId,
                );
              },
              icon: const Icon(Icons.search),
              label: const Text('Ver próximas fechas'),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header de horarios
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(Icons.access_time, size: 20),
              const SizedBox(width: 8),
              Text(
                'Horarios disponibles',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Text(
                '${state.availableSlots.length} opciones',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
            ],
          ),
        ),

        // Grid de horarios
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.5,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: state.availableSlots.length,
              itemBuilder: (context, index) {
                final slot = state.availableSlots[index];
                return TimeSlotCard(
                  slot: slot,
                  isSelected: state.selectedSlot == slot,
                  onTap: () => _selectTimeSlot(slot),
                );
              },
            ),
          ),
        ),

        // Botón de continuar
        if (state.selectedSlot != null)
          Container(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _continueToForm(state.selectedSlot!),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Continuar con la reserva'),
              ),
            ),
          ),
      ],
    );
  }

  void _selectTimeSlot(ReservationTimeSlot slot) {
    context.read<BookingCubit>().selectTimeSlot(slot);
  }

  void _continueToForm(ReservationTimeSlot slot) {
    // Navegar al formulario de reserva
    context.router.pushPath(
      '/booking-form?placeId=${widget.placeId}&placeName=${widget.placeName}&selectedDate=${selectedDate.toIso8601String()}',
    );
  }
}
