import 'package:digital_garage/core/theme/app_theme.dart';
import 'package:digital_garage/features/auth/auth_dev_menu_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DigitalGarageApp());
}

class DigitalGarageApp extends StatelessWidget {
  const DigitalGarageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Цифровой гараж',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const AuthDevMenuScreen(),
    );
  }
}
