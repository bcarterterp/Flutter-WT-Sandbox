import 'package:equatable/equatable.dart';
import 'package:flap_app/domain/entity/event.dart';
import 'package:flap_app/domain/entity/recipe.dart';

class HomeScreenState extends Equatable {
  const HomeScreenState({required this.loadRecipesEvent});

  final Event<List<Recipe>, Exception> loadRecipesEvent;

  factory HomeScreenState.initial() => HomeScreenState(
        loadRecipesEvent: InitialEvent(),
      );

  factory HomeScreenState.loading() => HomeScreenState(
        loadRecipesEvent: LoadingEvent(),
      );

  factory HomeScreenState.success(List<Recipe> recipeList) =>
      HomeScreenState(loadRecipesEvent: SuccessEvent(recipeList));

  factory HomeScreenState.error(Exception error) =>
      HomeScreenState(loadRecipesEvent: EventError(error));

  @override
  List<Object?> get props => [loadRecipesEvent];
}
