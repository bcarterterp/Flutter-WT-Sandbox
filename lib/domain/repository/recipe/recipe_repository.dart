import 'package:flap_app/domain/entity/recipe.dart';
import 'package:flap_app/domain/entity/request_response.dart';

abstract class RecipeRepository {
  Future<RequestResponse<List<Recipe>, Exception>> getRandomRecipes();
}
