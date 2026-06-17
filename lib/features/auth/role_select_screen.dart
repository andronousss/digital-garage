import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:flutter/material.dart';

class RoleSelectScreen extends StatelessWidget {
  const RoleSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.card,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Выберите профиль',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'У вашей учетной записи есть доступ к\nнескольким ролям.',
                style: AppTextStyles.body.copyWith(color: AppColors.muted),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  children: const [
                    _RoleCard(
                      title: 'Старший механик',
                      subtitle: 'Управление ТО и ремонтом',
                      icon: Icons.build_outlined,
                    ),
                    SizedBox(height: 12),
                    _RoleCard(
                      title: 'Механик',
                      subtitle: 'Обслуживание автопарка',
                      icon: Icons.settings_outlined,
                    ),
                    SizedBox(height: 12),
                    _RoleCard(
                      title: 'Диспетчер',
                      subtitle: 'Контроль вызовов и путевок',
                      icon: Icons.phone_in_talk_outlined,
                    ),
                    SizedBox(height: 12),
                    _RoleCard(
                      title: 'Завсклад',
                      subtitle: 'Запчасти и медикаменты',
                      icon: Icons.inventory_2_outlined,
                    ),
                    SizedBox(height: 12),
                    _RoleCard(
                      title: 'Водитель',
                      subtitle: 'Управление спецтранспортом',
                      icon: Icons.local_shipping_outlined,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24, top: 16),
                child: Center(
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Выйти из аккаунта',
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.muted,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      onTap: () {},
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primarySoft,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.cardTitle),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTextStyles.body.copyWith(color: AppColors.muted, fontSize: 13),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.line),
        ],
      ),
    );
  }
}
