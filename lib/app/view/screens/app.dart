import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbo/app/routes/guards/authentication_guards.dart';
import 'package:turbo/authentication/state_managament/auth_cubit/cubit/auth_cubit_cubit.dart';
import 'package:turbo/authentication/state_managament/sign_in_cubit/cubit/sign_in_cubit.dart';
import 'package:turbo/authentication/state_managament/sign_out_cubit/cubit/sign_out_cubit.dart';
import 'package:turbo/authentication/state_managament/sign_up_cubit/cubit/sign_up_cubit.dart';
import 'package:turbo/places/state_management/place_bloc/cubit/place_cubit.dart';

import '../../../boostrap.dart';
import '../../../favorites/state_management/cubit/favorite_cubit.dart';
import '../../../reviews/state_management/cubit/review_cubit.dart';
import '../../routes/router/app_router.dart';
import '../../utils/theme/turbo_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sl<SignInCubit>()),
        BlocProvider.value(value: sl<AuthCubit>()),
        BlocProvider.value(value: sl<PlaceCubit>()..getPlaces()),
        BlocProvider.value(value: sl<ReviewCubit>()),
        BlocProvider.value(value: sl<FavoriteCubit>()),
        BlocProvider.value(value: sl<SignOutCubit>()),
        BlocProvider.value(value: sl<SignUpCubit>()),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final appRouter = AppRouter(authGuard: AuthGuard(authCubit));

    return MaterialApp.router(
      theme: TurboTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.config(),
    );
  }
}
