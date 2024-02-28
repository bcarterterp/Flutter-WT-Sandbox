import 'package:flap_app/data/dto/recipe_dto.dart';
import 'package:flap_app/domain/entity/recipe.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/domain/repository/flavor/flavor_repository.dart';
import 'package:flap_app/domain/repository/recipe/recipe_repository.dart';
import 'package:flap_app/util/environment_variables/env.dart';
import 'package:networking/networking.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final NetworkingProtocol network;
  final FlavorRepository flavorRepo;
  late final Uri spoonacularUri;

  RecipeRepositoryImpl({required this.network, required this.flavorRepo})
      : spoonacularUri = Uri(
          scheme: "https",
          host: flavorRepo.getBaseUrlHost(),
          path: "recipes/random",
          queryParameters: {
            "number": "20",
            "apiKey": Env.spoonacularApiKey,
          },
        );

  @override
  Future<RequestResponse<List<Recipe>, Exception>> getRandomRecipes() async {
    try {
      Map<String, dynamic> response;
      response = await network.get(spoonacularUri.toString());

      final recipeListResponse = (response["recipes"] as List)
          .map((response) => RecipeDto.fromJson(response))
          .toList();

      return Future.value(SuccessRequestResponse(recipeListResponse));
    } catch (error) {
      return Future.value(ErrorRequestResponse(Exception()));
    }
  }
}
