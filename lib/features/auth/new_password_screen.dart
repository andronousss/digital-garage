import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/features/auth/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.card,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.line),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.arrow_back, color: AppColors.text, size: 20),
          ),
          onPressed: () {},
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                'Новый пароль',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Придумайте надежный пароль для вашей\nучетной записи.',
                style: AppTextStyles.body.copyWith(color: AppColors.muted),
              ),
              const SizedBox(height: 24),
              AppCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AuthTextField(
                      label: 'Новый пароль',
                      initialValue: 'Fleet2026!',
                      obscureText: false,
                      suffixIcon: Icon(Icons.remove_red_eye_outlined, color: AppColors.muted),
                    ),
                    const SizedBox(height: 16),
                    const _ValidationItem(text: 'Минимум 8 символов', isValid: true),
                    const SizedBox(height: 8),
                    const _ValidationItem(text: 'Содержит цифру', isValid: true),
                    const SizedBox(height: 8),
                    const _ValidationItem(text: 'Содержит спецсимвол', isValid: true),
                    const SizedBox(height: 24),
                    const AuthTextField(
                      label: 'Повторите пароль',
                      initialValue: '........',
                      obscureText: true,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: FilledButton(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Сохранить', style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ValidationItem extends StatelessWidget {
  const _ValidationItem({required this.text, required this.isValid});
  final String text;
  final bool isValid;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check : Icons.close,
          color: isValid ? AppColors.success : AppColors.muted,
          size: 16,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: AppTextStyles.body.copyWith(
            color: isValid ? AppColors.success : AppColors.muted,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
