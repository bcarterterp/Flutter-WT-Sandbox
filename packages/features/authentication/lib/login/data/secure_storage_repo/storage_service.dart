import 'package:authentication/login/data/auth_repo/request_response.dart';
import 'package:authentication/login/data/secure_storage_repo/storage_error.dart';

abstract class StorageService {
  Future<RequestResponse<String, StorageError>> writeJwt(String token);

  Future<RequestResponse<String?, StorageError>> readJwt();

  Future<RequestResponse<String, StorageError>> deleteJwt();
}
