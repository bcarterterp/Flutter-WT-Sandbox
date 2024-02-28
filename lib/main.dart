import 'package:flap_app/presentation/app_root.dart';
import 'package:flap_app/util/flavor/flavor.dart';
import 'package:flap_app/util/flavor/flavor_config.dart';
import 'package:flutter/material.dart';

void main(List<String> arguments) {
  WidgetsFlutterBinding.ensureInitialized();
  const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
  switch (flavor) {
    case 'prod':
      FlavorConfig.flavor = Flavor.prod;
      break;
    case 'mock':
      FlavorConfig.flavor = Flavor.mock;
      break;
    default:
      FlavorConfig.flavor = Flavor.dev;
      break;
  }
  runApp(AppRoot());
}
