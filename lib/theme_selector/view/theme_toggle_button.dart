import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../theme_bloc/theme_bloc.dart';

/// Botón compacto para alternar tema rápidamente
///
/// Ideal para colocar en AppBar u otras ubicaciones compactas.
/// Alterna entre light y dark al hacer tap.
class ThemeToggleButton extends StatelessWidget {
  /// Si es true, muestra solo el icono sin fondo
  final bool minimal;

  const ThemeToggleButton({
    super.key,
    this.minimal = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final isDark = _isDarkMode(context, state);

        if (minimal) {
          return IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween(begin: 0.5, end: 1.0).animate(animation),
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: Icon(
                isDark ? Icons.light_mode : Icons.dark_mode,
                key: ValueKey(isDark),
              ),
            ),
            onPressed: () => _toggleTheme(context),
            tooltip: isDark ? 'Cambiar a tema claro' : 'Cambiar a tema oscuro',
          );
        }

        return _AnimatedThemeToggle(
          isDark: isDark,
          onToggle: () => _toggleTheme(context),
        );
      },
    );
  }

  bool _isDarkMode(BuildContext context, ThemeState state) {
    if (state.themeMode == ThemeMode.system) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
    return state.isDark;
  }

  void _toggleTheme(BuildContext context) {
    context.read<ThemeBloc>().add(const ThemeEvent.toggleTheme());
  }
}

/// Toggle animado con efecto de sol/luna
class _AnimatedThemeToggle extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggle;

  const _AnimatedThemeToggle({
    required this.isDark,
    required this.onToggle,
  });

  @override
  State<_AnimatedThemeToggle> createState() => _AnimatedThemeToggleState();
}

class _AnimatedThemeToggleState extends State<_AnimatedThemeToggle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
      value: widget.isDark ? 1.0 : 0.0,
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.8), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 0.8, end: 1.0), weight: 50),
    ]).animate(_controller);
  }

  @override
  void didUpdateWidget(_AnimatedThemeToggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isDark != oldWidget.isDark) {
      if (widget.isDark) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onToggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 56,
        height: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: widget.isDark
              ? const Color(0xFF1A1A2E)
              : const Color(0xFFFFF3E0),
          border: Border.all(
            color: widget.isDark
                ? Colors.white24
                : Colors.orange.withValues(alpha: 0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: widget.isDark
                  ? Colors.black26
                  : Colors.orange.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Estrellas (solo visibles en modo oscuro)
            if (widget.isDark) ...[
              const Positioned(
                left: 8,
                top: 6,
                child: _Star(size: 3, alpha: 0.7),
              ),
              const Positioned(
                left: 14,
                bottom: 8,
                child: _Star(size: 2, alpha: 0.5),
              ),
              const Positioned(
                left: 20,
                top: 10,
                child: _Star(size: 2, alpha: 0.6),
              ),
            ],

            // Toggle knob
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOutCubic,
              left: widget.isDark ? 28 : 4,
              top: 4,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Transform.rotate(
                      angle: _rotationAnimation.value * 3.14159,
                      child: child,
                    ),
                  );
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: widget.isDark
                        ? const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFFE1E8ED), Color(0xFFC5D3DC)],
                          )
                        : const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFFFFD54F), Color(0xFFFF9800)],
                          ),
                    boxShadow: [
                      BoxShadow(
                        color: widget.isDark
                            ? Colors.white24
                            : Colors.orange.withValues(alpha: 0.5),
                        blurRadius: 8,
                        spreadRadius: widget.isDark ? 0 : 2,
                      ),
                    ],
                  ),
                  child: widget.isDark ? _buildMoonCraters() : _buildSunRays(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoonCraters() {
    return Stack(
      children: [
        Positioned(
          right: 5,
          top: 4,
          child: Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.withValues(alpha: 0.3),
            ),
          ),
        ),
        Positioned(
          right: 8,
          bottom: 6,
          child: Container(
            width: 3,
            height: 3,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.withValues(alpha: 0.2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSunRays() {
    return const SizedBox(); // El gradiente ya da el efecto solar
  }
}

class _Star extends StatelessWidget {
  final double size;
  final double alpha;

  const _Star({required this.size, required this.alpha});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: alpha),
      ),
    );
  }
}
