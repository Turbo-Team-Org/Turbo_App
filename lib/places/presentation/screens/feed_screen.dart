import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:turbo/authentication/state_management/auth_cubit/cubit/auth_cubit_cubit.dart';
import 'package:turbo/location/state_management/location_bloc/cubit/location_cubit.dart';
import 'package:turbo/places/state_management/place_bloc/cubit/place_cubit.dart';
import 'package:turbo/events/presentation/widgets/welcome_events_dialog.dart';
import 'package:turbo/reservations/presentation/widgets/quick_reservations_widget.dart';
import 'package:turbo/places/presentation/widgets/animated_search_bar.dart';
import 'package:turbo/places/presentation/widgets/feed/feed.dart';

final _sl = GetIt.instance;
const _lastWelcomeDialogKey = 'last_welcome_dialog_shown_date';

/// Pantalla principal del Feed
///
/// Muestra lugares destacados, categorías y promociones.
/// Refactorizada para ser más limpia y mantenible.
@RoutePage()
class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final _scrollController = ScrollController();
  bool _isHeaderCollapsed = false;
  LocationData? _currentLocation;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _showWelcomeDialogIfNeeded();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final isCollapsed = _scrollController.offset > 150;
    if (isCollapsed != _isHeaderCollapsed) {
      setState(() => _isHeaderCollapsed = isCollapsed);
    }
  }

  Future<void> _showWelcomeDialogIfNeeded() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      final now = DateTime.now();
      final today =
          '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
      final lastShown = prefs.getString(_lastWelcomeDialogKey);

      if (lastShown != today && mounted) {
        final authState = context.read<AuthCubit>().state;
        String userName = 'Explorador';
        if (authState is Authenticated) {
          userName =
              authState.user.displayName?.split(' ').first ?? 'Explorador';
        }

        showWelcomeEventsDialog(context, userName);
        await prefs.setString(_lastWelcomeDialogKey, today);
      }
    } catch (_) {
      // Silently fail
    }
  }

  void _requestLocationIfNeeded() {
    if (_currentLocation == null) {
      context.read<LocationCubit>().requestLocationPermission();
    }
  }

  Future<void> _onRefresh() async {
    await context.read<PlaceCubit>().getPlaces();
    if (_currentLocation == null) {
      context.read<LocationCubit>().getCurrentLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:
                isDark
                    ? [colorScheme.surface, colorScheme.surface]
                    : [
                      colorScheme.primary.withValues(alpha: 0.15),
                      colorScheme.surface,
                    ],
            stops: const [0.0, 0.25],
          ),
        ),
        child: BlocProvider.value(
          value: _sl<LocationCubit>(),
          child: BlocListener<LocationCubit, LocationState>(
            listener: _onLocationStateChanged,
            child: RefreshIndicator(
              color: colorScheme.primary,
              onRefresh: _onRefresh,
              child: CustomScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                slivers: [
                  FeedAppBar(isCollapsed: _isHeaderCollapsed),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        WelcomeSection(onNearbyTap: _requestLocationIfNeeded),
                        const AnimatedSearchBar(),
                        const QuickReservationsWidget(),
                        const PromoSection(),
                      ],
                    ),
                  ),
                  const PlacesGrid(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onLocationStateChanged(BuildContext context, LocationState state) {
    switch (state) {
      case LocationObtained():
        setState(() => _currentLocation = state.location);
        context.read<PlaceCubit>().getPlaces();
        break;

      case LocationError():
        _showLocationError(state.message);
        context.read<PlaceCubit>().getPlaces();
        break;

      case LocationPermissionGranted():
        context.read<LocationCubit>().getCurrentLocation();
        break;

      case LocationPermissionDenied():
        _showLocationDenied();
        context.read<PlaceCubit>().getPlaces();
        break;

      default:
        break;
    }
  }

  void _showLocationError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error de ubicación: $message'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showLocationDenied() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Ubicación no disponible. Mostrando todos los lugares.',
        ),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
