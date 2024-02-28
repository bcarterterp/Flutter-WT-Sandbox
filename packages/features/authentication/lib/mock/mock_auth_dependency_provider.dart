import 'package:authentication/authentication.dart';
import 'package:authentication/login/data/secure_storage_repo/secure_storage_impl.dart';
import 'package:authentication/mock/mock_secure_storage.dart';

class MockAuthenticationDependencyProvider
    implements AuthenticationDependencyProvider {
  MockSecureStorage mockSecureStorage = MockSecureStorage();

  @override
  SecureStorageImpl secureStorage() {
    return mockSecureStorage;
  }
}
