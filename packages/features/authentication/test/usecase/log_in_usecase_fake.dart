import 'package:authentication/login/data/auth_repo/models/login_error.dart';
import 'package:authentication/login/data/auth_repo/models/login_info.dart';
import 'package:authentication/login/data/auth_repo/models/user_info.dart';
import 'package:authentication/login/data/auth_repo/request_response.dart';
import 'package:authentication/login/domain/usecase/log_in_usecase.dart';

/// A fake implementation of the [LogInUseCase]. This allows us to test the [LoginScreenNotifier] without
/// having to use [LogInUseCaseImpl] as a dependency. Feel free to make any changes to fit your needs.
class LoginUseCaseFake extends LogInUseCase {
  Future<RequestResponse<UserInfo, LoginError>> response = Future.value(
      const SuccessRequestResponse(
          UserInfo(name: "", email: "", jwtToken: "")));

  void changeResponse(Future<RequestResponse<UserInfo, LoginError>> response) {
    this.response = response;
  }

  @override
  Future<RequestResponse<UserInfo, LoginError>> logIn(
      LoginInformation loginInformation) {
    return response;
  }
}
