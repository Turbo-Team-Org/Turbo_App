import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbo/app/core/theme/theme_cubit.dart';
import 'package:turbo/app/core/theme/theme_state.dart';

class AppThemeSwitch extends StatelessWidget {
  const AppThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        if (state is ThemeLoaded) {
          final isDarkMode = state.isDarkMode;
          final isAutoTheme = state.isAutoTheme;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  isDarkMode ? 'Modo oscuro' : 'Modo claro',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.titleLarge?.color,
                  ),
                ),
                trailing: Switch(
                  value: isDarkMode,
                  activeColor: Theme.of(context).colorScheme.primary,
                  onChanged: (_) => context.read<ThemeCubit>().toggleDarkMode(),
                ),
              ),
              const Divider(),
              ListTile(
                leading: Icon(
                  Icons.access_time,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  'Tema automático',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.titleLarge?.color,
                  ),
                ),
                subtitle: const Text(
                  'Oscuro de 7PM a 7AM, claro durante el día',
                  style: TextStyle(fontSize: 12),
                ),
                trailing: Switch(
                  value: isAutoTheme,
                  activeColor: Theme.of(context).colorScheme.primary,
                  onChanged:
                      (value) => context.read<ThemeCubit>().setAutoTheme(value),
                ),
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
