import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_button.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:digital_garage/shared/widgets/status_chip.dart';
import 'package:flutter/material.dart';

import 'mechanic_schedule_screen.dart';

class MechanicRequestsScreen extends StatelessWidget {
  const MechanicRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      userName: 'Азамат Рахимов',
      roleName: 'Механик',
      bottomNavigationBar: RoleBottomNav(
        currentIndex: 2,
        items: mechanicNavItems,
        onChanged: (index) {
          navigateMechanicTab(context, index);
        },
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 24),
        children: [
          const _SectionHeader(title: 'Мои заявки'),
          const SizedBox(height: 10),
          const _RequestCard(
            number: '007',
            status: 'Готова к выдаче',
            statusColor: AppColors.successSoft,
            detail: 'Колесо A',
            quantity: '1 шт',
            statusChipLabel: 'Склад',
          ),
          const SizedBox(height: 12),
          const _RequestCard(
            number: '006',
            status: 'Ожидает ст. механика',
            statusColor: AppColors.primarySoft,
            detail: 'Защита днища',
            quantity: '1 компл',
            statusChipLabel: 'На обработке',
          ),
          const SizedBox(height: 12),
          const _RequestCard(
            number: '005',
            status: 'Ожидание детали',
            statusColor: Color(0xFFFFF3E0),
            detail: 'Ремень ГРМ',
            quantity: '1 компл',
            statusChipLabel: 'Ожидание',
          ),
          const SizedBox(height: 22),
          const AppButton(label: 'Подать новую заявку'),
        ],
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  const _RequestCard({
    required this.number,
    required this.status,
    required this.statusColor,
    required this.detail,
    required this.quantity,
    required this.statusChipLabel,
  });

  final String number;
  final String status;
  final Color statusColor;
  final String detail;
  final String quantity;
  final String statusChipLabel;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: statusColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Заявка №$number', style: AppTextStyles.cardTitle),
                const SizedBox(height: 4),
                Text(status, style: AppTextStyles.caption),
                const SizedBox(height: 8),
                Text(detail, style: AppTextStyles.cardTitle),
                const SizedBox(height: 4),
                Text(quantity, style: AppTextStyles.caption),
              ],
            ),
          ),
          const SizedBox(width: 8),
          StatusChip(label: statusChipLabel),
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
