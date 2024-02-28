import 'package:flap_app/domain/repository/flavor/flavor_repository.dart';
import 'package:flap_app/util/flavor/flavor.dart';
import 'package:flap_app/util/flavor/flavor_config.dart';

class FlavorRepositoryFake extends FlavorRepository {

  FlavorRepositoryFake.withFlavor(Flavor flavor) {
    FlavorConfig.flavor = flavor;
  }

  @override
  String getAppTitle() {
    return FlavorConfig.appTitle;
  }

  @override
  String getFlavorName() {
    return FlavorConfig.flavorName;
  }

  @override
  String getBaseUrlHost() {
    return FlavorConfig.baseUrlHost;
  }

  @override
  bool shouldMockEndpoints() {
    return FlavorConfig.shouldMockEndpoints;
  }
}
