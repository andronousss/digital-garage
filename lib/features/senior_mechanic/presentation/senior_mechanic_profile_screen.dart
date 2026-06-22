import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:flutter/material.dart';

import 'senior_mechanic_home_screen.dart';

class SeniorMechanicProfileScreen extends StatelessWidget {
  const SeniorMechanicProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      userName: 'Руслан Омарович',
      roleName: 'Старший механик',
      bottomNavigationBar: RoleBottomNav(
        items: seniorMechanicNavItems,
        currentIndex: 3,
        onChanged: (i) => navigateSeniorTab(context, i),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 32),
        children: [
          // Аватар + имя
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.primarySoft,
                  child: const Text(
                    'РО',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text('Руслан Омарович',
                    style: AppTextStyles.cardTitle),
                const SizedBox(height: 4),
                const Text('Старший механик',
                    style: AppTextStyles.caption),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Данные профиля
          AppCard(
            child: Column(
              children: const [
                _ProfileRow(
                    icon: Icons.badge_outlined,
                    label: 'ИИН',
                    value: '800628567907'),
                Divider(color: AppColors.line, height: 20),
                _ProfileRow(
                    icon: Icons.phone_outlined,
                    label: 'Телефон',
                    value: '+7 (707) 999 00 77'),
                Divider(color: AppColors.line, height: 20),
                _ProfileRow(
                    icon: Icons.email_outlined,
                    label: 'Email',
                    value: 'ruslan@garage.kz'),
                Divider(color: AppColors.line, height: 20),
                _ProfileRow(
                    icon: Icons.business_outlined,
                    label: 'Автопарк',
                    value: 'Автопарк №1'),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Действия
          AppCard(
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.lock_outline,
                      color: AppColors.muted),
                  title: const Text('Изменить пароль',
                      style: AppTextStyles.body),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      size: 14, color: AppColors.muted),
                  onTap: () {},
                ),
                const Divider(color: AppColors.line, height: 1),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.notifications_outlined,
                      color: AppColors.muted),
                  title: const Text('Уведомления',
                      style: AppTextStyles.body),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      size: 14, color: AppColors.muted),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Выйти
          OutlinedButton.icon(
            icon: const Icon(Icons.logout, size: 16),
            label: const Text('Выйти'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              side: const BorderSide(color: AppColors.danger),
              foregroundColor: AppColors.danger,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _ProfileRow extends StatelessWidget {
  const _ProfileRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.muted),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.caption),
              const SizedBox(height: 2),
              Text(value,
                  style: AppTextStyles.body
                      .copyWith(fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ],
    );
  }
}
