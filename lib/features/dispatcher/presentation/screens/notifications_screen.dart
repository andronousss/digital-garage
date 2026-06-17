import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:digital_garage/shared/widgets/status_chip.dart';
import 'package:flutter/material.dart';

import 'dispatcher_home_screen.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      userName: 'Руслан Омаров',
      roleName: 'Диспетчер',
      bottomNavigationBar: RoleBottomNav(
        items: dispatcherNavItems,
        currentIndex: 0,
        onChanged: (index) => navigateDispatcherTab(context, index),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.card,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.line),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            )
                          ],
                        ),
                        child: const Icon(Icons.reply, color: AppColors.primary, size: 20),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text('Уведомления', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.text)),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Прочитать все', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _NotificationCard(
                  title: 'Обработка на складе ➔ Готов к выдаче',
                  subtitle: 'Диспетчер: Руслан Омаров • 10 мин назад',
                  chipLabel: 'Статус ПЛ',
                  chipBgColor: const Color(0xFFE6F7ED),
                  chipFgColor: const Color(0xFF28A745),
                  icon: Icons.sync,
                  iconBgColor: AppColors.primarySoft,
                  iconColor: AppColors.primary,
                  timeLabel: 'Новое',
                  timeColor: AppColors.primary,
                ),
                const SizedBox(height: 12),
                _NotificationCard(
                  title: 'Критическая задержка борта',
                  subtitle: 'Газель NEXT (A777KE) отстает от графика более чем на 2 часа.',
                  chipLabel: 'Инцидент',
                  chipBgColor: Colors.red.shade50,
                  chipFgColor: Colors.red.shade700,
                  icon: Icons.warning_amber_rounded,
                  iconBgColor: Colors.red.shade50,
                  iconColor: Colors.red.shade700,
                  timeLabel: '1 ч назад',
                ),
                const SizedBox(height: 12),
                _NotificationCard(
                  title: 'Смена #SH-4090 успешно завершена',
                  subtitle: 'Водитель Марат Султанов сдал путевой лист без замечаний.',
                  chipLabel: 'Смена',
                  chipBgColor: AppColors.primarySoft,
                  chipFgColor: AppColors.primary,
                  icon: Icons.check_circle_outline,
                  iconBgColor: const Color(0xFFE6F7ED),
                  iconColor: const Color(0xFF28A745),
                  timeLabel: '3 ч назад',
                ),
                const SizedBox(height: 12),
                _NotificationCard(
                  title: 'Плановое ТО для Mercedes Sprinter',
                  subtitle: 'Транспорт переведен в зону сервисного обслуживания.',
                  chipLabel: 'Сервис',
                  chipBgColor: const Color(0xFFFEF5E7),
                  chipFgColor: const Color(0xFFF39C12),
                  icon: Icons.build_outlined,
                  iconBgColor: const Color(0xFFFEF5E7),
                  iconColor: const Color(0xFFF39C12),
                  timeLabel: 'Вчера',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({
    required this.title,
    required this.subtitle,
    required this.chipLabel,
    required this.chipBgColor,
    required this.chipFgColor,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.timeLabel,
    this.timeColor = AppColors.muted,
  });

  final String title;
  final String subtitle;
  final String chipLabel;
  final Color chipBgColor;
  final Color chipFgColor;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String timeLabel;
  final Color timeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primary.withOpacity(0.3), style: BorderStyle.solid), // Dashed border substitute
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StatusChip(
                      label: chipLabel,
                      backgroundColor: chipBgColor,
                      foregroundColor: chipFgColor,
                    ),
                    Text(timeLabel, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: timeColor)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: AppColors.text)),
                const SizedBox(height: 4),
                Text(subtitle, style: AppTextStyles.caption.copyWith(color: AppColors.muted)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
