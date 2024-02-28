import 'package:dio/dio.dart';
import 'package:networking/networking_dependency_provider.dart';

abstract class Networking {
  Future<dynamic> get(String url);
}

class NetworkingImpl implements Networking {
  NetworkingImpl._(this._client);

  Dio _client;

  factory NetworkingImpl({NetworkingDependencyProvider? dependencyProvider}) {
    return NetworkingImpl._(dependencyProvider?.client() ?? Dio());
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
