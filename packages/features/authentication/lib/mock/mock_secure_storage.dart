import 'package:authentication/login/data/auth_repo/request_response.dart';
import 'package:authentication/login/data/secure_storage_repo/secure_storage_impl.dart';
import 'package:authentication/login/data/secure_storage_repo/storage_error.dart';

class MockSecureStorage extends SecureStorageImpl {
  bool? didCallDeleteJwt;

  Future<RequestResponse<String, StorageError>> writeResponse =
      Future.value(const SuccessRequestResponse('Successfully saved jwt'));

  @override
  Future<RequestResponse<String, StorageError>> deleteJwt() async {
    didCallDeleteJwt = true;
    return const SuccessRequestResponse('Successfully deleted');
  }

  @override
  Future<RequestResponse<String?, StorageError>> readJwt() async {
    return const SuccessRequestResponse('test_jwt');
  }

  Future<RequestResponse<String?, StorageError>> readJwtError() async {
    return const ErrorRequestResponse(StorageError.readError);
  }

  void changeWriteResponse(
      Future<RequestResponse<String, StorageError>> writeResponse) {
    this.writeResponse = writeResponse;
  }

  @override
  Future<RequestResponse<String, StorageError>> writeJwt(String token) async {
    return writeResponse;
  }
}
