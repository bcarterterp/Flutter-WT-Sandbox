import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flap_app/data/source/network/mock/file_finder.dart';
import 'package:flutter/services.dart';

//This interceptor is in charge of returning the mock responses for API calls.
//It uses the list of [FileFinder] to figure out which JSON file to return.
//This interceptor should only be used in mock flavor.
class MockInterceptor extends Interceptor {
  MockInterceptor({
    required List<FileFinder> fileFinders,
  }) : _fileFinders = fileFinders;

  //refer to providers.dart to see how this is injected
  final List<FileFinder> _fileFinders;

  final String _jsonDir = 'assets/json/';

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    //Parse the uri that is being called
    final uri = Uri.parse(options.path);

    //Try to find a file that matches the uri by checking all the file finders
    for (final element in _fileFinders) {
      final jsonPath = element.getJsonPath(uri);
      //We have found a valid file path, so now we need to return the JSON response
      if (jsonPath != null) {
        final response = await getMockResponse(jsonPath);
        return handler.resolve(response);
      }
    }

    return handler.next(options);
  }

  //This method is in charge of returning the JSON response from the file path given
  Future<Response> getMockResponse(String jsonPath) async {
    final resourcePath = _jsonDir + jsonPath;
    final data = await rootBundle.load(resourcePath);
    final map = json.decode(
      utf8.decode(
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
      ),
    );

    return Response(
      requestOptions: RequestOptions(),
      data: map,
      statusCode: 200,
    );
  }
}
