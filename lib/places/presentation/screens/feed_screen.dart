import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turbo/app/core/theme/text_styles.dart';
import 'package:turbo/app/core/theme/theme_cubit.dart';
import 'package:turbo/app/utils/app_preferences.dart';
import 'package:turbo/app/utils/theme/style.dart';
import 'package:turbo/authentication/state_managament/auth_cubit/cubit/auth_cubit_cubit.dart';
import 'package:turbo/categories/state_management/category_bloc/category_cubit/cubit/category_cubit.dart';
import 'package:turbo/favorites/state_management/cubit/favorite_cubit.dart';
import 'package:turbo/location/location_repository/models/location_data.dart';
import 'package:turbo/location/state_management/location_bloc/cubit/location_cubit.dart';
import 'package:turbo/places/place_repository/models/place/place.dart';
import 'package:turbo/places/presentation/screens/business_detail.dart';
import 'package:turbo/places/state_management/place_bloc/cubit/place_cubit.dart';
import 'package:turbo/events/presentation/widgets/welcome_events_dialog.dart';
import 'package:intl/intl.dart';

const _lastWelcomeDialogShownDateKey = 'last_welcome_dialog_shown_date';

@RoutePage()
class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  bool _isHeaderCollapsed = false;
  final prefs = AppPreferences();
  bool _locationPermissionRequested = false;

  // Controlador para la animación de pulsación en las tarjetas
  late Map<String, AnimationController> _cardAnimationControllers = {};

  // Controlador para la animación del search bar
  late AnimationController _searchAnimationController;
  late Animation<double> _searchScaleAnimation;

  // Ubicación actual del usuario
  LocationData? _currentLocation;

  final List<String> _categories = [
    'Restaurantes',
    'Bares',
    'Hoteles',
    'Cafeterías',
    'Bodegones',
    'Tiendas',
    'Centros Recreativos',
    'Museos',
    'Gimnasios',
    'Barberías',
    'Salones de Belleza',

    'Eventos de Fiestas',
  ];

  @override
  void initState() {
    super.initState();
    // Inicializar con un valor seguro
    _tabController = TabController(length: 1, vsync: this);

    // Agregar listener para cambios de pestaña
    _tabController.addListener(() {
      // Esto puede ayudar a detectar errores de selección
      if (_tabController.indexIsChanging) {
        print('Cambiando a tab: ${_tabController.index}');
      }
    });

    // Configurar animación para la barra de búsqueda
    _searchAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _searchScaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(
        parent: _searchAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    // Añadir listener para detectar scroll
    _scrollController.addListener(_onScroll);

    // Verificar permisos de localización al iniciar
    _checkLocationPermission();

    // Mostrar el diálogo de bienvenida después de un breve retardo
    _showWelcomeDialogIfNeeded();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();

    // Disponer del controlador de animación de la barra de búsqueda
    _searchAnimationController.dispose();

    // Disponer de todos los controladores de animación de tarjetas
    for (var controller in _cardAnimationControllers.values) {
      controller.dispose();
    }
    _cardAnimationControllers.clear();

    super.dispose();
  }

  void _onScroll() {
    final isCollapsed = _scrollController.offset > 180;
    if (isCollapsed != _isHeaderCollapsed) {
      setState(() {
        _isHeaderCollapsed = isCollapsed;
      });
    }
  }

  Future<void> _checkLocationPermission() async {
    final prefs = await SharedPreferences.getInstance();
    _locationPermissionRequested =
        prefs.getBool('location_permission_requested') ?? false;

    if (!_locationPermissionRequested) {
      // Esperar un momento para que la UI se cargue completamente
      Future.delayed(const Duration(seconds: 2), () {
        _requestLocationPermission();
      });
    } else {
      // Si ya se solicitó permiso anteriormente, intentamos obtener la ubicación actual
      context.read<LocationCubit>().getCurrentLocation();
    }
  }

  Future<void> _requestLocationPermission() async {
    // Mostrar diálogo para solicitar permiso
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text('Acceso a ubicación'),
            content: const Text(
              'Turbo necesita acceder a tu ubicación para mostrarte lugares cercanos. '
              '¿Permitir acceso a tu ubicación?',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _markPermissionAsRequested();
                },
                child: const Text('Ahora no'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _markPermissionAsRequested();
                  context.read<LocationCubit>().requestLocationPermission();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Styles.turboRed,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Permitir'),
              ),
            ],
          ),
    );
  }

  Future<void> _markPermissionAsRequested() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('location_permission_requested', true);
    _locationPermissionRequested = true;
  }

  Future<void> _showWelcomeDialogIfNeeded() async {
    // Esperar un momento para que la UI inicial cargue
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final lastShownDate = prefs.getString(_lastWelcomeDialogShownDateKey);

    print('Hoy: $today, Última vez mostrado: $lastShownDate'); // Debug

    if (lastShownDate != today) {
      // Obtener el nombre del usuario actual
      final authState = context.read<AuthCubit>().state;
      String userName = 'Aventurero'; // Nombre por defecto
      if (authState is Authenticated) {
        userName = authState.user.displayName?.split(' ').first ?? 'Aventurero';
      }

      // Mostrar el diálogo
      if (mounted) {
        print('Mostrando diálogo de bienvenida...'); // Debug
        showWelcomeEventsDialog(context, userName);
        // Guardar la fecha actual
        await prefs.setString(_lastWelcomeDialogShownDateKey, today);
        print('Fecha guardada: $today'); // Debug
      }
    } else {
      print('Diálogo ya mostrado hoy.'); // Debug
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.backgroundLight, AppColors.backgroundWhite],
            stops: [0.0, 0.3],
          ),
        ),
        child: BlocListener<LocationCubit, LocationState>(
          listener: (context, state) {
            print("LocationCubit cambió a estado: $state");
            if (state is LocationObtained) {
              setState(() {
                _currentLocation = state.location;
              });
              // Obtenemos lugares después de obtener la ubicación
              context.read<PlaceCubit>().getPlaces();
            } else if (state is LocationError) {
              // Mostrar un mensaje de error, pero seguir intentando cargar los lugares
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Error al obtener ubicación: ${state.message}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
              // Intentar cargar lugares de todos modos
              context.read<PlaceCubit>().getPlaces();
            } else if (state is LocationPermissionGranted) {
              // Cuando se otorga el permiso, solicitar la ubicación
              context.read<LocationCubit>().getCurrentLocation();
            } else if (state is LocationPermissionDenied) {
              // Mostrar mensaje y cargar lugares sin filtro de ubicación
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Ubicación no disponible. Mostrando todos los lugares.',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.orange,
                ),
              );
              context.read<PlaceCubit>().getPlaces();
            }
          },
          child: BlocConsumer<PlaceCubit, PlaceState>(
            listener: (context, placeState) {
              if (placeState is PlacesError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error: ${placeState.error}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, placeState) {
              return BlocBuilder<FavoriteCubit, FavoriteState>(
                builder: (context, favoriteState) {
                  return RefreshIndicator(
                    color: AppColors.primaryRed,
                    onRefresh: () async {
                      await context.read<PlaceCubit>().getPlaces();
                      // También actualizar ubicación al hacer pull-to-refresh
                      context.read<LocationCubit>().getCurrentLocation();
                    },
                    child: CustomScrollView(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        _buildAppBar(context),
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              _buildWelcomeSection(),
                              _buildSearchBar(),
                              _buildCategoryTabs(),
                              _buildPromoSection(),
                            ],
                          ),
                        ),
                        _buildPlacesList(context, placeState, favoriteState),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 70,
      floating: true,
      pinned: true,
      snap: false,
      elevation: _isHeaderCollapsed ? 4 : 0,
      backgroundColor:
          _isHeaderCollapsed
              ? Theme.of(context).colorScheme.surface
              : Colors.transparent,
      centerTitle: false,
      leading: BlocBuilder<AuthCubit, AuthCubitState>(
        builder: (context, state) {
          String profileImageUrl = "";

          if (state is Authenticated) {
            profileImageUrl = state.user.photoUrl ?? '';

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: AppColors.primaryRed.withOpacity(0.1),
                backgroundImage:
                    profileImageUrl.isNotEmpty
                        ? NetworkImage(profileImageUrl)
                        : null,
                child:
                    profileImageUrl.isEmpty
                        ? Text(
                          state.user.displayName?.isNotEmpty ?? false
                              ? state.user.displayName![0].toUpperCase()
                              : "T",
                          style: TextStyle(
                            color: AppColors.primaryRed,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                        : null,
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      title:
          _isHeaderCollapsed
              ? ElasticIn(
                duration: const Duration(milliseconds: 400),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryRed.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.explore_outlined,
                        color: AppColors.primaryRed,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Turbo',
                      style: TextStyle(
                        color: AppColors.primaryRed,
                        fontWeight: FontWeight.bold,
                        fontSize: AppTextStyles.fontSizeLg,
                      ),
                    ),
                  ],
                ),
              )
              : null,
      actions: [
        IconButton(
          icon: Icon(
            Icons.notifications_outlined,
            color: _isHeaderCollapsed ? AppColors.primaryRed : Colors.white,
            size: 26,
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Notificaciones no implementadas aún',
                  style: AppTextStyles.bodyMedium(
                    context,
                  ).copyWith(color: Colors.white),
                ),
                backgroundColor: AppColors.primaryDarkRed,
                duration: const Duration(seconds: 2),
              ),
            );
          },
        ),
        IconButton(
          icon: BlocBuilder<ThemeCubit, dynamic>(
            builder: (context, state) {
              return Icon(
                state?.isDarkMode ?? false ? Icons.light_mode : Icons.dark_mode,
                color: _isHeaderCollapsed ? AppColors.primaryRed : Colors.white,
                size: 26,
              );
            },
          ),
          onPressed: () {
            context.read<ThemeCubit>().toggleDarkMode();
          },
        ),
        const SizedBox(width: 8),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background:
            _isHeaderCollapsed
                ? null
                : Container(
                  decoration: const BoxDecoration(
                    gradient: AppColors.redGradient,
                  ),
                  height: 100,
                ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    // Lista de categorías rápidas para el carousel
    final quickCategories = [
      {
        'icon': Icons.local_fire_department_rounded,
        'label': 'Popular',
        'color': Styles.turboRed,
      },
      {
        'icon': Icons.favorite_rounded,
        'label': 'Favoritos',
        'color': Styles.turboRed,
      },
      {
        'icon': Icons.trending_up_rounded,
        'label': 'Trending',
        'color': Styles.turboRed,
      },
      {
        'icon': Icons.monetization_on_rounded,
        'label': 'Buen Precio',
        'color': Styles.turboRed,
      },
      {
        'icon': Icons.star_rounded,
        'label': 'Top Rated',
        'color': Styles.turboRed,
      },
      {
        'icon': Icons.comment_rounded,
        'label': 'Reseñas',
        'color': Styles.turboRed,
      },
      {
        'icon': Icons.local_dining_rounded,
        'label': 'Comida',
        'color': Styles.turboRed,
      },
      {
        'icon': Icons.local_bar_rounded,
        'label': 'Bebidas',
        'color': Styles.turboRed,
      },
      {
        'icon': Icons.discount_rounded,
        'label': 'Ofertas',
        'color': Styles.turboRed,
      },
      {
        'icon': Icons.location_on_rounded,
        'label': 'Cerca',
        'color': Styles.turboRed,
      },
    ];

    return FadeInDown(
      duration: const Duration(milliseconds: 700),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primaryRed, AppColors.primaryDarkRed],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryRed.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<AuthCubit, AuthCubitState>(
                  builder: (context, state) {
                    String displayName = "";

                    if (state is Authenticated) {
                      displayName = state.user.displayName!;
                    }

                    return Text(
                      '¡Hola, ${displayName.split(' ').first}!',
                      style: AppTextStyles.titleMedium(context).copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
                // Indicador sutil para mostrar que hay más categorías
                ShakeX(
                  infinite: true,
                  duration: const Duration(milliseconds: 3000),
                  from: 3,
                  child: Icon(
                    Icons.keyboard_double_arrow_right_rounded,
                    color: Colors.white.withOpacity(0.7),
                    size: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Descubre los mejores lugares en Cuba',
              style: AppTextStyles.bodyLarge(
                context,
              ).copyWith(color: Colors.white.withOpacity(0.9)),
            ),
            const SizedBox(height: 25),

            // Nuevo carrusel horizontal de categorías mejorado
            SizedBox(
              height: 110,
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.white.withOpacity(0.8),
                      Colors.white,
                      Colors.white,
                      Colors.white.withOpacity(0.8),
                    ],
                    stops: const [0.0, 0.1, 0.9, 1.0],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstIn,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: quickCategories.length,
                  itemBuilder: (context, index) {
                    final category = quickCategories[index];
                    // Animación con diferentes efectos para cada elemento
                    return index % 2 == 0
                        ? FadeInUp(
                          duration: const Duration(milliseconds: 800),
                          delay: Duration(milliseconds: 100 * index),
                          child: _buildAnimatedCategoryButton(
                            category['icon'] as IconData,
                            category['label'] as String,
                            category['color'] as Color,
                            index,
                          ),
                        )
                        : FadeInDown(
                          duration: const Duration(milliseconds: 800),
                          delay: Duration(milliseconds: 100 * index),
                          child: _buildAnimatedCategoryButton(
                            category['icon'] as IconData,
                            category['label'] as String,
                            category['color'] as Color,
                            index,
                          ),
                        );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Botones de categoría mejorados con mejor diseño y animación
  Widget _buildAnimatedCategoryButton(
    IconData icon,
    String label,
    Color color,
    int index,
  ) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      width: 85,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Efecto haptico
            HapticFeedback.mediumImpact();

            // Si es una categoría válida, cambiar a esa pestaña
            if (index < _tabController.length) {
              _tabController.animateTo(index);
              // Scroll hacia arriba para mostrar los resultados
              _scrollController.animateTo(
                250, // Posición aproximada después del header
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutQuint,
              );
            }
          },
          splashColor: color.withOpacity(0.4),
          highlightColor: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
          child: Ink(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  spreadRadius: 0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icono más grande con efecto de opacidad
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    shape: BoxShape.circle,
                    border: Border.all(color: color.withOpacity(0.3), width: 2),
                  ),
                  child: Icon(icon, color: Colors.white, size: 30),
                ),
                const SizedBox(height: 8),
                // Texto más claro y legible
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                    height: 1.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return FadeInUp(
      duration: const Duration(milliseconds: 700),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
        child: GestureDetector(
          onTapDown: (_) {
            _searchAnimationController.forward();
          },
          onTapUp: (_) {
            _searchAnimationController.reverse();

            // Efecto haptico sutil
            HapticFeedback.lightImpact();

            // Implementar búsqueda
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Búsqueda no implementada aún',
                  style: AppTextStyles.bodyMedium(
                    context,
                  ).copyWith(color: Colors.white),
                ),
                backgroundColor: AppColors.primaryDarkRed,
                duration: const Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.all(16),
              ),
            );
          },
          onTapCancel: () {
            _searchAnimationController.reverse();
          },
          child: AnimatedBuilder(
            animation: _searchScaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _searchScaleAnimation.value,
                child: child,
              );
            },
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  // Sombra principal - más pronunciada
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    offset: const Offset(0, 6),
                    blurRadius: 14,
                    spreadRadius: 0,
                  ),
                  // Sombra secundaria con toque de color
                  BoxShadow(
                    color: AppColors.primaryRed.withOpacity(0.08),
                    offset: const Offset(0, 3),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                  // Sombra de brillo superior
                  BoxShadow(
                    color: Colors.white.withOpacity(0.9),
                    offset: const Offset(0, -2),
                    blurRadius: 4,
                    spreadRadius: 0,
                  ),
                ],
                // Gradiente sutil que da sensación de volumen
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, Theme.of(context).colorScheme.surface],
                  stops: const [0.1, 1.0],
                ),
                border: Border.all(
                  color: Colors.white.withOpacity(0.6),
                  width: 1.2,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: AppColors.primaryRed.withOpacity(0.12),
                  highlightColor: AppColors.primaryRed.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(28),
                  onTap:
                      () {}, // Vacío porque manejamos el tap en el GestureDetector
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Icon(
                          Icons.search_rounded,
                          color: AppColors.primaryRed,
                          size: 24,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            'Buscar lugares, ofertas, etc...',
                            style: AppTextStyles.bodyMedium(context).copyWith(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryRed.withOpacity(0.08),
                          shape: BoxShape.circle,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          shape: const CircleBorder(),
                          clipBehavior: Clip.antiAlias,
                          child: IconButton(
                            icon: const Icon(
                              Icons.mic_rounded,
                              size: 22,
                              color: AppColors.primaryRed,
                            ),
                            onPressed: () {
                              HapticFeedback.mediumImpact();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Búsqueda por voz no implementada aún',
                                    style: AppTextStyles.bodyMedium(
                                      context,
                                    ).copyWith(color: Colors.white),
                                  ),
                                  backgroundColor: AppColors.primaryDarkRed,
                                  duration: const Duration(seconds: 2),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  margin: const EdgeInsets.all(16),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: FadeInUp(
        duration: const Duration(milliseconds: 600),
        child: Column(
          children: [
            BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, state) {
                if (state is CategoryInitial) {
                  // Cargar categorías si aún no se han cargado
                  context.read<CategoryCubit>().loadCategories();
                  return SizedBox(
                    height: 48, // Altura estándar para TabBar
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                        strokeWidth: 2,
                      ),
                    ),
                  );
                }

                if (state is CategoryLoaded) {
                  final int requiredLength = state.categories.length + 1;

                  // Verificar si necesitamos actualizar el TabController
                  if (_tabController.length != requiredLength) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      // Actualizar en el siguiente frame para evitar errores
                      if (mounted) {
                        setState(() {
                          // Primero desechamos el controlador anterior
                          _tabController.dispose();

                          // Creamos uno nuevo con la longitud correcta
                          _tabController = TabController(
                            length: requiredLength,
                            vsync: this,
                          );
                        });
                      }
                    });

                    // Mientras tanto, mostrar un indicador de carga
                    return SizedBox(
                      height: 48, // Altura estándar para TabBar
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  }

                  // Si el controlador ya tiene la longitud correcta, mostrar el TabBar
                  return TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    indicatorColor: Colors.red,
                    indicatorWeight: 3,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    labelColor: Colors.red,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      const Tab(text: 'Todos'),
                      ...state.categories.map(
                        (category) => Tab(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (category.icon.isNotEmpty &&
                                  int.tryParse(category.icon) != null)
                                Icon(
                                  IconData(
                                    int.tryParse(category.icon) ?? 0xe5d3,
                                    fontFamily: 'MaterialIcons',
                                  ),
                                  size: 20,
                                ),
                              if (category.icon.isNotEmpty &&
                                  int.tryParse(category.icon) != null)
                                const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  category.name,
                                  style: const TextStyle(
                                    fontFamily:
                                        'Roboto', // Usar fuente segura en lugar de MuseoSans
                                    fontSize: 14,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return SizedBox(
                  height: 48, // Altura estándar para TabBar
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                      strokeWidth: 2,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlacesList(
    BuildContext context,
    PlaceState placeState,
    FavoriteState favoriteState,
  ) {
    switch (placeState) {
      case PlacesInitial():
      case PlacesLoading():
        return SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxHeight: 100),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CircularProgressIndicator(color: Colors.red, strokeWidth: 3),
                  SizedBox(height: 12),
                  Text(
                    'Cargando...',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );

      case PlacesLoaded():
        final places = placeState.places;

        // Filtrar lugares según la pestaña seleccionada
        var filteredPlaces = places;
        final selectedTab = _tabController.index;

        if (selectedTab == 1) {
          // Mejores Ofertas - lugares con ofertas
          filteredPlaces =
              places.where((place) => place.offers.isNotEmpty).toList();
        } else if (selectedTab == 2) {
          // Trending - lugares con mejor rating
          filteredPlaces = places.where((place) => place.rating >= 4).toList();
        } else if (selectedTab == 3) {
          // Precio-Calidad - lugares con precio moderado
          filteredPlaces =
              places.where((place) => place.averagePrice <= 25).toList();
        } else if (selectedTab == 9) {
          // Cercanos - lugares cerca del usuario (último índice en quickCategories)
          if (_currentLocation != null) {
            // Si tenemos la ubicación, filtrar por cercanía
            // Aquí se podría implementar un algoritmo más sofisticado de distancia
            // Por ahora, simplemente mostramos los primeros 5 lugares como ejemplo
            filteredPlaces = places.take(5).toList();
          }
        }

        if (filteredPlaces.isEmpty) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxHeight: 150),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 48,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'No hay lugares disponibles',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Intenta con otra búsqueda',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 80),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.70,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              final place = filteredPlaces[index];
              return _buildPlaceCard(context, place, favoriteState, index);
            }, childCount: filteredPlaces.length),
          ),
        );

      case PlacesError():
        return SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxHeight: 150),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error, size: 48, color: Colors.red),
                  const SizedBox(height: 12),
                  Text(
                    'Error: ${placeState.error}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => context.read<PlaceCubit>().getPlaces(),
                    icon: const Icon(Icons.refresh, size: 16),
                    label: const Text('Reintentar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(120, 36),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
    }
  }

  Widget _buildPlaceCard(
    BuildContext context,
    Place place,
    FavoriteState favoriteState,
    int index,
  ) {
    bool isFavorite = false;

    switch (favoriteState) {
      case FavoriteLoaded():
        isFavorite = favoriteState.favorites.any(
          (favorite) => favorite.placeId == place.id,
        );
        break;
      default:
        isFavorite = false;
    }

    // Creamos un controlador de animación para esta tarjeta si no existe
    if (!_cardAnimationControllers.containsKey(place.id)) {
      _cardAnimationControllers[place.id] = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 150),
      );
    }

    final controller = _cardAnimationControllers[place.id]!;

    // Animación de escala para el efecto "push"
    final Animation<double> scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    return GestureDetector(
      onTapDown: (_) {
        // Iniciamos la animación de "presionar" cuando se toca
        controller.forward();
      },
      onTapCancel: () {
        // Revertimos la animación si se cancela el tap
        controller.reverse();
      },
      onTapUp: (_) {
        // Revertimos la animación y navegamos cuando se completa el tap
        controller.reverse().then((_) {
          // Añadir vibración al tocar
          HapticFeedback.mediumImpact();

          // Navegación con PageRouteBuilder personalizado para mejorar la animación del Hero
          Navigator.of(context).push(
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 700),
              reverseTransitionDuration: const Duration(milliseconds: 500),
              pageBuilder: (context, animation, secondaryAnimation) {
                return FadeTransition(
                  opacity: animation,
                  child: BusinessDetailsScreen(id: place.id),
                );
              },
              // Aplicamos una curva personalizada para que la transición sea más elegante
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
                // Usamos CurvedAnimation para una experiencia más suave
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                  reverseCurve: Curves.easeInCubic,
                );

                // El Hero ya se encarga de la animación de la imagen, solo agregamos efecto al resto
                return child;
              },
            ),
          );
        });
      },
      child: AnimatedBuilder(
        animation: scaleAnimation,
        builder: (context, child) {
          return Transform.scale(scale: scaleAnimation.value, child: child);
        },
        child: FadeInUp(
          delay: Duration(milliseconds: 100 * (index % 6)),
          duration: const Duration(milliseconds: 600),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.primaryRed.withOpacity(0.1),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    // Imagen del lugar con efecto de héroe para animación
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Hero(
                        tag: 'place_image_${place.id}',
                        child: AspectRatio(
                          aspectRatio: 1.2,
                          child: Image.network(
                            place.mainImage.isNotEmpty
                                ? place.mainImage
                                : (place.imageUrls.isNotEmpty
                                    ? place.imageUrls.first
                                    : 'https://via.placeholder.com/400'),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                child: const Icon(
                                  Icons.image_not_supported,
                                  size: 50,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),

                    // Botón de favorito con nuevo diseño
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            final cubit = context.read<FavoriteCubit>();
                            final authState = context.read<AuthCubit>().state;
                            if (authState is Authenticated) {
                              cubit.toggleFavorite(
                                userId: authState.user.uid,
                                placeId: place.id,
                              );
                            }
                          },
                          customBorder: const CircleBorder(),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color:
                                  isFavorite
                                      ? AppColors.primaryRed
                                      : Colors.grey.shade600,
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Badge de "Abierto" con nuevo estilo
                    if (place.isOpen)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                spreadRadius: 1,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'ABIERTO',
                                style: TextStyle(
                                  color: Colors.green.shade800,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place.name,
                        style: AppTextStyles.bodyLarge(context).copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryRed,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: AppColors.primaryRed,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              place.address,
                              style: AppTextStyles.bodyMedium(context),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                place.rating.toStringAsFixed(1),
                                style: AppTextStyles.bodyMedium(
                                  context,
                                ).copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryRed,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '\$${place.averagePrice.toStringAsFixed(0)}',
                              style: AppTextStyles.bodyMedium(context).copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPromoSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      child: FadeInUp(
        duration: const Duration(milliseconds: 800),
        child: Container(
          width: double.infinity,
          height: 190,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: AppColors.purpleGradient,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF8E2DE2).withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                right: -20,
                bottom: -20,
                child: Icon(
                  Icons.beach_access,
                  size: 150,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "¡Oferta especial!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Disfruta 20% de descuento en tours por La Habana",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF8E2DE2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      child: const Text(
                        "Ver Oferta",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
