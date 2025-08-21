import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:animate_do/animate_do.dart';
import 'package:turbo/app/core/theme/app_themes.dart';
import 'package:turbo/app/core/theme/text_styles.dart';
import 'package:turbo/app/routes/router/app_router.gr.dart';
import 'package:turbo/categories/state_management/category_cubit.dart';
import 'package:turbo/places/state_management/place_search_cubit/places_search_cubit.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class AnimatedSearchBar extends StatefulWidget {
  final double height;
  final EdgeInsets padding;

  const AnimatedSearchBar({
    super.key,
    this.height = 56,
    this.padding = const EdgeInsets.fromLTRB(20, 15, 20, 20),
  });

  @override
  State<AnimatedSearchBar> createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<AnimatedSearchBar>
    with TickerProviderStateMixin {
  List<String> _categoryNames = [];
  int _currentCategoryIndex = 0;
  bool _showCategory = true;

  // Speech to text
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _speechEnabled = false;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _loadCategories();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speech.initialize(
      onError: (error) => print('Error: $error'),
      onStatus: (status) => print('Status: $status'),
    );
  }

  void _loadCategories() {
    final categoryState = context.read<CategoryCubit>().state;
    if (categoryState is CategoryLoaded) {
      setState(() {
        _categoryNames =
            categoryState.categories
                .map((category) => category.name)
                .where((name) => name.trim().isNotEmpty)
                .toList();
      });
      if (_categoryNames.isNotEmpty) {
        _startCategoryRotation();
      }
    } else {
      context.read<CategoryCubit>().loadCategories();
    }
  }

  void _startCategoryRotation() async {
    if (_categoryNames.isEmpty) return;
    while (mounted) {
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) break;
      setState(() => _showCategory = false);
      await Future.delayed(const Duration(milliseconds: 450));
      if (!mounted) break;
      setState(() {
        _currentCategoryIndex =
            (_currentCategoryIndex + 1) % _categoryNames.length;
        _showCategory = true;
      });
    }
  }

  /// 🎤 Inicia la búsqueda por voz
  void _startVoiceSearch() async {
    if (!_speechEnabled) {
      _showSpeechNotAvailableDialog();
      return;
    }

    setState(() => _isListening = true);

    try {
      await _speech.listen(
        onResult: (result) {
          if (result.finalResult) {
            final query = result.recognizedWords.trim();
            if (query.isNotEmpty) {
              // Navegar a la pantalla de búsqueda con la consulta de voz
              context.router.push(PlacesSearchRoute(initialQuery: query));
            }
            setState(() => _isListening = false);
          }
        },
        listenFor: const Duration(seconds: 10),
        pauseFor: const Duration(seconds: 3),
        partialResults: true,
        localeId: 'es_ES', // Español para Cuba
      );
    } catch (e) {
      setState(() => _isListening = false);
      _showErrorDialog('Error al iniciar búsqueda por voz: $e');
    }
  }

  /// 🛑 Detiene la búsqueda por voz
  void _stopVoiceSearch() async {
    await _speech.stop();
    setState(() => _isListening = false);
  }

  /// 📱 Muestra diálogo si el reconocimiento de voz no está disponible
  void _showSpeechNotAvailableDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Reconocimiento de Voz'),
            content: const Text(
              'El reconocimiento de voz no está disponible en este dispositivo. '
              'Puedes usar la búsqueda por texto en su lugar.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Entendido'),
              ),
            ],
          ),
    );
  }

  /// ❌ Muestra diálogo de error
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state is CategoryLoaded && _categoryNames.isEmpty) {
          setState(() {
            _categoryNames =
                state.categories
                    .map((category) => category.name)
                    .where((name) => name.trim().isNotEmpty)
                    .toList();
          });
          if (_categoryNames.isNotEmpty) {
            _startCategoryRotation();
          }
        }
      },
      child: Padding(
        padding: widget.padding,
        child: GestureDetector(
          onTap: () => context.router.push(PlacesSearchRoute()),
          child: Container(
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: Theme.of(context).colorScheme.surface,
              border: Border.all(
                color: Colors.grey.withOpacity(0.08),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(
                    Icons.search_rounded,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Busca',
                        style: AppTextStyles.bodyMedium(context).copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.6),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (_categoryNames.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        SizedBox(
                          height: 24,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 350),
                            switchInCurve: Curves.easeOutCubic,
                            switchOutCurve: Curves.easeInCubic,
                            transitionBuilder: (child, animation) {
                              final inAnimation = Tween<Offset>(
                                begin: const Offset(0, 0.7),
                                end: Offset.zero,
                              ).animate(animation);
                              final outAnimation = Tween<Offset>(
                                begin: Offset.zero,
                                end: const Offset(0, -0.7),
                              ).animate(animation);
                              if (child.key ==
                                  ValueKey(
                                    _categoryNames[_currentCategoryIndex],
                                  )) {
                                // Entrando
                                return SlideTransition(
                                  position: inAnimation,
                                  child: FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                                );
                              } else {
                                // Saliendo
                                return SlideTransition(
                                  position: outAnimation,
                                  child: FadeTransition(
                                    opacity: ReverseAnimation(animation),
                                    child: child,
                                  ),
                                );
                              }
                            },
                            child:
                                _showCategory
                                    ? Text(
                                      _categoryNames[_currentCategoryIndex],
                                      key: ValueKey(
                                        _categoryNames[_currentCategoryIndex],
                                      ),
                                      style: AppTextStyles.bodyMedium(
                                        context,
                                      ).copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withOpacity(0.6),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                    : const SizedBox.shrink(),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color:
                        _isListening
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: IconButton(
                      icon: Icon(
                        _isListening ? Icons.mic : Icons.mic_rounded,
                        size: 22,
                        color:
                            _isListening
                                ? Colors.white
                                : Theme.of(context).colorScheme.primary,
                      ),
                      onPressed:
                          _isListening ? _stopVoiceSearch : _startVoiceSearch,
                    ),
                  ),
                ),

                // Indicador de escucha
                if (_isListening)
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Escuchando...',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
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
}
