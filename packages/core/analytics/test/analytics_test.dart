import 'package:analytics/analytics.dart';
import 'package:analytics/mock/mock_analytics_dependency_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('analytics tests', () {
    test('Given the analytics log event is called, then fire base log event should also be called', () async {
      final mockAnalyticsDependencyProvider = MockAnalyticsDependencyProvider();
      final firebaseAnalytics =
          Analytics(dependencyProvider: mockAnalyticsDependencyProvider);
      await firebaseAnalytics.logEvent("test", {});
      expect(mockAnalyticsDependencyProvider.mockFirebaseAnalytics.nameTest,
          "test");
    });
  });
}
