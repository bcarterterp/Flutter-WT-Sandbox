library networking;

import 'package:dio/dio.dart';

abstract class NetworkingDependencyProvider {
  Dio client();
}
