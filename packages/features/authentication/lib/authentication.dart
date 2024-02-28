library authentication;

import 'package:authentication/login/data/auth_repo/auth_repository_impl.dart';
import 'package:authentication/login/data/secure_storage_repo/secure_storage_impl.dart';
import 'package:authentication/login/domain/usecase/log_in_usecase_impl.dart';
import 'package:authentication/login/presentation/view/login_screen.dart';
import 'package:authentication/login/presentation/viewmodel/login_screen_viewmodel.dart';
import 'package:flutter/material.dart';

abstract class Authentication {
  LoginScreen startLoginFlow(void Function(bool) completion);
  Future<void> logout();
  bool isLoggedIn();
}

class AuthenticationImpl implements Authentication {
  AuthenticationImpl._(this.storageService);

  SecureStorageImpl storageService;

  factory AuthenticationImpl(
      {AuthenticationDependencyProvider? dependencyProvider}) {
    return AuthenticationImpl._(
        dependencyProvider?.secureStorage() ?? SecureStorageImpl());
  }

  // MARK: - AuthenticationProtocol Methods

  @override
  LoginScreen startLoginFlow(void Function(bool) completion) {
    final authRepository = AuthRepositoryImpl();
    final logInUseCase = LogInUseCaseImpl(authRepository: authRepository);
    final loginScreenViewModel = LoginScreenViewModel(
        logInUseCase: logInUseCase,
        storageService: storageService,
        completion: completion);
    return LoginScreen(viewModel: loginScreenViewModel);
  }

  @override
  Future<void> logout() async {
    storageService.deleteJwt();
  }

  @override
  bool isLoggedIn() {
    if (storageService.token != null) {
      return true;
    }
    return false;
  }
}

abstract class AuthenticationDependencyProvider {
  SecureStorageImpl secureStorage();
}
