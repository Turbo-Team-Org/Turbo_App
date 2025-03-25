import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:turbo/places/place_repository/models/place/place.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:animate_do/animate_do.dart';
import 'dart:async';

class ImageCarousel extends StatefulWidget {
  final Place place;

  const ImageCarousel({super.key, required this.place});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Iniciar autoplay después de que el widget se construya
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _startAutoPlay();
      }
    });
  }

  @override
  void dispose() {
    _stopAutoPlay();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    // Cancelar timer existente si hay uno
    _stopAutoPlay();
    // Crear nuevo timer para cambiar página cada 5 segundos
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_pageController.hasClients && mounted) {
        if (_currentPage < _getImages().length - 1) {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutQuint,
          );
        } else {
          // Volver a la primera página con una animación suave
          _pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 1200),
            curve: Curves.easeInOutCubic,
          );
        }
      }
    });
  }

  void _stopAutoPlay() {
    _timer?.cancel();
    _timer = null;
  }

  List<String> _getImages() {
    // Usar todas las imágenes disponibles, incluyendo la principal si existe
    List<String> images = [];

    if (widget.place.mainImage.isNotEmpty) {
      images.add(widget.place.mainImage);
    }

    // Añadir el resto de imágenes, evitando duplicados
    for (var image in widget.place.imageUrls) {
      if (image.isNotEmpty && image != widget.place.mainImage) {
        images.add(image);
      }
    }

    // Si no hay imágenes, usar una imagen de marcador de posición
    if (images.isEmpty) {
      images.add('https://via.placeholder.com/400x250?text=Sin+Imágenes');
    }

    return images;
  }

  @override
  Widget build(BuildContext context) {
    final images = _getImages();
    return _buildCarousel(images);
  }

  Widget _buildCarousel(List<String> images) {
    return Stack(
      children: [
        // PageView para el carrusel
        PageView.builder(
          controller: _pageController,
          itemCount: images.length,
          onPageChanged: (index) {
            if (mounted) {
              setState(() {
                _currentPage = index;
              });
            }
          },
          itemBuilder: (context, index) {
            return Hero(
              tag:
                  index == 0
                      ? 'place_image_${widget.place.id}'
                      : 'place_image_${widget.place.id}_$index',
              // Añadimos un flightShuttleBuilder personalizado para controlar la animación del Hero
              flightShuttleBuilder: (
                BuildContext flightContext,
                Animation<double> animation,
                HeroFlightDirection flightDirection,
                BuildContext fromHeroContext,
                BuildContext toHeroContext,
              ) {
                // Creamos una combinación de animaciones para un efecto más impresionante
                return AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    // Calculamos valores para efectos visuales durante la transición
                    final double curvedAnimation = Curves.easeInOutCubic
                        .transform(animation.value);

                    return Material(
                      color: Colors.transparent,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // Aplicamos transformaciones para un efecto más dramático
                          Transform.scale(
                            scale:
                                // Aplicamos ligero efecto de escala
                                1.0 + curvedAnimation * 0.05,
                            child: CachedNetworkImage(
                              imageUrl: images[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Overlay con opacidad que va desapareciendo
                          Opacity(
                            opacity:
                                flightDirection == HeroFlightDirection.push
                                    ? (1 - curvedAnimation) *
                                        0.3 // Al abrir, el overlay desaparece
                                    : curvedAnimation *
                                        0.3, // Al cerrar, el overlay aparece
                            child: Container(color: Colors.black),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: CachedNetworkImage(
                imageUrl: images[index],
                fit: BoxFit.cover,
                placeholder:
                    (context, url) => Container(
                      color: Colors.grey.shade300,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                errorWidget:
                    (context, url, error) => Container(
                      color: Colors.grey.shade300,
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
              ),
            );
          },
        ),

        // Indicador de página
        if (images.length > 1)
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: images.length,
                effect: CustomizableEffect(
                  activeDotDecoration: DotDecoration(
                    width: 20,
                    height: 8,
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                    dotBorder: DotBorder(color: Colors.white, width: 1),
                  ),
                  dotDecoration: DotDecoration(
                    width: 8,
                    height: 8,
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                    dotBorder: DotBorder(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  spacing: 8,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
