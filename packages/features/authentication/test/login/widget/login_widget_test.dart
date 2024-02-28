// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:authentication/authentication.dart';
import 'package:authentication/login/data/auth_repo/models/login_error.dart';
import 'package:authentication/login/data/auth_repo/request_response.dart';
import 'package:authentication/login/data/secure_storage_repo/storage_error.dart';
import 'package:authentication/login/presentation/viewmodel/login_screen_state.dart';
import 'package:authentication/mock/mock_auth_dependency_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../lib/mock/mock_secure_storage.dart';
import '../../usecase/log_in_usecase_fake.dart';
import '../login_screen.dart';
import '../viewmodel/login_screen_viewmodel_fake.dart';

void main() {
  // Note: This group performs the same validation as the integration
  // test example, difference being that these tests do not require
  // launching the app on an emulator for validation
  group('LoginScreen Widget Tests', () {
    final loginScreenElements = LoginScreenElements("App Title");
    late MaterialApp app;
    late MockAuthenticationDependencyProvider
        mockAuthenticationDependencyProvider;
    setUp(() {
      mockAuthenticationDependencyProvider =
          MockAuthenticationDependencyProvider();
      final auth = AuthenticationImpl(
          dependencyProvider: mockAuthenticationDependencyProvider);
      final loginScreen = auth.startLoginFlow((p0) {});
      app = MaterialApp(home: loginScreen);
    });

    group("Unit tests with fake Login Screen viewmodel", () {
      testWidgets(
          'Given LoginScreen is initial state, when nothing is done, then there should be no errors present.',
          (WidgetTester tester) async {
        await tester.pumpWidget(app);

        // Verify no errors present at first
        expect(loginScreenElements.emailCheckError, findsNothing);
        expect(loginScreenElements.passwordEmptyError, findsNothing);
        expect(loginScreenElements.passwordCheckError, findsNothing);
      });

      testWidgets(
          'Given LoginScreen is initial state, when user tries to click login button with no email, then empty email error should be present.',
          (WidgetTester tester) async {
        await tester.pumpWidget(app);
        await tester.enterText(loginScreenElements.passwordField, "test");
        await tester
            .runAsync(() => tester.tap(loginScreenElements.loginButton));
        // pumpAndSettle is used in this case to wait for loading
        // animation to be complete in between login button taps
        await tester.pump(const Duration(seconds: 2));
        expect(loginScreenElements.emailEmptyError, findsOneWidget);
        expect(loginScreenElements.emailCheckError, findsNothing);
        expect(loginScreenElements.passwordEmptyError, findsNothing);
        expect(loginScreenElements.passwordCheckError, findsNothing);
      });

      testWidgets(
          'Given LoginScreen is initial state, when user tries to click login button with no password, then empty password error should be present.',
          (WidgetTester tester) async {
        final auth = AuthenticationImpl();
        final loginScreen = auth.startLoginFlow((p0) {});
        final app = MaterialApp(home: loginScreen);

        await tester.pumpWidget(app);

        final loginUseCaseFake = LoginUseCaseFake();
        final secureStorageFake = MockSecureStorage();

        final LoginScreenViewModelFake loginViewModelFake =
            LoginScreenViewModelFake(
                logInUseCase: loginUseCaseFake,
                storageService: secureStorageFake,
                completion: (p0) {});
        await tester.pumpWidget(app);
        loginViewModelFake
            .changeResponse(LoginScreenState.error(LoginError.emptyPassword));
        // Enter email text
        await tester.enterText(loginScreenElements.emailField, "test@test.com");
        // Trigger empty error state for password
        await tester.tap(loginScreenElements.loginButton);
        await tester.pumpAndSettle();
        expect(loginScreenElements.emailEmptyError, findsNothing);
        expect(loginScreenElements.emailCheckError, findsNothing);
        expect(loginScreenElements.passwordEmptyError, findsOneWidget);
        expect(loginScreenElements.passwordCheckError, findsNothing);
      });

      testWidgets(
          'Given LoginScreen is initial state, when user enters incorrect email/password and clicks login button, then both email and password error should be present.',
          (WidgetTester tester) async {
        // Causes test to wait for app to finish launch before testing
        final auth = AuthenticationImpl();
        final loginScreen = auth.startLoginFlow((p0) {});
        final app = MaterialApp(home: loginScreen);

        await tester.pumpWidget(app);

        final loginUseCaseFake = LoginUseCaseFake();
        final secureStorageFake = MockSecureStorage();

        final LoginScreenViewModelFake loginViewModelFake =
            LoginScreenViewModelFake(
                logInUseCase: loginUseCaseFake,
                storageService: secureStorageFake,
                completion: (p0) {});
        await tester.pumpWidget(app);
        loginViewModelFake.changeResponse(
            LoginScreenState.error(LoginError.incorrectEmailOrPassword));
        // Enter email text
        await tester.enterText(loginScreenElements.emailField, "test@test.com");
        // Enter text in password field
        await tester.enterText(loginScreenElements.passwordField, "testPass!");
        // Trigger check error states
        await tester.tap(loginScreenElements.loginButton);
        await tester.pumpAndSettle();
        expect(loginScreenElements.emailEmptyError, findsNothing);
        expect(loginScreenElements.emailCheckError, findsOneWidget);
        expect(loginScreenElements.passwordEmptyError, findsNothing);
        expect(loginScreenElements.passwordCheckError, findsOneWidget);
      });

      testWidgets(
          'Given LoginScreen is initial state, when user enters correct email/password but jwt fails to save, then general error should be present',
          (WidgetTester tester) async {
        await tester.pumpWidget(app);
        final Future<RequestResponse<String, StorageError>> errorResponse =
            Future.value(const ErrorRequestResponse(StorageError.writeError));

        mockAuthenticationDependencyProvider.mockSecureStorage
            .changeWriteResponse(errorResponse);

        // Enter email text
        await tester.enterText(
            loginScreenElements.emailField, "admin@testing.com");
        // Enter text in password field
        await tester.enterText(loginScreenElements.passwordField, "admin");
        // Trigger check error states
        await tester.tap(loginScreenElements.loginButton);
        await tester.pump(const Duration(seconds: 5));

        expect(loginScreenElements.emailEmptyError, findsNothing);
        expect(loginScreenElements.emailCheckError, findsNothing);
        expect(loginScreenElements.passwordEmptyError, findsNothing);
        expect(loginScreenElements.passwordCheckError, findsNothing);
        expect(loginScreenElements.generalError, findsOneWidget);
      });
    });
  });
}
