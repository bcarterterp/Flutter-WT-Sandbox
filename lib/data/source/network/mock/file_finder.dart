/// FileFinder is an abstract class that is used to connect a URI to a JSON file.
abstract class FileFinder {
  String? getJsonPath(Uri uri);
}
