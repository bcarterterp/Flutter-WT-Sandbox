import 'package:flap_app/data/repository/auth/auth_repository.dart';
import 'package:flap_app/data/repository/recipe/recipe_repository_impl.dart';
import 'package:flap_app/domain/repository/analytics/analytics_platform.dart';
import 'package:flap_app/domain/repository/flavor/flavor_repository_impl.dart';
import 'package:flap_app/presentation/screens/home/view/home_screen.dart';
import 'package:flap_app/presentation/screens/home/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:networking/networking.dart';

class AppRouter {
  final Networking network;
  final AuthRepository authRepository;
  final AnalyticsRepository analyticsRepository;

  AppRouter(
      {required this.network,
      required this.authRepository,
      required this.analyticsRepository});

  Widget initialScreen(BuildContext context) {
    if (authRepository.isLoggedIn() == true) {
      return homeScreen();
    } else {
      return authScreen(context);
    }
  }

  Widget homeScreen() {
    final recipeRepo = RecipeRepositoryImpl(
        network: network, flavorRepo: FlavorRepositoryImpl());

    final viewModel = HomeScreenViewModel(
        recipeRepository: recipeRepo, analyticsRepository: analyticsRepository);
    return HomeScreen(viewModel: viewModel);
  }

  Widget authScreen(BuildContext context) {
    return authRepository.startLogin((bool success) {
      // Handle the completion here
      if (success) {
        debugPrint('Login successful');
        context.go('/home');
      } else {
        // handle login error
        debugPrint('Login failed');
      }
    });
  }

  GoRouter buildRouterConfig() {
    return GoRouter(initialLocation: '/', routes: [
      GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return initialScreen(context);
          }),
      GoRoute(
          path: '/home',
          builder: (BuildContext context, GoRouterState state) {
            return homeScreen();
          })
    ]);
  }
}
