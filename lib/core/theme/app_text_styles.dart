import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  const AppTextStyles._();

  static const screenTitle = TextStyle(
    fontSize: 20,
    height: 1.18,
    fontWeight: FontWeight.w800,
    color: AppColors.text,
  );

  static const cardTitle = TextStyle(
    fontSize: 17,
    height: 1.2,
    fontWeight: FontWeight.w800,
    color: AppColors.text,
  );

  static const body = TextStyle(
    fontSize: 14,
    height: 1.35,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
  );

  static const caption = TextStyle(
    fontSize: 12,
    height: 1.25,
    fontWeight: FontWeight.w600,
    color: AppColors.muted,
  );
}
