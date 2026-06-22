import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:flutter/material.dart';

import 'my_shift_screen.dart';
import 'waybill_screen.dart';
import 'my_data_screen.dart';

const driverNavItems = [
  RoleBottomNavItem(icon: Icons.home, label: 'Смена'),
  RoleBottomNavItem(icon: Icons.assignment_outlined, label: 'Путевой'),
  RoleBottomNavItem(icon: Icons.person, label: 'Данные'),
];

void navigateDriverTab(BuildContext context, int index) {
  Widget target;
  if (index == 0) {
    target = const MyShiftScreen();
  } else if (index == 1) {
    target = const WaybillScreen();
  } else {
    target = const MyDataScreen();
  }

  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation1, animation2) => target,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
  );
}

class DriverHomeScreen extends StatelessWidget {
  const DriverHomeScreen({super.key});

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
          const _ActiveShiftCard(),
          const SizedBox(height: 22),
          const _SectionHeader(title: 'Ближайшие задачи'),
          const SizedBox(height: 10),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Вызов', style: AppTextStyles.caption),
                SizedBox(height: 6),
                Text('Склад №2 → Точка доставки №14', style: AppTextStyles.cardTitle),
                SizedBox(height: 10),
                Text('Время: 10:30', style: AppTextStyles.caption),
                SizedBox(height: 4),
                Text('Адрес: Абая 18', style: AppTextStyles.caption),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const _SectionHeader(title: 'Документы'),
          const SizedBox(height: 10),
          AppCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Путевой лист', style: AppTextStyles.cardTitle),
                      SizedBox(height: 4),
                      Text('№063368', style: AppTextStyles.caption),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const WaybillScreen()),
                    );
                  },
                  child: const Text('Открыть'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActiveShiftCard extends StatelessWidget {
  const _ActiveShiftCard();

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
              Text('Моя смена', style: AppTextStyles.cardTitle),
              Text('Активна', style: TextStyle(color: AppColors.success, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Icon(Icons.schedule, size: 16, color: AppColors.muted),
              SizedBox(width: 6),
              Text('Сегодня · 09:00-18:00', style: AppTextStyles.caption),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Icon(Icons.local_shipping, size: 16, color: AppColors.muted),
              SizedBox(width: 6),
              Text('55 · Hyundai H 350', style: AppTextStyles.caption),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Icon(Icons.person, size: 16, color: AppColors.muted),
              SizedBox(width: 6),
              Text('Диспетчер: Айгуль С.', style: AppTextStyles.caption),
            ],
          ),
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
