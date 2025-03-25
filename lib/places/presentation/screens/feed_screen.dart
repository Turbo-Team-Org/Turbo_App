import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turbo/app/core/theme/text_styles.dart';
import 'package:turbo/app/core/theme/theme_cubit.dart';
import 'package:turbo/app/routes/router/app_router.gr.dart';
import 'package:turbo/app/routes/transitions/custom_page_transitions.dart';
import 'package:turbo/app/utils/app_preferences.dart';
import 'package:turbo/authentication/state_managament/auth_cubit/cubit/auth_cubit_cubit.dart';
import 'package:turbo/favorites/state_management/cubit/favorite_cubit.dart';
import 'package:turbo/places/place_repository/models/place/place.dart';
import 'package:turbo/places/presentation/screens/business_detail.dart';
import 'package:turbo/places/state_management/place_bloc/cubit/place_cubit.dart';
import '../widgets/feed_widgets.dart';
import 'package:turbo/app/core/theme/app_theme_switch.dart';

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

  // Controlador para la animación de pulsación en las tarjetas
  late Map<String, AnimationController> _cardAnimationControllers = {};

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
    _tabController = TabController(length: _categories.length, vsync: this);

    // Añadir listener para detectar scroll
    _scrollController.addListener(_onScroll);

    // Cargar datos del usuario
    //_loadUserData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();

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
        child: BlocBuilder<PlaceCubit, PlaceState>(
          builder: (context, placeState) {
            return BlocBuilder<FavoriteCubit, FavoriteState>(
              builder: (context, favoriteState) {
                return RefreshIndicator(
                  color: AppColors.primaryRed,
                  onRefresh: () async {
                    await context.read<PlaceCubit>().getPlaces();
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
        'color': Colors.orangeAccent,
      },
      {
        'icon': Icons.favorite_rounded,
        'label': 'Favoritos',
        'color': Colors.redAccent,
      },
      {
        'icon': Icons.trending_up_rounded,
        'label': 'Trending',
        'color': Colors.purpleAccent,
      },
      {
        'icon': Icons.monetization_on_rounded,
        'label': 'Buen Precio',
        'color': Colors.greenAccent,
      },
      {
        'icon': Icons.star_rounded,
        'label': 'Top Rated',
        'color': Colors.amberAccent,
      },
      {
        'icon': Icons.comment_rounded,
        'label': 'Reseñas',
        'color': Colors.blueAccent,
      },
      {
        'icon': Icons.local_dining_rounded,
        'label': 'Comida',
        'color': Colors.tealAccent,
      },
      {
        'icon': Icons.local_bar_rounded,
        'label': 'Bebidas',
        'color': Colors.deepOrangeAccent,
      },
      {
        'icon': Icons.discount_rounded,
        'label': 'Ofertas',
        'color': Colors.pinkAccent,
      },
      {
        'icon': Icons.location_on_rounded,
        'label': 'Cerca',
        'color': Colors.cyanAccent,
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
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.surface,
                AppColors.primaryRed.withOpacity(0.05),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            style: AppTextStyles.bodyLarge(context),
            decoration: InputDecoration(
              hintText: 'Buscar lugares, ofertas, etc...',
              hintStyle: AppTextStyles.bodyMedium(context).copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: AppColors.primaryRed,
                size: 26,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),
            ),
            onTap: () {
              // Implementar búsqueda
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Búsqueda no implementada aún',
                    style: AppTextStyles.bodyMedium(
                      context,
                    ).copyWith(color: Colors.white),
                  ),
                  //  backgroundColor: AppColors.primaryDarkRed,
                  duration: const Duration(seconds: 2),
                ),
              );
            },
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
            Material(
              color: Colors.transparent,
              elevation: 0,
              child: Container(
                margin: const EdgeInsets.only(bottom: 1),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      AppColors.primaryRed.withOpacity(0.05),
                      Colors.transparent,
                      AppColors.primaryRed.withOpacity(0.05),
                    ],
                  ),
                ),
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  indicatorColor: AppColors.primaryRed,
                  indicatorWeight: 3,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  labelColor: AppColors.primaryRed,
                  unselectedLabelColor: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.7),
                  labelStyle: AppTextStyles.bodyLarge(
                    context,
                  ).copyWith(fontWeight: FontWeight.bold),
                  unselectedLabelStyle: AppTextStyles.bodyLarge(context),
                  tabs:
                      _categories
                          .map((category) => Tab(text: category))
                          .toList(),
                  onTap: (index) {
                    // Efecto de vibración suave al cambiar de tab
                    HapticFeedback.lightImpact();
                  },
                ),
              ),
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  color: AppColors.primaryRed,
                  strokeWidth: 3,
                ),
                const SizedBox(height: 16),
                Text(
                  'Cargando lugares increíbles...',
                  style: AppTextStyles.bodyLarge(context),
                ),
              ],
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
        }

        if (filteredPlaces.isEmpty) {
          return SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off,
                    size: 64,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No hay lugares disponibles',
                    style: AppTextStyles.titleSmall(context),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Intenta con otra búsqueda',
                    style: AppTextStyles.bodyMedium(context),
                  ),
                ],
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 64, color: AppColors.primaryRed),
                const SizedBox(height: 16),
                Text(
                  'Error: ${placeState.error}',
                  style: AppTextStyles.titleSmall(context),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => context.read<PlaceCubit>().getPlaces(),
                  icon: const Icon(Icons.refresh),
                  label: Text(
                    'Reintentar',
                    style: AppTextStyles.button(context),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryRed,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
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
        isFavorite = favoriteState.favorites.contains(place.id);
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
                var curve = CurvedAnimation(
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
                            cubit.toggleFavorite(int.parse(place.id), '');
                            // Efecto de vibración al añadir a favoritos
                            HapticFeedback.mediumImpact();
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
