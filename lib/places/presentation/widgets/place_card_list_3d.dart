import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:turbo/places/presentation/widgets/place_card_3d.dart';
import 'package:turbo/app/shared/ui/rotation_3d.dart';

class PlaceCardList3D extends StatefulWidget {
  final List<Place> places;
  final Function(Place) onPlaceChange;
  final Function(Place, bool) onFavoriteToggle;
  final Map<String, bool> favoritePlaces;

  const PlaceCardList3D({
    Key? key,
    required this.places,
    required this.onPlaceChange,
    required this.onFavoriteToggle,
    required this.favoritePlaces,
  }) : super(key: key);

  @override
  PlaceCardList3DState createState() => PlaceCardList3DState();
}

class PlaceCardList3DState extends State<PlaceCardList3D>
    with SingleTickerProviderStateMixin {
  final double _maxRotation = 20;

  PageController? _pageController;

  double _cardWidth = 250;
  double _cardHeight = 380;
  double _normalizedOffset = 0;
  double _prevScrollX = 0;
  bool _isScrolling = false;

  // Controlador de animación para el efecto de rebote
  late AnimationController _tweenController;

  // Definimos el tween para la animación
  late Tween<double> _tween;

  // Animación que se ejecutará
  late Animation<double> _tweenAnim;

  @override
  void initState() {
    // Inicializamos el controlador de animación
    _tweenController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // Configuramos el tween desde -1 a 0 (valor inicial y final)
    _tween = Tween<double>(begin: -1, end: 0);

    // Configuramos la animación con curva elástica para un efecto más natural
    _tweenAnim = _tween.animate(
      CurvedAnimation(parent: _tweenController, curve: Curves.elasticOut),
    );

    // Actualizamos el offset cada vez que cambia la animación
    _tweenAnim.addListener(() => _setOffset(_tweenAnim.value));

    super.initState();
  }

  @override
  void dispose() {
    _tweenController.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // Ajustamos el tamaño de las tarjetas basado en el tamaño de la pantalla
    _cardHeight = (size.height * .48).clamp(300.0, 420.0);
    _cardWidth = _cardHeight * .8;

    // Configuramos el PageController
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: _cardWidth / size.width,
    );

    // Creamos el contenido principal
    Widget listContent = Container(
      height: _cardHeight,
      child: PageView.builder(
        physics: const BouncingScrollPhysics(),
        controller: _pageController,
        itemCount: widget.places.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) => _buildRotatedPlaceCard(i),
        onPageChanged: (index) {
          widget.onPlaceChange(widget.places[index]);
        },
      ),
    );

    // Envolvemos en listeners para detectar gestos
    return Listener(
      onPointerUp: _handlePointerUp,
      child: NotificationListener(
        onNotification: _handleScrollNotifications,
        child: listContent,
      ),
    );
  }

  // Constructor de tarjeta rotada para cada elemento de la lista
  Widget _buildRotatedPlaceCard(int itemIndex) {
    final place = widget.places[itemIndex];
    final isFavorite = widget.favoritePlaces[place.id] ?? false;

    return Rotation3d(
      rotationY: _normalizedOffset * _maxRotation,
      child: PlaceCard3D(
        place: place,
        offset: _normalizedOffset,
        cardWidth: _cardWidth,
        cardHeight: _cardHeight - 50,
        isFavorite: isFavorite,
        onFavoritePressed: () {
          widget.onFavoriteToggle(place, !isFavorite);
        },
      ),
    );
  }

  // Maneja las notificaciones de desplazamiento
  bool _handleScrollNotifications(Notification notification) {
    if (notification is ScrollUpdateNotification) {
      if (_isScrolling) {
        double dx = notification.metrics.pixels - _prevScrollX;
        double scrollFactor = .01;
        double newOffset = (_normalizedOffset + dx * scrollFactor);
        _setOffset(newOffset.clamp(-1.0, 1.0));
      }
      _prevScrollX = notification.metrics.pixels;

      // Notificamos el cambio de lugar si es necesario
      final currentPage = _pageController?.page?.round();
      if (currentPage != null && currentPage < widget.places.length) {
        widget.onPlaceChange(widget.places[currentPage]);
      }
    } else if (notification is ScrollStartNotification) {
      _isScrolling = true;
      _prevScrollX = notification.metrics.pixels;
      _tweenController.stop();
    }
    return true;
  }

  // Maneja el evento cuando el usuario levanta el dedo
  void _handlePointerUp(PointerUpEvent event) {
    if (_isScrolling) {
      _isScrolling = false;
      _startOffsetTweenToZero();
    }
  }

  // Actualiza el offset y reconstruye el widget
  void _setOffset(double value) {
    setState(() {
      _normalizedOffset = value;
    });
  }

  // Inicia la animación para devolver el offset a cero
  void _startOffsetTweenToZero() {
    _tween.begin = _normalizedOffset;
    _tweenController.reset();
    _tween.end = 0;
    _tweenController.forward();
  }
}
