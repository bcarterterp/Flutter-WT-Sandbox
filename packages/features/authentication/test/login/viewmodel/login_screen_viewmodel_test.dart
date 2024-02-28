import 'package:authentication/login/data/auth_repo/models/login_error.dart';
import 'package:authentication/login/data/auth_repo/models/user_info.dart';
import 'package:authentication/login/data/auth_repo/request_response.dart';
import 'package:authentication/login/data/secure_storage_repo/storage_error.dart';
import 'package:authentication/login/presentation/viewmodel/login_screen_state.dart';
import 'package:authentication/login/presentation/viewmodel/login_screen_viewmodel.dart';

import 'package:flutter_test/flutter_test.dart';

import '../../../lib/mock/mock_secure_storage.dart';
import '../../usecase/log_in_usecase_fake.dart';

void main() {
  group("LoginScreenViewModel Unit Tests", () {
    late LoginUseCaseFake loginUseCase;
    late MockSecureStorage secureStorageFake;

    setUp(() {
      loginUseCase = LoginUseCaseFake();
      secureStorageFake = MockSecureStorage();
    });

    test(
      "Given LoginScreenViewModel, with no actions taken, then LoginScreenState should be initial.",
      () async {
        final loginScreenViewModel = LoginScreenViewModel(
            logInUseCase: loginUseCase,
            storageService: secureStorageFake,
            completion: (p) {});
        final initialState = loginScreenViewModel.state.value;
        expect(initialState, LoginScreenState.initial());
      },
    );

    test(
      "Given LoginScreenViewModel, with login called and LoginError.emptyEmail returned, then loading and emptyEmail error states should be returned",
      () async {
        final loginScreenViewModel = LoginScreenViewModel(
            logInUseCase: loginUseCase,
            storageService: secureStorageFake,
            completion: (p) {});

        // Set up mock error response
        const loginUseCaseResponse =
            ErrorRequestResponse<UserInfo, LoginError>(LoginError.emptyEmail);
        loginUseCase.changeResponse(Future.value(loginUseCaseResponse));

        expect(loginScreenViewModel.state.value, LoginScreenState.initial());

        final login = loginScreenViewModel.login('email', 'password');

        expect(loginScreenViewModel.state.value, LoginScreenState.loading());

        login.whenComplete(() => expect(loginScreenViewModel.state.value,
            LoginScreenState.error(loginUseCaseResponse.error)));
      },
    );

    test(
      "Given loginScreenViewModel, with login called and LoginError.emptyPassword returned, then loading and emptyPassword error states should be returned",
      () async {
        final loginScreenViewModel = LoginScreenViewModel(
            logInUseCase: loginUseCase,
            storageService: secureStorageFake,
            completion: (p) {});

        // Set up mock error response
        const loginUseCaseResponse = ErrorRequestResponse<UserInfo, LoginError>(
            LoginError.emptyPassword);
        loginUseCase.changeResponse(Future.value(loginUseCaseResponse));

        expect(loginScreenViewModel.state.value, LoginScreenState.initial());

        final login = loginScreenViewModel.login('email', 'password');

        expect(loginScreenViewModel.state.value, LoginScreenState.loading());

        login.whenComplete(() => expect(loginScreenViewModel.state.value,
            LoginScreenState.error(loginUseCaseResponse.error)));
      },
    );

    test(
      "Given loginScreenViewModel, with login called and LoginError.incorrectEmailOrPassword returned, then loading and invalidEmailOrPassword error states should be returned",
      () async {
        final loginScreenViewModel = LoginScreenViewModel(
            logInUseCase: loginUseCase,
            storageService: secureStorageFake,
            completion: (p) {});

        // Set up mock error response
        const loginUseCaseResponse = ErrorRequestResponse<UserInfo, LoginError>(
            LoginError.incorrectEmailOrPassword);
        loginUseCase.changeResponse(Future.value(loginUseCaseResponse));

        expect(loginScreenViewModel.state.value, LoginScreenState.initial());

        final login = loginScreenViewModel.login('email', 'password');

        expect(loginScreenViewModel.state.value, LoginScreenState.loading());

        login.whenComplete(() => expect(loginScreenViewModel.state.value,
            LoginScreenState.error(loginUseCaseResponse.error)));
      },
    );

    test(
      "Given loginScreenViewModel, with login called and LoginError.jwtSaveUnsuccessful returned, then loading and jwtSaveUnsuccessful error states should be returned",
      () async {
        final loginScreenViewModel = LoginScreenViewModel(
            logInUseCase: loginUseCase,
            storageService: secureStorageFake,
            completion: (p) {});

        // Set up mock error response
        const storageResponse =
            ErrorRequestResponse<String, StorageError>(StorageError.writeError);
        secureStorageFake.changeWriteResponse(Future.value(storageResponse));

        expect(loginScreenViewModel.state.value, LoginScreenState.initial());

        final login = loginScreenViewModel.login('email', 'password');

        expect(loginScreenViewModel.state.value, LoginScreenState.loading());

        login.whenComplete(() => expect(loginScreenViewModel.state.value,
            LoginScreenState.error(LoginError.jwtSaveUnsuccessful)));
      },
    );

    test(
      "Given loginScreenViewModel, with login called and Success returned, then loading and successful states should be returned",
      () async {
        final loginScreenViewModel = LoginScreenViewModel(
            logInUseCase: loginUseCase,
            storageService: secureStorageFake,
            completion: (p) {});

        // Set up mock error response
        const loginUseCaseResponse =
            SuccessRequestResponse<UserInfo, LoginError>(
                UserInfo(name: "test", email: "test@test", jwtToken: "123"));
        loginUseCase.changeResponse(Future.value(loginUseCaseResponse));

        expect(loginScreenViewModel.state.value, LoginScreenState.initial());

        final login = loginScreenViewModel.login('email', 'password');

        expect(loginScreenViewModel.state.value, LoginScreenState.loading());

        login.whenComplete(() => expect(loginScreenViewModel.state.value,
            LoginScreenState.success(loginUseCaseResponse.data)));
      },
    );
  });
}
