import 'package:flap_app/domain/entity/event.dart';
import 'package:flap_app/domain/entity/recipe.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/domain/repository/analytics/analytics_platform.dart';
import 'package:flap_app/domain/repository/recipe/recipe_repository.dart';
import 'package:flap_app/presentation/screens/home/viewmodel/home_screen_state.dart';
import 'package:flutter/material.dart';

class HomeScreenViewModel {
  HomeScreenViewModel(
      {required this.recipeRepository, required this.analyticsRepository});

  RecipeRepository recipeRepository;
  AnalyticsRepository analyticsRepository;

  final ValueNotifier<HomeScreenState> state =
      ValueNotifier<HomeScreenState>(HomeScreenState.initial());

  Future<void> getRandomRecipes() async {
    if (state.value.loadRecipesEvent is LoadingEvent) {
      return;
    }
    state.value = HomeScreenState.loading();

    final response = await recipeRepository.getRandomRecipes();

    switch (response) {
      case SuccessRequestResponse<List<Recipe>, Exception>():
        analyticsRepository.logEvent("Recipe load success", {});
        state.value = HomeScreenState.success(response.data);
      case ErrorRequestResponse<List<Recipe>, Exception>():
        analyticsRepository.logEvent("Recipe load error", {});
        state.value = HomeScreenState.error(response.error);
    }
  }
}
