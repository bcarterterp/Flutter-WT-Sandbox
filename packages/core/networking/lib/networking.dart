import 'package:dio/dio.dart';
import 'package:networking/networking_dependency_provider.dart';

abstract class NetworkingProtocol {
  Future<dynamic> get(String url);
}

class Networking implements NetworkingProtocol {
  Networking._(this._client);

  Dio _client;

  factory Networking({NetworkingDependencyProvider? dependencyProvider}) {
    return Networking._(dependencyProvider?.client() ?? Dio());
  }

  @override
  Future<dynamic> get(String url) async {
    try {
      final response = await _client.get(url);
      return response.data;
    } catch (e) {
      print('Network: Error during GET request: $e');
      rethrow;
    }
  }
}
