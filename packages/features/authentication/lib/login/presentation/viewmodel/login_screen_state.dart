import 'package:authentication/login/presentation/viewmodel/event.dart';
import 'package:authentication/login/data/auth_repo/models/user_info.dart';
import 'package:equatable/equatable.dart';
import 'package:authentication/login/data/auth_repo/models/login_error.dart';

/// Class to hold the state of the login page.
class LoginScreenState extends Equatable {
  const LoginScreenState({
    required this.loginEvent,
    this.emailError,
    this.passwordError,
    this.jwtError,
  });

  factory LoginScreenState.initial() => LoginScreenState(
        loginEvent: InitialEvent(),
      );

  factory LoginScreenState.loading() => LoginScreenState(
        loginEvent: LoadingEvent(),
      );

  factory LoginScreenState.success(UserInfo userInfo) => LoginScreenState(
        loginEvent: SuccessEvent(userInfo),
      );

  factory LoginScreenState.error(LoginError error) => _onError(error);

  final Event<UserInfo, LoginError> loginEvent;
  final String? emailError;
  final String? passwordError;
  final String? jwtError;

  LoginScreenState copyWith({
    Event<UserInfo, LoginError>? loginEvent,
    String? emailError,
    String? passwordError,
    String? jwtError,
  }) {
    return LoginScreenState(
      loginEvent: loginEvent ?? this.loginEvent,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      jwtError: jwtError ?? this.jwtError,
    );
  }

  static LoginScreenState _onError(LoginError error) {
    switch (error) {
      case LoginError.emptyEmail:
        return LoginScreenState(
          loginEvent: EventError(error),
          emailError: 'Email is empty',
        );
      case LoginError.emptyPassword:
        return LoginScreenState(
          loginEvent: EventError(error),
          passwordError: 'Password is empty',
        );
      case LoginError.incorrectEmailOrPassword:
        return LoginScreenState(
          loginEvent: EventError(error),
          emailError: 'Check your email',
          passwordError: 'Check your password',
        );
      case LoginError.jwtSaveUnsuccessful:
        return LoginScreenState(
          loginEvent: EventError(error),
          jwtError: 'An error occured. Please try logging in again.',
        );
    }
  }

  bool isLoading() {
    return loginEvent is LoadingEvent;
  }

  bool isSuccess() {
    return loginEvent is SuccessEvent;
  }

  @override
  List<Object?> get props => [loginEvent];
}
