import 'package:analytics/analytics.dart';
import 'package:authentication/authentication.dart';
import 'package:flap_app/data/repository/analytics/analytics_platform_manager.dart';
import 'package:flap_app/data/repository/auth/auth_repository_impl.dart';
import 'package:flap_app/domain/repository/flavor/flavor_repository_impl.dart';
import 'package:flap_app/presentation/app_router.dart';
import 'package:flap_app/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:networking/networking.dart';

abstract class AppRootDependencyProvider {
  Authentication authentication();
  Networking network();
  Analytics analytics();
}

class AppRoot extends StatelessWidget {
  final AppRouter appRouter;

  final flavorRepository = FlavorRepositoryImpl();
  final theme = const AppTheme();

  AppRoot._(this.appRouter);

  factory AppRoot({AppRootDependencyProvider? dependencyProvider}) {
    final authentication =
        dependencyProvider?.authentication() ?? AuthenticationImpl();
    final network = dependencyProvider?.network() ?? NetworkingImpl();
    final analytics = dependencyProvider?.analytics() ?? AnalyticsImpl();

    final authRepository = AuthRepositoryImpl(authentication: authentication);
    final analyticsRepository = AnalyticsRepositoryImpl(analytics: analytics);

    final appRouter = AppRouter(
        network: network,
        authRepository: authRepository,
        analyticsRepository: analyticsRepository);

    return AppRoot._(appRouter);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: flavorRepository.getAppTitle(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: theme.toThemeData(),
        darkTheme: theme.toThemeDataDark(),
        routerConfig: appRouter.buildRouterConfig());
  }
}
