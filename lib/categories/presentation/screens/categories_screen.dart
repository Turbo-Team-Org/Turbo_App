import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbo/categories/presentation/widgets/category_grid.dart';
import 'package:turbo/categories/state_management/category_bloc/category_cubit/cubit/category_cubit.dart';

@RoutePage()
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categorías'), elevation: 0),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          switch (state) {
            case CategoryInitial():
              // Cargar categorías al iniciar
              context.read<CategoryCubit>().loadCategories();
              return _buildLoading();
            case CategoryLoading():
              return _buildLoading();
            case CategoryLoaded():
              final categories = state.categories;
              return CategoryGrid(categories: categories);
            case CategoryError():
              final message = state.message;
              return _buildError(message);
            default:
              return _buildError('Estado desconocido');
          }
        },
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildError(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 60),
          const SizedBox(height: 16),
          Text(
            'Error: $message',
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
