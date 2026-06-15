import 'package:digital_garage/core/theme/app_theme.dart';
import 'package:digital_garage/features/mechanic/presentation/mechanic_home_screen.dart';
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
      home: const MechanicHomeScreen(),
    );
  }
}
