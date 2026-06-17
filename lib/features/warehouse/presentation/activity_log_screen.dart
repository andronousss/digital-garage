import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:digital_garage/shared/widgets/status_chip.dart';
import 'package:flutter/material.dart';

import 'warehouse_home_screen.dart';

class ActivityLogScreen extends StatelessWidget {
  const ActivityLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      userName: 'Системный журнал / История',
      roleName: '', // title overrides
      bottomNavigationBar: RoleBottomNav(
        items: warehouseNavItems,
        currentIndex: 0, // Highlight Home or keep unselected. Let's say 0.
        onChanged: (index) {
          navigateWarehouseTab(context, index);
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4, offset: const Offset(0, 2)),
                  ],
                ),
                child: const Icon(Icons.reply, color: AppColors.primary, size: 20),
              ),
            ),
            const SizedBox(height: 16),
            _LogCard(
              chipLabel: 'SYSTEM LOG',
              chipBgColor: const Color(0xFFE6F7ED),
              chipFgColor: const Color(0xFF28A745),
              timeLabel: 'Сейчас',
              timeColor: AppColors.primary,
              title: 'На рассмотрении ➔ Готов к выдаче',
              subtitle: 'Заявка #REQ-9064 изменена пользователем:\nРуслан Омаров',
              icon: Icons.layers_outlined,
              iconBgColor: AppColors.primarySoft,
              iconColor: AppColors.primary,
            ),
            const SizedBox(height: 12),
            _LogCard(
              chipLabel: 'СПИСАНИЕ',
              chipBgColor: AppColors.primarySoft,
              chipFgColor: AppColors.primary,
              timeLabel: '40 мин назад',
              title: 'Успешная выдача со склада',
              subtitle: 'Товар \'Масло моторное Shell\' списан в\nколичестве 4 литра для борта №441.',
              icon: Icons.inventory_2_outlined,
              iconBgColor: const Color(0xFFE6F7ED),
              iconColor: const Color(0xFF28A745),
            ),
            const SizedBox(height: 12),
            _LogCard(
              chipLabel: 'ЛОГИСТИКА',
              chipBgColor: const Color(0xFFFEF5E7),
              chipFgColor: const Color(0xFFF39C12),
              timeLabel: '3 ч назад',
              title: 'Создана накладная перемещения\nшин',
              subtitle: 'Запущена отправка 4 единиц Michelin Agilis на\nПодстанцию №2.',
              icon: Icons.sync,
              iconBgColor: const Color(0xFFFEF5E7),
              iconColor: const Color(0xFFF39C12),
            ),
          ],
        ),
      ),
    );
  }
}

class _LogCard extends StatelessWidget {
  const _LogCard({
    required this.chipLabel,
    required this.chipBgColor,
    required this.chipFgColor,
    required this.timeLabel,
    this.timeColor = AppColors.muted,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
  });

  final String chipLabel;
  final Color chipBgColor;
  final Color chipFgColor;
  final String timeLabel;
  final Color timeColor;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(16),
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
                const SizedBox(height: 12),
                Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: AppColors.text, height: 1.3)),
                const SizedBox(height: 6),
                Text(subtitle, style: AppTextStyles.caption.copyWith(color: AppColors.muted, height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
