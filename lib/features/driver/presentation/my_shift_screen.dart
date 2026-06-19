import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_button.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:flutter/material.dart';

import 'driver_home_screen.dart';

class MyShiftScreen extends StatelessWidget {
  const MyShiftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      userName: 'Руслан Омарович',
      roleName: 'Водитель',
      bottomNavigationBar: RoleBottomNav(
        items: driverNavItems,
        currentIndex: 0,
        onChanged: (index) {
          navigateDriverTab(context, index);
        },
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 24),
        children: [
          const _ShiftHeaderCard(),
          const SizedBox(height: 22),
          const _SectionHeader(title: 'Информация о смене'),
          const SizedBox(height: 10),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Борт', style: AppTextStyles.caption),
                    Text('55 · Hyundai H 350', style: AppTextStyles.cardTitle),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Диспетчер', style: AppTextStyles.caption),
                    Text('Айгуль С.', style: AppTextStyles.cardTitle),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Время работы', style: AppTextStyles.caption),
                    Text('09:00 - 18:00', style: AppTextStyles.cardTitle),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const _SectionHeader(title: 'Активные вызовы'),
          const SizedBox(height: 10),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Вызов 1', style: AppTextStyles.cardTitle),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 14, color: AppColors.muted),
                    SizedBox(width: 6),
                    Expanded(child: Text('Склад №2 → Точка доставки №14', style: AppTextStyles.caption)),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.schedule, size: 14, color: AppColors.muted),
                    SizedBox(width: 6),
                    Text('10:30', style: AppTextStyles.caption),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, size: 14, color: AppColors.muted),
                    SizedBox(width: 6),
                    Text('Абая 18', style: AppTextStyles.caption),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const AppButton(label: 'Завершить смену'),
        ],
      ),
    );
  }
}

class _ShiftHeaderCard extends StatelessWidget {
  const _ShiftHeaderCard();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: AppColors.primarySoft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Смена №6543', style: AppTextStyles.cardTitle),
              Chip(
                label: Text('Активна'),
                backgroundColor: AppColors.successSoft,
                labelStyle: TextStyle(color: AppColors.success, fontWeight: FontWeight.w600, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text('Сегодня · 09:00-18:00', style: AppTextStyles.caption),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: AppTextStyles.cardTitle);
  }
}
