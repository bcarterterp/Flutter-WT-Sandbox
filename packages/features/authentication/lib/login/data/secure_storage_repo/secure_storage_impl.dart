import 'package:authentication/login/data/auth_repo/request_response.dart';
import 'package:authentication/login/data/secure_storage_repo/storage_error.dart';
import 'package:authentication/login/data/secure_storage_repo/storage_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageImpl extends StorageService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final String _jwtTokenKey = 'jwt_token';
  String? token;

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  @override
  Future<RequestResponse<String?, StorageError>> readJwt() async {
    try {
      final data = await _secureStorage.read(
          key: _jwtTokenKey, aOptions: _getAndroidOptions());
      return SuccessRequestResponse(data);
    } on Exception catch (_) {
      return const ErrorRequestResponse(StorageError.readError);
    }
  }

  @override
  Future<RequestResponse<String, StorageError>> deleteJwt() async {
    try {
      await _secureStorage.delete(
          key: _jwtTokenKey, aOptions: _getAndroidOptions());
      token = null;
      return const SuccessRequestResponse('Successfully deleted JWT');
    } on Exception catch (_) {
      return const ErrorRequestResponse(StorageError.deleteError);
    }
  }

  @override
  Future<RequestResponse<String, StorageError>> writeJwt(String token) async {
    try {
      await _secureStorage.write(
          key: _jwtTokenKey, value: token, aOptions: _getAndroidOptions());
      token = token;
      return const SuccessRequestResponse('Successfully saved JWT');
    } on Exception catch (_) {
      return const ErrorRequestResponse(StorageError.writeError);
    }
  }
}
