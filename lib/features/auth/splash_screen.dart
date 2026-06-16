import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.card,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Цифровой гараж',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Система управления автопарком',
                    style: AppTextStyles.body.copyWith(color: AppColors.muted),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Column(
                children: [
                  const SizedBox(
                    width: 32,
                    height: 32,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Загрузка модулей системы...',
                    style: AppTextStyles.caption,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'v1.0.3',
                    style: AppTextStyles.caption.copyWith(color: AppColors.muted.withOpacity(0.5)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
