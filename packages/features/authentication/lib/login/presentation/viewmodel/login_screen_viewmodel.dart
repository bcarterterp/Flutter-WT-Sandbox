import 'package:authentication/login/presentation/viewmodel/event.dart';
import 'package:authentication/login/data/auth_repo/request_response.dart';
import 'package:authentication/login/data/auth_repo/models/user_info.dart';
import 'package:authentication/login/data/auth_repo/models/login_error.dart';
import 'package:authentication/login/data/auth_repo/models/login_info.dart';
import 'package:authentication/login/data/secure_storage_repo/storage_error.dart';
import 'package:authentication/login/data/secure_storage_repo/storage_service.dart';
import 'package:authentication/login/domain/usecase/log_in_usecase.dart';
import 'package:authentication/login/presentation/viewmodel/login_screen_state.dart';
import 'package:flutter/material.dart';

class LoginScreenViewModel {
  LoginScreenViewModel(
      {required this.logInUseCase,
      required this.storageService,
      required this.completion});

  final ValueNotifier<LoginScreenState> state =
      ValueNotifier<LoginScreenState>(LoginScreenState.initial());
  LogInUseCase logInUseCase;
  StorageService storageService;
  void Function(bool) completion;

  Future<void> login(String email, String password) async {
    if (state.value.loginEvent is LoadingEvent) {
      return;
    }

    state.value = LoginScreenState.loading();

    final response = await logInUseCase.logIn(
      LoginInformation(
        email: email,
        password: password,
      ),
    );

    switch (response) {
      case SuccessRequestResponse<UserInfo, LoginError>():
        final jwtSaveSuccessful = await _saveJwt(response.data.jwtToken);
        print(jwtSaveSuccessful);

        if (jwtSaveSuccessful) {
          state.value = LoginScreenState.success(response.data);
          // call completion
          completion(true);
        } else {
          state.value = LoginScreenState.error(LoginError.jwtSaveUnsuccessful);
        }
      case ErrorRequestResponse<UserInfo, LoginError>():
        state.value = LoginScreenState.error(response.error);
    }
  }

  Future<bool> _saveJwt(String token) async {
    final saveToken = await storageService.writeJwt(token);
    return saveToken is SuccessRequestResponse<String, StorageError>;
  }
}
