import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:turbo/app/core/theme/text_styles.dart';
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
      _startAutoPlay();
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
      if (_pageController.hasClients) {
        if (_currentPage < _getImages().length - 1) {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
        } else {
          // Volver a la primera página con una animación suave
          _pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
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

    return Stack(
      children: [
        // PageView para el carrusel
        PageView.builder(
          controller: _pageController,
          itemCount: images.length,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          itemBuilder: (context, index) {
            return FadeIn(
              duration: const Duration(milliseconds: 300),
              child: Hero(
                tag:
                    index == 0 && widget.place.mainImage.isNotEmpty
                        ? 'place_image_${widget.place.id}'
                        : 'place_image_${widget.place.id}_$index',
                child: CachedNetworkImage(
                  imageUrl: images[index],
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) => Container(
                        color: Colors.grey.shade300,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryRed,
                          ),
                        ),
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
              ),
            );
          },
        ),

        // Indicador de página
        if (images.length > 1)
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: FadeInUp(
                duration: const Duration(milliseconds: 400),
                delay: const Duration(milliseconds: 400),
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: images.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: AppColors.primaryRed,
                    dotColor: Colors.white.withOpacity(0.7),
                    dotHeight: 8,
                    dotWidth: 8,
                    expansionFactor: 3,
                    spacing: 5,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
