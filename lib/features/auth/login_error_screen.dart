import 'package:digital_garage/features/auth/login_screen.dart';
import 'package:flutter/material.dart';

class LoginErrorScreen extends StatelessWidget {
  const LoginErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginScreen(hasError: true);
  }
}
