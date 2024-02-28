// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

/// This class is used to access the environment variables.
/// environment variables are defined in the .env file at the root of the project.
///
/// To generate env.g.dart, run the command:
///    flutter pub run build_runner build --delete-conflicting-outputs
///
/// To update env.g.dart, run the command:
///    flutter pub run build_runner clean && flutter pub run build_runner build --delete-conflicting-outputs
///
/// If you get a message stating "Environment variable not found for field", comment out the class
/// and run the command again. This is an open issue with Envied: https://github.com/petercinibulk/envied/issues/59

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'SPOONACULAR_API_KEY', obfuscate: true)
  static final String spoonacularApiKey = _Env.spoonacularApiKey;
}
