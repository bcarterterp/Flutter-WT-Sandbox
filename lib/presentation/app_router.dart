import 'package:flap_app/data/repository/auth/auth_repository.dart';
import 'package:flap_app/data/repository/recipe/recipe_repository_impl.dart';
import 'package:flap_app/domain/repository/analytics/analytics_platform.dart';
import 'package:flap_app/domain/repository/flavor/flavor_repository_impl.dart';
import 'package:flap_app/presentation/screens/home/view/home_screen.dart';
import 'package:flap_app/presentation/screens/home/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:networking/networking.dart';

abstract class AppRouterProtocol {
  Widget initialScreen(BuildContext context);
}

class AppRouter extends AppRouterProtocol {
  final NetworkingProtocol network;
  final AuthRepository authRepository;
  final AnalyticsRepository analyticsRepository;

  AppRouter(
      {required this.network,
      required this.authRepository,
      required this.analyticsRepository});

  @override
  Widget initialScreen(BuildContext context) {
    if (authRepository.isLoggedIn() == true) {
      return homeScreen();
    } else {
      return authScreen(context);
    }
  }

  void pushHomeScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => homeScreen()),
    );
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
        pushHomeScreen(context);
      } else {
        // handle login error
        debugPrint('Login failed');
      }
    });
  }
}
