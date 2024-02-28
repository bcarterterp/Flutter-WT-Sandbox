import 'package:authentication/login/data/auth_repo/models/login_error.dart';
import 'package:authentication/login/data/auth_repo/models/login_info.dart';
import 'package:authentication/login/data/auth_repo/request_response.dart';
import 'package:authentication/login/data/auth_repo/models/user_info.dart';
import 'package:authentication/login/data/auth_repo/auth_repository.dart';
import 'package:authentication/login/domain/usecase/log_in_usecase.dart';

/// The UseCase is to encapsulate your business logic. It is the connection between the presentation layer and the data layer.
/// For this example the business logic is checking for local errors before requesting login, which is an empty email or an empty password.
class LogInUseCaseImpl extends LogInUseCase {
  LogInUseCaseImpl({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  @override
  Future<RequestResponse<UserInfo, LoginError>> logIn(
      LoginInformation loginInformation) {
    final email = loginInformation.email;
    final password = loginInformation.password;
    if (email.isEmpty) {
      return Future.value(const ErrorRequestResponse(LoginError.emptyEmail));
    } else if (password.isEmpty) {
      return Future.value(const ErrorRequestResponse(LoginError.emptyPassword));
    }
    return _authRepository.logIn(loginInformation);
  }
}
