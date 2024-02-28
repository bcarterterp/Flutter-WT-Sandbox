import 'package:authentication/login/presentation/viewmodel/event.dart';
import 'package:authentication/login/presentation/viewmodel/login_screen_state.dart';
import 'package:authentication/login/presentation/viewmodel/login_screen_viewmodel.dart';
import 'package:flutter/material.dart';

/// Generic log in screen with email and password fields.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, required this.viewModel});

  final LoginScreenViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        heightFactor: 1,
        widthFactor: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(
                height: 16,
              ),
              LoginInformationWidget(
                viewModel: viewModel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget that contains the email and password fields, and the submit button.
/// Broken out to reduce the amount of widgets that will be refreshed when there
/// is a state change.
class LoginInformationWidget extends StatefulWidget {
  const LoginInformationWidget({super.key, required this.viewModel});
  final LoginScreenViewModel viewModel;

  @override
  State<LoginInformationWidget> createState() {
    return _LoginInformationWigetState();
  }
}

class _LoginInformationWigetState extends State<LoginInformationWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() {
    final email = emailController.text;
    final password = passwordController.text;
    widget.viewModel.login(email, password);
  }

  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder<LoginScreenState>(
        valueListenable: widget.viewModel.state,
        builder: (context, LoginScreenState loginState, child) {
          // When state changes and the login event is successful, navigation code will execute below
          // WidgetsBinding.instance.addPostFrameCallback executes when widgets are finished rendering
          // Without the addPostFrameCallback, there will be an error that says you can't update state when widgets are being built
          if (loginState.loginEvent is SuccessEvent) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('JWT token saved.'),
                ),
              );
              // context.go('/home');
            });
          }

          ElevatedButton button = ElevatedButton(
            key: const ValueKey('loginButton'),
            onPressed: login,
            child: const Text("Login"), //Text(context.localization.login),
          );
          if (loginState.loginEvent is LoadingEvent) {
            button = const ElevatedButton(
              onPressed: null,
              child: SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            );
          }

          return Column(
            children: [
              TextField(
                key: const ValueKey('emailTextField'),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "email", //context.localization.email,
                  errorText: loginState.emailError,
                ),
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
              ),
              const SizedBox(
                height: 4,
              ),
              TextField(
                key: const ValueKey('passwordTextField'),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "password", //context.localization.password,
                  errorText: loginState.passwordError,
                ),
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                key: const ValueKey('jwtErrorText'),
                loginState.jwtError ?? '',
              ),
              const SizedBox(
                height: 10,
              ),
              button,
            ],
          );
        });
  }
}
