import 'package:flutter/material.dart';

import 'splash_screen.dart';
import 'login_screen.dart';
import 'login_error_screen.dart';
import 'role_select_screen.dart';
import 'forgot_password_screen.dart';
import 'otp_screen.dart';
import 'new_password_screen.dart';
import 'success_screen.dart';

class AuthDevMenuScreen extends StatelessWidget {
  const AuthDevMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dev Menu: Auth Screens')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildButton(context, 'Splash Screen', const SplashScreen()),
          _buildButton(context, 'Login Screen', const LoginScreen()),
          _buildButton(context, 'Login Error Screen', const LoginErrorScreen()),
          _buildButton(context, 'Role Select Screen', const RoleSelectScreen()),
          _buildButton(context, 'Forgot Password Screen', const ForgotPasswordScreen()),
          _buildButton(context, 'OTP Screen', const OtpScreen()),
          _buildButton(context, 'New Password Screen', const NewPasswordScreen()),
          _buildButton(context, 'Success Screen', const SuccessScreen()),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String title, Widget screen) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => screen),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(title, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
