import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:networking/networking_dependency_provider.dart';

class MockDio extends Mock implements Dio {
  late Map<String, dynamic> _responseData;
  late int _responseCode;

  @override
  Future<Response<T>> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    final RequestOptions requestOptions =
        options?.compose(BaseOptions(), path) ?? RequestOptions(path: path);

    if (_responseCode == 200) {
      return Future.value(Response<T>(
          data: _responseData as T,
          statusCode: _responseCode,
          requestOptions: requestOptions));
    } else {
      return Future.value(Response<Exception>(
          data: null,
          statusCode: _responseCode,
          requestOptions: requestOptions) as FutureOr<Response<T>>?);
    }
  }

  void setResponse(Map<String, dynamic> responseData,
      {int responseCode = 200}) {
    _responseData = responseData;
    _responseCode = responseCode;
  }
}

class MockNetworkingDependencyProvider extends NetworkingDependencyProvider {
  MockDio mockDioClient = MockDio();

  @override
  Dio client() {
    return mockDioClient;
  }

  void setResponse(dynamic responseData, {int responseCode = 200}) {
    mockDioClient.setResponse(responseData, responseCode: responseCode);
  }
}
