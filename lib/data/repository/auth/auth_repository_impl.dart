import 'package:authentication/authentication.dart';
import 'package:flap_app/data/repository/auth/auth_repository.dart';
import 'package:flutter/material.dart';

class AuthRepositoryImpl extends AuthRepository {
  final Authentication authentication;

  AuthRepositoryImpl({required this.authentication});

  @override
  bool isLoggedIn() {
   return authentication.isLoggedIn();
  }

  @override
  Widget startLogin(void Function(bool) completion) {
    return authentication.startLoginFlow(completion);
  } 
}
