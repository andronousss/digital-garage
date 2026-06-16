import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:digital_garage/shared/widgets/status_chip.dart';
import 'package:flutter/material.dart';

import 'warehouse_home_screen.dart';

class InventoryDetailScreen extends StatelessWidget {
  const InventoryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      userName: 'Перемещение шин / Логистика',
      roleName: '', // Assuming title overrides header completely
      bottomNavigationBar: RoleBottomNav(
        items: warehouseNavItems,
        currentIndex: 2, // inventory tab
        onChanged: (index) {
          if (index != 2) {
            navigateWarehouseTab(context, index);
          }
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
            _LogisticsCard(
              title: 'Michelin Agilis 215/65 R16C',
              subtitle: 'Транспортировка шин',
              subtitleIcon: Icons.swap_horiz,
              status: 'В пути',
              statusColor: const Color(0xFF9B51E0),
              statusBgColor: const Color(0xFFF3E5F5),
              from: 'Центральный Склад',
              to: 'Подстанция Скорой Помощи №2',
              dateStr: 'Вчера, 17:00',
              quantity: '4 шт',
              showButtons: true,
              primaryActionText: 'Подтвердить прием',
              primaryActionColor: const Color(0xFF9B51E0),
              secondaryActionText: 'Отменить',
            ),
            const SizedBox(height: 12),
            _LogisticsCard(
              title: 'Bridgestone Blizzak 225/70 R15C',
              subtitle: 'Логистический трансфер',
              subtitleIcon: Icons.check,
              subtitleIconColor: const Color(0xFF28A745),
              status: 'Доставлено',
              statusColor: const Color(0xFF28A745),
              statusBgColor: const Color(0xFFE6F7ED),
              from: 'Центральный Склад',
              to: 'Региональный Сектор Б',
              dateStr: '10 июня, 14:30',
              quantity: '6 шт',
              showButtons: false,
            ),
          ],
        ),
      ),
    );
  }
}

class _LogisticsCard extends StatelessWidget {
  const _LogisticsCard({
    required this.title,
    required this.subtitle,
    required this.subtitleIcon,
    this.subtitleIconColor = AppColors.muted,
    required this.status,
    required this.statusColor,
    required this.statusBgColor,
    required this.from,
    required this.to,
    required this.dateStr,
    required this.quantity,
    this.showButtons = false,
    this.primaryActionText,
    this.primaryActionColor,
    this.secondaryActionText,
  });

  final String title;
  final String subtitle;
  final IconData subtitleIcon;
  final Color subtitleIconColor;
  final String status;
  final Color statusColor;
  final Color statusBgColor;
  final String from;
  final String to;
  final String dateStr;
  final String quantity;
  final bool showButtons;
  final String? primaryActionText;
  final Color? primaryActionColor;
  final String? secondaryActionText;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: AppColors.text)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(subtitleIcon, size: 14, color: subtitleIconColor),
                        const SizedBox(width: 4),
                        Expanded(child: Text(subtitle, style: AppTextStyles.caption.copyWith(color: AppColors.muted))),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              StatusChip(label: status, backgroundColor: statusBgColor, foregroundColor: statusColor),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F6F9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Откуда:', style: AppTextStyles.caption.copyWith(color: AppColors.muted)),
                    Expanded(child: Text(from, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: AppColors.text), textAlign: TextAlign.right)),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Куда:', style: AppTextStyles.caption.copyWith(color: AppColors.muted)),
                    Expanded(child: Text(to, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: AppColors.text), textAlign: TextAlign.right)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          RichText(
            text: TextSpan(
              style: AppTextStyles.caption.copyWith(color: AppColors.muted),
              children: [
                TextSpan(text: 'Дата отправки: $dateStr • Кол-во: '),
                TextSpan(text: quantity, style: const TextStyle(color: AppColors.text, fontWeight: FontWeight.w800)),
              ],
            ),
          ),
          if (showButtons) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryActionColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      elevation: 0,
                    ),
                    child: Text(primaryActionText ?? '', style: const TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ),
                if (secondaryActionText != null) ...[
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.text,
                        side: const BorderSide(color: AppColors.line),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        backgroundColor: Colors.transparent,
                      ),
                      child: Text(secondaryActionText!, style: const TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}
