import 'package:authentication/login/presentation/viewmodel/login_screen_state.dart';
import 'package:authentication/login/presentation/viewmodel/login_screen_viewmodel.dart';
import 'package:flutter/material.dart';

class LoginScreenViewModelFake extends LoginScreenViewModel {
  LoginScreenViewModelFake({required super.logInUseCase, required super.storageService, required super.completion});

  final ValueNotifier<LoginScreenState> state = ValueNotifier<LoginScreenState>(LoginScreenState.initial());

  void changeResponse(LoginScreenState response) {
    state.value = response;
  }
}
