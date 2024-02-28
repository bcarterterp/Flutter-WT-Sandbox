import 'package:authentication/login/data/auth_repo/auth_repository.dart';
import 'package:authentication/login/data/auth_repo/models/login_error.dart';
import 'package:authentication/login/data/auth_repo/models/login_info.dart';
import 'package:authentication/login/data/auth_repo/models/user_info.dart';
import 'package:authentication/login/data/auth_repo/request_response.dart';

/// A fake implementation of the [AuthRepository]. This allows us to test the [LogInUseCase] without,
/// having to worry about the network (if one were to be used). Feel free to make any changes to
/// fit your needs.
class AuthRepositoryFake extends AuthRepository {
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

  @override
  bool isLoggedIn() {
    return response is SuccessRequestResponse;
  }
}
