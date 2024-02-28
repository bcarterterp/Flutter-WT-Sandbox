import 'package:authentication/authentication.dart';
import 'package:authentication/login/data/auth_repo/models/login_error.dart';
import 'package:authentication/login/presentation/view/login_screen.dart';
import 'package:authentication/login/presentation/viewmodel/login_screen_state.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../lib/mock/mock_secure_storage.dart';
import '../usecase/log_in_usecase_fake.dart';
import 'viewmodel/login_screen_viewmodel_fake.dart';

class AuthenticationFake implements AuthenticationProtocol {
  @override
  Widget startLoginFlow(void Function(bool p1) completion) {
    final loginUseCaseFake = LoginUseCaseFake();
    final secureStorageFake = MockSecureStorage();

    final LoginScreenViewModelFake loginViewModelFake =
        LoginScreenViewModelFake(
            logInUseCase: loginUseCaseFake,
            storageService: secureStorageFake,
            completion: (p0) {});
    loginViewModelFake
        .changeResponse(LoginScreenState.error(LoginError.jwtSaveUnsuccessful));
    return LoginScreen(
        viewModel: LoginScreenViewModelFake(
            logInUseCase: loginUseCaseFake,
            storageService: secureStorageFake,
            completion: (p0) {}));
  }

  @override
  bool isLoggedIn() {
    // TODO: implement isLoggedIn
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
