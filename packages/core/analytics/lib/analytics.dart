import 'package:analytics/analytics_dependency_provider.dart';
import 'package:analytics/firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

abstract class AnalyticsProtocol {
  logEvent(String name, Map<String, Object> parameters);
  setUserProperties(String name, Map<String, Object> parameters);
  screenView(String screenName);
}

class Analytics implements AnalyticsProtocol {
  Analytics._(this._analyticsDependencyProvider);

  factory Analytics({AnalyticsDependencyProvider? dependencyProvider}) {
    return Analytics._(dependencyProvider);
  }

  AnalyticsDependencyProvider? _analyticsDependencyProvider;
  late final Future<FirebaseAnalytics> _firebaseAnalytics = _initialize();

  Future<FirebaseAnalytics> _initialize() async {
    final providedAnalytics = _analyticsDependencyProvider?.firebaseAnalytics();

    if (providedAnalytics != null) {
      return providedAnalytics;
    } else {
      final firebaseApp = await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      return FirebaseAnalytics.instanceFor(app: firebaseApp);
    }
  }

  @override
  logEvent(String name, Map<String, Object> parameters) async {
    (await _firebaseAnalytics).logEvent(name: name);
    debugPrint("$name event sent");
  }

  @override
  screenView(String screenName) {}

  @override
  setUserProperties(String name, Map<String, Object> parameters) {}
}
