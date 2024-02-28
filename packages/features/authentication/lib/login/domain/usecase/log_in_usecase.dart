import 'package:authentication/login/data/auth_repo/models/login_error.dart';
import 'package:authentication/login/data/auth_repo/models/login_info.dart';
import 'package:authentication/login/data/auth_repo/request_response.dart';
import 'package:authentication/login/data/auth_repo/models/user_info.dart';

abstract class LogInUseCase {
  Future<RequestResponse<UserInfo, LoginError>> logIn(
      LoginInformation loginInformation);
}
