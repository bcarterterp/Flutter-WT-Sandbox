import 'package:flutter_test/flutter_test.dart';
import 'package:networking/networking.dart';

import 'package:networking/mocks/mock_networking_dependency_provider.dart';

void main() {
  group('networking tests', () {
    test('GET request should return response body', () async {
      const mockResponse = {
        "test": {"field": "value"}
      };
      final mockDependencyProvider = MockNetworkingDependencyProvider();
      (mockDependencyProvider.client() as MockDio).setResponse(mockResponse);

      Networking network =
          Networking(dependencyProvider: mockDependencyProvider);

      final response = await network.get('test.com');
      expect(response, mockResponse);
    });
  });
}
