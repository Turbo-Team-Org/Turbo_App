import 'dart:ui'; // Para ImageFilter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart'; // Importación para inicializar datos de localización
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbo/app/core/theme/text_styles.dart';
import 'package:turbo/app/utils/global/global_vars.dart';
import 'package:turbo/events/event_repository/models/event.dart';
import 'package:turbo/events/state_management/event_bloc/cubit/event_cubit.dart';
import 'package:turbo/places/presentation/screens/business_detail.dart';

class WelcomeEventsDialog extends StatefulWidget {
  final String userName;

  const WelcomeEventsDialog({Key? key, required this.userName})
    : super(key: key);

  @override
  State<WelcomeEventsDialog> createState() => _WelcomeEventsDialogState();
}

class _WelcomeEventsDialogState extends State<WelcomeEventsDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _blurAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _logoScaleAnimation;
  bool _localeInitialized = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _blurAnimation = Tween<double>(begin: 0, end: 15).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 0.7, curve: Curves.easeInOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.1, 0.5, curve: Curves.easeOut),
      ),
    );

    _logoScaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.1, 0.6, curve: Curves.elasticOut),
      ),
    );

    _animationController.forward();

    // Inicializar datos de localización
    initializeDateFormatting('es_ES', null).then((_) {
      if (mounted) {
        setState(() {
          _localeInitialized = true;
        });
      }
    });

    // Cargar eventos al abrir el diálogo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EventCubit>().getTodayEvents();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _getDayGreeting() {
    if (!_localeInitialized) {
      // Fallback si la localización no está inicializada
      final now = DateTime.now();
      final weekday = now.weekday;
      final days = [
        'Lunes',
        'Martes',
        'Miércoles',
        'Jueves',
        'Viernes',
        'Sábado',
        'Domingo',
      ];
      return days[weekday - 1];
    }

    final now = DateTime.now();
    final formatter = DateFormat('EEEE', 'es_ES');
    final dayOfWeek = formatter.format(now);
    return dayOfWeek.substring(0, 1).toUpperCase() + dayOfWeek.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 40,
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Fondo con diálogo perfectamente cuadrado
              Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.8,
                  ),
                  decoration: BoxDecoration(
                    gradient:
                        AppColors.redGradient, // Usando el gradiente de la app
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryRed.withOpacity(0.4),
                        blurRadius: _blurAnimation.value,
                        spreadRadius: 3,
                      ),
                      BoxShadow(
                        color: AppColors.primaryDarkRed.withOpacity(0.3),
                        blurRadius: _blurAnimation.value,
                        spreadRadius: 2,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 20 * _animationController.value,
                        sigmaY: 20 * _animationController.value,
                      ),
                      child: Container(color: Colors.black.withOpacity(0.01)),
                    ),
                  ),
                ),
              ),

              // Contenido del diálogo
              Positioned.fill(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Logo de Turbo (usando el SVG del login)
                        Center(
                          child: Pulse(
                            infinite: true,
                            duration: const Duration(seconds: 4),
                            child: Transform.scale(
                              scale: _logoScaleAnimation.value,
                              child: SvgPicture.asset(
                                turboIconLogIn,
                                height: 35,
                                width: 42,
                                colorFilter: ColorFilter.mode(
                                  Colors.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Título animado con Hola y día de la semana en la misma línea
                        Center(
                          child: FadeInDown(
                            duration: const Duration(milliseconds: 600),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  height: 1.3,
                                ),
                                children: [
                                  const TextSpan(text: '¡Hola, '),
                                  TextSpan(
                                    text: widget.userName.split(' ').first,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 26,
                                    ),
                                  ),
                                  const TextSpan(text: '! Feliz '),
                                  TextSpan(
                                    text: _getDayGreeting(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.white54,
                                      decorationThickness: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Mensaje de eventos
                        FadeInLeft(
                          duration: const Duration(milliseconds: 800),
                          delay: const Duration(milliseconds: 400),
                          child: const Text(
                            'Estos son los eventos y ofertas para hoy:',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Lista de eventos
                        BlocBuilder<EventCubit, EventState>(
                          builder: (context, state) {
                            if (state is EventLoading) {
                              return Center(
                                child: Column(
                                  children: [
                                    SpinPerfect(
                                      infinite: true,
                                      duration: const Duration(seconds: 2),
                                      child: const CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    FadeIn(
                                      child: const Text(
                                        'Cargando eventos...',
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else if (state is TodayEventsLoaded) {
                              if (state.events.isEmpty) {
                                return Center(
                                  child: FadeIn(
                                    duration: const Duration(milliseconds: 600),
                                    delay: const Duration(milliseconds: 600),
                                    child: Column(
                                      children: [
                                        const Icon(
                                          Icons.event_busy,
                                          color: Colors.white70,
                                          size: 80,
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          'No hay eventos para hoy',
                                          style: AppTextStyles.titleSmall(
                                            context,
                                          ).copyWith(color: Colors.white),
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          'Vuelve mañana para descubrir nuevas experiencias',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }

                              return _buildEventsList(state.events);
                            } else if (state is EventError) {
                              return Center(
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.error_outline,
                                      color: Colors.white,
                                      size: 60,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'Error: ${state.message}',
                                      style: const TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    OutlinedButton(
                                      onPressed: () {
                                        context
                                            .read<EventCubit>()
                                            .getTodayEvents();
                                      },
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        foregroundColor: Colors.white,
                                      ),
                                      child: const Text('Reintentar'),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              // Estado inicial, podríamos mostrar un esqueleto o un loader simple
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white54,
                                ),
                              );
                            }
                          },
                        ),

                        const SizedBox(height: 24),

                        // Botón de cierre
                        Center(
                          child: FadeInUp(
                            delay: const Duration(milliseconds: 900),
                            duration: const Duration(milliseconds: 800),
                            child: ElevatedButton(
                              onPressed: () {
                                HapticFeedback.mediumImpact();
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: AppColors.primaryRed,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 8,
                                shadowColor: Colors.black38,
                              ),
                              child: const Text(
                                'Explorar Turbo',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Decoración flotante - Esquina superior
              Positioned(
                top: -15,
                right: -15,
                child: Bounce(
                  infinite: true,
                  duration: const Duration(milliseconds: 2000),
                  child: FadeInDown(
                    duration: const Duration(milliseconds: 1000),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.celebration,
                        color: AppColors.primaryRed,
                        size: 30,
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

  Widget _buildEventsList(List<Event> events) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        // Añadir una animación que escalone las entradas
        return FadeInRight(
          duration: const Duration(milliseconds: 600),
          delay: Duration(milliseconds: 500 + (index * 150)),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildEventCard(event, index),
          ),
        );
      },
    );
  }

  Widget _buildEventCard(Event event, int index) {
    String timeString;
    try {
      final formatter = DateFormat('HH:mm');
      timeString = formatter.format(event.date);
    } catch (e) {
      // En caso de error, formatear manualmente
      final date = event.date;
      timeString =
          '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    }

    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        // Si el evento tiene un placeId asociado, navegamos al detalle
        if (event.placeId != null) {
          Navigator.of(context).pop(); // Cerramos el diálogo
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BusinessDetailsScreen(id: event.placeId!),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Imagen del evento con animación de brillo
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.5),
                        ],
                      ).createShader(rect);
                    },
                    blendMode: BlendMode.darken,
                    child: Image.network(
                      event.imageUrl,
                      width: 100,
                      height: 110,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 100,
                          height: 110,
                          color: Colors.grey[800],
                          child: const Icon(
                            Icons.image_not_supported,
                            color: Colors.white60,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Agregar un efecto de brillo para destacar
                if (event.isHighlighted)
                  Positioned.fill(
                    child: FlipInY(
                      delay: Duration(milliseconds: 800 + (index * 100)),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.star,
                            color: Colors.amber[300],
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // Contenido del evento
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Título
                        Expanded(
                          child: Text(
                            event.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        // Indicador de tipo
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getEventTypeColor(event.type),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _getEventTypeLabel(event.type),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // Descripción corta
                    Text(
                      event.description,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),

                    // Detalles de hora y ubicación
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: Colors.white70,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          timeString,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.white70,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  event.location,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Si es un evento destacado, mostrar un indicador
                    if (event.isHighlighted) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber[300], size: 14),
                          const SizedBox(width: 4),
                          const Text(
                            'Destacado',
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getEventTypeColor(EventType type) {
    switch (type) {
      case EventType.party:
        return Colors.deepPurple;
      case EventType.concert:
        return Colors.blue;
      case EventType.promotion:
        return Colors.orange;
      case EventType.cultural:
        return Colors.teal;
      case EventType.offer:
        return Colors.green;
    }
  }

  String _getEventTypeLabel(EventType type) {
    switch (type) {
      case EventType.party:
        return 'FIESTA';
      case EventType.concert:
        return 'CONCIERTO';
      case EventType.promotion:
        return 'PROMO';
      case EventType.cultural:
        return 'CULTURAL';
      case EventType.offer:
        return 'OFERTA';
    }
  }
}

// Método para mostrar el diálogo en cualquier parte de la app
void showWelcomeEventsDialog(BuildContext context, String userName) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Dismiss',
    barrierColor: Colors.black.withOpacity(0.6),
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, animation1, animation2) {
      return WelcomeEventsDialog(userName: userName);
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          child: child,
        ),
      );
    },
  );
}
