import 'package:authentication/authentication.dart';
import 'package:authentication/login/presentation/view/login_screen.dart';
import 'package:authentication/mock/mock_auth_dependency_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Authentication class Unit Tests", () {
    late Authentication authentication;
    setUp(() {
      final mockDependencyProvider = MockAuthenticationDependencyProvider();
      authentication =
          Authentication(dependencyProvider: mockDependencyProvider);
    });

    test(
      "When startLoginFlow is called, then a login screen widget should return",
      () {
        final loginScreen = authentication.startLoginFlow((p0) {});
        expect(loginScreen, isA<LoginScreen>());
        expect(loginScreen.viewModel.completion, isA<Function(bool)>());
      },
    );

    test(
      "When logout is called, then deleteJwt method should be called in secure storage",
      () async {
        final mockDependencyProvider = MockAuthenticationDependencyProvider();
        final authentication =
            Authentication(dependencyProvider: mockDependencyProvider);
        await authentication.logout();
        expect(mockDependencyProvider.mockSecureStorage.didCallDeleteJwt, true);
      },
    );

    test(
      "When isLoggedIn is called and the jwt token is not null, then return true",
      () async {
        final mockDependencyProvider = MockAuthenticationDependencyProvider();
        final authentication =
            Authentication(dependencyProvider: mockDependencyProvider);
        final responseNoToken = authentication.isLoggedIn();
        expect(responseNoToken, false);
        mockDependencyProvider.mockSecureStorage.token = "test";
        final responseTokenAvailable = authentication.isLoggedIn();
        expect(responseTokenAvailable, true);
      },
    );
  });
}
