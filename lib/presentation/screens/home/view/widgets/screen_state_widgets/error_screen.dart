import 'package:flutter/material.dart';

class ErrorScreenWidget extends StatelessWidget {
  const ErrorScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child:
            Text('Oh no, something went wrong! Please refresh and try again.'));
  }
}
