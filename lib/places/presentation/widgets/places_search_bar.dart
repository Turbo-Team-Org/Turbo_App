import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbo/places/state_management/places_search_cubit.dart';

class PlacesSearchBar extends StatefulWidget {
  final String? initialQuery;
  final VoidCallback? onFilterPressed;

  const PlacesSearchBar({super.key, this.initialQuery, this.onFilterPressed});

  @override
  State<PlacesSearchBar> createState() => _PlacesSearchBarState();
}

class _PlacesSearchBarState extends State<PlacesSearchBar> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialQuery);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Botón de volver
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back),
            color: Colors.grey.shade700,
          ),

          // Campo de búsqueda
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              onChanged: (query) {
                context.read<PlacesSearchCubit>().updateSearchQuery(query);
              },
              decoration: InputDecoration(
                hintText: 'Buscar restaurantes, bares...',
                hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 16,
                ),
              ),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),

          // Divider vertical
          Container(
            height: 30,
            width: 1,
            color: Colors.grey.shade300,
            margin: const EdgeInsets.symmetric(horizontal: 8),
          ),

          // Botón de filtros
          IconButton(
            onPressed: widget.onFilterPressed,
            icon: const Icon(Icons.tune),
            color: Theme.of(context).primaryColor,
          ),

          const SizedBox(width: 4),
        ],
      ),
    );
  }
}
