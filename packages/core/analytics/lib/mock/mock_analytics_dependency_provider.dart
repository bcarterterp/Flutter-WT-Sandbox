import 'package:analytics/analytics_dependency_provider.dart';
import 'package:analytics/mock/mock_firebase_analytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class MockAnalyticsDependencyProvider implements AnalyticsDependencyProvider {
  MockFirebaseAnalytics mockFirebaseAnalytics = MockFirebaseAnalytics();

  @override
  FirebaseAnalytics? firebaseAnalytics() {
    return mockFirebaseAnalytics;
  }

  
}
