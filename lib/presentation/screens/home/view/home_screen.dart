import 'package:flap_app/domain/entity/event.dart';
import 'package:flap_app/domain/entity/recipe.dart';
import 'package:flap_app/presentation/screens/home/viewmodel/home_screen_state.dart';
import 'package:flap_app/presentation/screens/home/view/widgets/recipe_grid_item.dart';
import 'package:flap_app/presentation/screens/home/view/widgets/screen_state_widgets/error_screen.dart';
import 'package:flap_app/presentation/screens/home/view/widgets/screen_state_widgets/loading_screen.dart';
import 'package:flap_app/presentation/screens/home/viewmodel/home_viewmodel.dart';
import 'package:flap_app/util/l10n/app_localizations_context.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.viewModel});

  final HomeScreenViewModel viewModel;

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.viewModel.getRandomRecipes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(context.localization.home),
        ),
        body: ValueListenableBuilder<HomeScreenState>(
            valueListenable: widget.viewModel.state,
            builder: (context, state, child) {
              return _getWidget(state.loadRecipesEvent);
            }));
  }

  Widget _getWidget(Event<List<Recipe>, Exception> event) {
    switch (event) {
      case InitialEvent():
        return const LoadingScreenWidget();
      case LoadingEvent():
        return const LoadingScreenWidget();
      case SuccessEvent():
        return RecipeGrid(recipeList: event.data);
      case EventError():
        return const ErrorScreenWidget();
    }
  }
}

class RecipeGrid extends StatelessWidget {
  final List<Recipe> recipeList;

  const RecipeGrid({super.key, required this.recipeList});

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final recipe in recipeList) RecipeGridItem(recipe: recipe)
      ],
    );
  }
}
