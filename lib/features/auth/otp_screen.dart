import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

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
                'Введите код',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Код отправлен на номер\n+7 701 *** 45 67',
                style: AppTextStyles.body.copyWith(color: AppColors.muted),
              ),
              const SizedBox(height: 32),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _OtpBox(value: '4', filled: true),
                  _OtpBox(value: '8', filled: true),
                  _OtpBox(value: '2', filled: true),
                  _OtpBox(value: '', focused: true),
                  _OtpBox(value: ''),
                  _OtpBox(value: ''),
                ],
              ),
              const SizedBox(height: 40),
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
                  child: const Text('Подтвердить', style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: RichText(
                  text: TextSpan(
                    style: AppTextStyles.body.copyWith(color: AppColors.muted),
                    children: [
                      const TextSpan(text: 'Отправить код повторно через '),
                      TextSpan(
                        text: '01:59',
                        style: AppTextStyles.body.copyWith(color: AppColors.primary),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OtpBox extends StatelessWidget {
  const _OtpBox({required this.value, this.filled = false, this.focused = false});
  final String value;
  final bool filled;
  final bool focused;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 56,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: focused ? AppColors.primary : AppColors.line,
          width: focused ? 1.5 : 1.0,
        ),
      ),
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColors.text,
        ),
      ),
    );
  }
}
