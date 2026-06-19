import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_button.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:flutter/material.dart';

import 'mechanic_home_screen.dart';
import 'mechanic_requests_screen.dart';

const mechanicNavItems = [
  RoleBottomNavItem(icon: Icons.home_outlined, label: 'Главная'),
  RoleBottomNavItem(icon: Icons.grid_view_outlined, label: 'График ТО'),
  RoleBottomNavItem(icon: Icons.assignment_outlined, label: 'Заявки'),
  RoleBottomNavItem(icon: Icons.person_outline, label: 'Профиль'),
];

void navigateMechanicTab(BuildContext context, int index) {
  Widget target = const MechanicHomeScreen();
  if (index == 1) {
    target = const MechanicScheduleScreen();
  } else if (index == 2) {
    target = const MechanicRequestsScreen();
  }

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => target),
  );
}

class MechanicScheduleScreen extends StatelessWidget {
  const MechanicScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      userName: 'Азамат Рахимов',
      roleName: 'Механик',
      bottomNavigationBar: RoleBottomNav(
        currentIndex: 1,
        items: mechanicNavItems,
        onChanged: (index) {
          navigateMechanicTab(context, index);
        },
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 24),
        children: [
          const _SectionHeader(title: 'Активные'),
          const SizedBox(height: 10),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('ТО · 25.03.26 - 31.03.26', style: AppTextStyles.cardTitle),
                SizedBox(height: 8),
                Text('13:00 - 16:00', style: AppTextStyles.caption),
                SizedBox(height: 12),
                Text('Борты: 30, 31, 33, 40, 41, 44, 50, 55, 57', style: AppTextStyles.caption),
                SizedBox(height: 8),
                Text('Категории: Шины, Капот, Свечи', style: AppTextStyles.caption),
                SizedBox(height: 12),
                Chip(
                  label: Text('60%'),
                  backgroundColor: AppColors.primarySoft,
                  labelStyle: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('ТО · 25.03.26 - 31.03.26', style: AppTextStyles.cardTitle),
                SizedBox(height: 8),
                Text('19:00 - 12:00', style: AppTextStyles.caption),
                SizedBox(height: 12),
                Text('Борты: 58, 60, 62, 64, 67, 68', style: AppTextStyles.caption),
                SizedBox(height: 8),
                Text('Категории: Шины', style: AppTextStyles.caption),
                SizedBox(height: 12),
                Chip(
                  label: Text('80%'),
                  backgroundColor: AppColors.successSoft,
                  labelStyle: TextStyle(color: AppColors.success, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const _SectionHeader(title: 'Черновики'),
          const SizedBox(height: 10),
          const AppButton(label: 'Создать новый График ТО'),
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
