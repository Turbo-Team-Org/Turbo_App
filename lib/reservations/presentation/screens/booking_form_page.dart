import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:core/core.dart';
import 'package:turbo/reservations/state_management/booking_form_cubit/booking_form_cubit.dart';
import 'package:turbo/reservations/state_management/booking_form_cubit/booking_form_state.dart';
import 'package:turbo/reservations/presentation/widgets/reservation_summary_card.dart';
import 'package:turbo/authentication/presentation/widgets/custom_textfield.dart';

@RoutePage()
class BookingFormPage extends StatefulWidget {
  final String placeId;
  final String placeName;
  final DateTime selectedDate;
  final ReservationTimeSlot selectedSlot;

  const BookingFormPage({
    super.key,
    required this.placeId,
    required this.placeName,
    required this.selectedDate,
    required this.selectedSlot,
  });

  @override
  State<BookingFormPage> createState() => _BookingFormPageState();
}

class _BookingFormPageState extends State<BookingFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _specialRequestsController = TextEditingController();

  int _partySize = 2;

  @override
  void initState() {
    super.initState();
    _prefillUserData();
  }

  void _prefillUserData() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _nameController.text = user.displayName ?? '';
      _emailController.text = user.email ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmar Reserva'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocListener<BookingFormCubit, BookingFormState>(
        listener: (context, state) {
          if (state.success && state.createdReservation != null) {
            // Navegar a página de confirmación
            context.router.pushPath(
              '/reservation-details/${state.createdReservation!.id}',
            );
          } else if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Column(
          children: [
            // Resumen de la reserva
            ReservationSummaryCard(
              placeName: widget.placeName,
              selectedDate: widget.selectedDate,
              selectedSlot: widget.selectedSlot,
              partySize: _partySize,
            ),

            // Formulario
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Selector de número de personas
                      _buildPartySizeSelector(),

                      const SizedBox(height: 24),

                      // Información del cliente
                      Text(
                        'Información de contacto',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),

                      const SizedBox(height: 16),

                      // Nombre
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Nombre completo',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'El nombre es requerido';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Email
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Correo electrónico',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'El correo es requerido';
                          }
                          if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value!)) {
                            return 'Correo inválido';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Teléfono
                      TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          labelText: 'Número de teléfono',
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'El teléfono es requerido';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 24),

                      // Solicitudes especiales
                      Text(
                        'Solicitudes especiales (opcional)',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),

                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _specialRequestsController,
                        decoration: InputDecoration(
                          hintText:
                              'Ej: Mesa cerca de la ventana, celebración especial...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                        ),
                        maxLines: 3,
                        maxLength: 200,
                      ),

                      const SizedBox(height: 32),

                      // Política de cancelación
                      _buildCancellationPolicy(),
                    ],
                  ),
                ),
              ),
            ),

            // Botón de confirmar
            _buildConfirmButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPartySizeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '¿Para cuántas personas?',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),

        const SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              const Icon(Icons.people, color: Colors.grey),
              const SizedBox(width: 16),
              const Text('Número de personas:'),
              const Spacer(),

              // Botón menos
              IconButton(
                onPressed:
                    _partySize > 1 ? () => setState(() => _partySize--) : null,
                icon: const Icon(Icons.remove_circle_outline),
                color:
                    _partySize > 1
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey,
              ),

              // Contador
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$_partySize',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Botón más
              IconButton(
                onPressed:
                    _partySize < 12 ? () => setState(() => _partySize++) : null,
                icon: const Icon(Icons.add_circle_outline),
                color:
                    _partySize < 12
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCancellationPolicy() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: Colors.blue.shade700, size: 20),
              const SizedBox(width: 8),
              Text(
                'Política de cancelación',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Puedes cancelar tu reserva hasta 2 horas antes del horario programado sin costo alguno.',
            style: TextStyle(color: Colors.blue.shade600, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BlocBuilder<BookingFormCubit, BookingFormState>(
        builder: (context, state) {
          return SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: state.isCreating ? null : _confirmReservation,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child:
                  state.isCreating
                      ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 12),
                          Text('Confirmando reserva...'),
                        ],
                      )
                      : const Text('Confirmar Reserva'),
            ),
          );
        },
      ),
    );
  }

  void _confirmReservation() {
    if (_formKey.currentState!.validate()) {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Debes iniciar sesión para hacer una reserva'),
          ),
        );
        return;
      }

      context.read<BookingFormCubit>().createReservation(
        placeId: widget.placeId,
        userId: user.uid,
        startTime: widget.selectedSlot.startTime,
        endTime: widget.selectedSlot.endTime,
        partySize: _partySize,
        customerName: _nameController.text.trim(),
        customerEmail: _emailController.text.trim(),
        customerPhone: _phoneController.text.trim(),
        specialRequests:
            _specialRequestsController.text.trim().isNotEmpty
                ? _specialRequestsController.text.trim()
                : null,
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _specialRequestsController.dispose();
    super.dispose();
  }
}
