import 'package:analytics/analytics.dart';
import 'package:flap_app/domain/repository/analytics/analytics_platform.dart';

class AnalyticsRepositoryImpl extends AnalyticsRepository {
  AnalyticsRepositoryImpl({
    required this.analytics,
  });

  /// List of analytics platforms to send events to.
  final AnalyticsProtocol analytics;

  @override
  void logEvent(String name, Map<String, Object> parameters) {
    analytics.logEvent(name, parameters);
  }

  @override
  void setUserProperties(String userId, Map<String, Object> properties) {
    analytics.setUserProperties(userId, properties);
  }

  @override
  void screenView(String screenName) {
    analytics.screenView(screenName);
  }
}
