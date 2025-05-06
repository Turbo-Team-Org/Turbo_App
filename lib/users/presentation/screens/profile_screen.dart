import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbo/app/routes/router/app_router.gr.dart';
import 'package:turbo/authentication/state_managament/auth_cubit/cubit/auth_cubit_cubit.dart';
import 'package:turbo/authentication/state_managament/sign_out_cubit/cubit/sign_out_cubit.dart';
import 'package:turbo/places/presentation/widgets/feed_widgets.dart';
import 'package:turbo/mock_data/sample_data_loader.dart';
import 'package:turbo/mock_data/data_loader_manager.dart';

import '../../../app/view/widgets/global_widgets.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Instancia del gestor de carga de datos
    final dataLoaderManager = DataLoaderManager();

    return BlocListener<SignOutCubit, SignOutState>(
      listener: (context, signoutstate) {
        switch (signoutstate) {
          case Success():
            showDialog(
              context: context,
              builder:
                  (_) => SuccessDialog(
                    title: "¡Cerrado de Sesión Exitoso!",
                    message:
                        "Cerrado de Sesión Exitoso va a ser rederigido a la pantalla del Login ",
                  ),
            );
            Future.delayed(const Duration(seconds: 2), () {
              context.replaceRoute(SignInRoute());
            });
            break;
          case Error(:final error):
            showDialog(
              context: context,
              builder: (_) => ErrorDialog(title: "¡Error!", message: error!),
            );
            break;
          default:
            break;
        }
      },
      child: BlocBuilder<AuthCubit, AuthCubitState>(
        builder: (context, state) {
          switch (state) {
            case Authenticated(:final user):
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Perfil"),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  centerTitle: true,
                  actions: [
                    // Menú para gestionar datos de prueba
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.data_array, color: Colors.blue),
                      onSelected: (value) {
                        switch (value) {
                          case 'places':
                            // Mostrar diálogo de confirmación para lugares
                            showDialog(
                              context: context,
                              builder:
                                  (context) => AlertDialog(
                                    title: const Text(
                                      'Cargar lugares de prueba',
                                    ),
                                    content: const Text(
                                      '¿Estás seguro de cargar lugares de prueba? '
                                      'Esta acción agregará lugares ficticios a tu base de datos.',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cancelar'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          // Usar el dataLoaderManager en lugar de sampleDataLoader
                                          dataLoaderManager.loadPlaces();
                                        },
                                        child: const Text('Cargar lugares'),
                                      ),
                                    ],
                                  ),
                            );
                            break;
                          case 'categories':
                            // Mostrar diálogo de confirmación para categorías
                            showDialog(
                              context: context,
                              builder:
                                  (context) => AlertDialog(
                                    title: const Text(
                                      'Cargar categorías de prueba',
                                    ),
                                    content: const Text(
                                      '¿Estás seguro de cargar categorías de prueba? '
                                      'Esta acción agregará categorías y asignará a los lugares existentes.',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cancelar'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          dataLoaderManager.loadCategories();
                                        },
                                        child: const Text('Cargar categorías'),
                                      ),
                                    ],
                                  ),
                            );
                            break;
                          case 'additional':
                            // Mostrar opciones para cargar todo tipo de datos
                            dataLoaderManager.showDataLoaderOptions(context);
                            break;
                        }
                      },
                      itemBuilder:
                          (BuildContext context) => [
                            const PopupMenuItem<String>(
                              value: 'places',
                              child: Text('Cargar lugares'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'categories',
                              child: Text('Cargar categorías'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'additional',
                              child: Text('Cargar datos adicionales'),
                            ),
                          ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout, color: Colors.black),
                      onPressed: () {
                        context.read<SignOutCubit>().signOut();
                      },
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ProfileAvatar(),
                      const SizedBox(height: 20),

                      Text(
                        user.displayName ?? "Usuario",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        user.email,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 20),

                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        icon: const Icon(Icons.edit, color: Colors.white),
                        label: const Text(
                          "Editar Perfil",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          // Navegar a pantalla de edición de perfil
                          //   context.pushRoute(const EditProfileRoute());
                        },
                      ),
                      const SizedBox(height: 10),

                      ListTile(
                        leading: const Icon(
                          Icons.dark_mode,
                          color: Colors.black,
                        ),
                        title: const Text(
                          "Modo Oscuro",
                          style: TextStyle(color: Colors.black),
                        ),
                        trailing: Switch(
                          activeColor: Colors.red,
                          value: true,
                          // context.read<ThemeCubit>().isDarkMode,
                          onChanged: (value) {
                            //  context.read<ThemeCubit>().toggleTheme();
                          },
                        ),
                      ),

                      ListTile(
                        leading: const Icon(Icons.logout, color: Colors.red),
                        title: const Text(
                          "Cerrar Sesión",
                          style: TextStyle(color: Colors.red),
                        ),
                        onTap: () {
                          context.read<SignOutCubit>().signOut();
                        },
                      ),
                    ],
                  ),
                ),
              );

            default:
              return const Center(child: CircularProgressIndicator.adaptive());
          }
        },
      ),
    );
  }
}
