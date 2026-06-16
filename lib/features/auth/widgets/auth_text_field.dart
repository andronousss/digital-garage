import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.label,
    this.hintText,
    this.obscureText = false,
    this.hasError = false,
    this.errorText,
    this.suffixIcon,
    this.initialValue,
  });

  final String label;
  final String? hintText;
  final bool obscureText;
  final bool hasError;
  final String? errorText;
  final Widget? suffixIcon;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.body.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue,
          obscureText: obscureText,
          style: AppTextStyles.body,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyles.body.copyWith(color: AppColors.muted),
            filled: true,
            fillColor: hasError ? AppColors.dangerSoft : AppColors.card,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: hasError ? AppColors.danger : AppColors.line),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: hasError ? AppColors.danger : AppColors.primary),
            ),
            suffixIcon: suffixIcon,
          ),
        ),
        if (hasError && errorText != null) ...[
          const SizedBox(height: 4),
          Text(
            errorText!,
            style: AppTextStyles.caption.copyWith(color: AppColors.danger),
          ),
        ],
      ],
    );
  }
}
