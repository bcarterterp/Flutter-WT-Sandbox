import 'package:flap_app/data/repository/recipe/recipe_repository_impl.dart';
import 'package:flap_app/domain/entity/recipe.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/domain/repository/flavor/flavor_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:networking/mocks/mock_networking_dependency_provider.dart';
import 'package:networking/networking.dart';

import 'recipe_repository_test.mocks.dart';

@GenerateMocks([FlavorRepository])
void main() {
  late Networking network;
  late MockNetworkingDependencyProvider networkingDependencyProvider;
  late RecipeRepositoryImpl recipeRepository;
  late MockFlavorRepository flavorRepo;

  group('RecipeRepository Unit Tests', () {
    setUp(() {
      networkingDependencyProvider = MockNetworkingDependencyProvider();
      network = NetworkingImpl(dependencyProvider: networkingDependencyProvider);
      flavorRepo = MockFlavorRepository();
      when(flavorRepo.getBaseUrlHost()).thenAnswer((realInvocation) => "");
      recipeRepository =
          RecipeRepositoryImpl(network: network, flavorRepo: flavorRepo);
    });

    test(
        'Given the recipeRepo instance, when the repo returns a 200 success code, a recipe list wrapped in a success request response will be returned',
        () async {
      final mockResponse = {
        'recipes': [
          {'id': 1}
        ]
      };
      networkingDependencyProvider.setResponse(mockResponse);

      final response = await recipeRepository.getRandomRecipes();
      final recipeListResponse =
          ((response as SuccessRequestResponse<List<Recipe>, Exception>).data)
              .map((response) => response)
              .toList();
      expect(response, isA<SuccessRequestResponse<List<Recipe>, Exception>>());
      expect((response).data, recipeListResponse);
    });

    test(
        'Given the recipeRepo instance, when the repo returns a 500 error code, an error response will be returned',
        () async {
      final mockResponse = {
        'recipes': [
          {'id': 1}
        ]
      };
      networkingDependencyProvider.setResponse(mockResponse, responseCode: 500);

      final response = await recipeRepository.getRandomRecipes();

      expect(response, isA<ErrorRequestResponse<List<Recipe>, Exception>>());
    });
  });
}
