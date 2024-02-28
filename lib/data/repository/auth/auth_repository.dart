import 'package:flutter/material.dart';

abstract class AuthRepository {
  Widget startLogin(void Function(bool) completion);
  bool isLoggedIn();
}
