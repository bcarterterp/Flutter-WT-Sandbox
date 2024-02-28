import 'package:flap_app/data/source/network/mock/file_finder.dart';

/// This [FileFinder] helps in figuring out which file to deliver for spoonacular API calls.
/// Feel free to configure this however you would like!
class SpoonacularFileFinder extends FileFinder {
  final String host = 'api.spoonacular.com';
  final String path = '/recipes/random';

  @override
  String? getJsonPath(Uri uri) {
    if (host != uri.host || path != uri.path) {
      return null;
    }
    return 'spoonacular/recipes/random/first_twenty.json';
  }
}
