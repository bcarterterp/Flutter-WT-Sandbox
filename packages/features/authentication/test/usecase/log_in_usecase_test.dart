import 'package:authentication/login/data/auth_repo/models/login_error.dart';
import 'package:authentication/login/data/auth_repo/models/login_info.dart';
import 'package:authentication/login/data/auth_repo/models/user_info.dart';
import 'package:authentication/login/data/auth_repo/request_response.dart';
import 'package:authentication/login/domain/usecase/log_in_usecase_impl.dart';
import 'package:flutter_test/flutter_test.dart';

import 'auth_repository_fake.dart';

main() {
  final authRepository = AuthRepositoryFake();

  group("LogInUseCase Unit Tests", () {
    test(
      "Given initial LogInUseCase, when LoginInformation passes email and password requirements, then SuccessRequestResponse should be returned.",
      () async {
        const userInfo = UserInfo(name: "test", email: "test", jwtToken: "");
        authRepository.changeResponse(
            Future.value(const SuccessRequestResponse(userInfo)));
        final useCase = LogInUseCaseImpl(authRepository: authRepository);

        final response = await useCase.logIn(
          const LoginInformation(
            email: "email",
            password: "password",
          ),
        );
        //Note: Must reinforce generic typing here because dart checks typing.
        expect(response,
            const SuccessRequestResponse<UserInfo, LoginError>(userInfo));
      },
    );

    test(
      "Given initial LogInUseCase, when blank email is sent, then ErrorRequestResponse with LoginError.emptyEmail is returned",
      () async {
        final useCase = LogInUseCaseImpl(authRepository: authRepository);
        final response = await useCase.logIn(
          const LoginInformation(
            email: "",
            password: "password",
          ),
        );
        const expected =
            ErrorRequestResponse<UserInfo, LoginError>(LoginError.emptyEmail);
        expect(response, expected);
      },
    );

    test(
      "Given initial LogInUseCase, when blank password is sent, then ErrorRequestResponse with LoginError.emptyPassword is returned",
      () async {
        final useCase = LogInUseCaseImpl(authRepository: authRepository);
        final response = await useCase.logIn(
          const LoginInformation(
            email: "email",
            password: "",
          ),
        );
        const expected = ErrorRequestResponse<UserInfo, LoginError>(
            LoginError.emptyPassword);
        expect(response, expected);
      },
    );
  });
}
