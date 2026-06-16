import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/features/auth/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, this.hasError = false});

  final bool hasError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 60),
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Цифровой гараж',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppColors.text,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Вход в систему',
                        style: AppTextStyles.body.copyWith(color: AppColors.muted),
                      ),
                      const SizedBox(height: 32),
                      AppCard(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            AuthTextField(
                              label: 'Логин',
                              hintText: 'Введите логин или ID',
                              initialValue: hasError ? 'dispatcher_01' : null,
                              hasError: hasError,
                              errorText: 'Неверный логин',
                            ),
                            const SizedBox(height: 16),
                            AuthTextField(
                              label: 'Пароль',
                              hintText: 'Введите пароль',
                              initialValue: hasError ? 'wrongpass' : null,
                              obscureText: true,
                              hasError: hasError,
                              errorText: 'Неверный пароль',
                              suffixIcon: const Icon(Icons.remove_red_eye_outlined, color: AppColors.muted),
                            ),
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Забыли пароль?',
                                  style: AppTextStyles.body.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: FilledButton(
                                onPressed: hasError ? null : () {},
                                style: FilledButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  disabledBackgroundColor: AppColors.muted.withOpacity(0.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('Войти', style: TextStyle(fontWeight: FontWeight.w600)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Связаться с администратором',
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.muted,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.success,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Соединение с сервером установлено',
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Версия 1.0.3 (build 842)',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.muted.withOpacity(0.6),
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
