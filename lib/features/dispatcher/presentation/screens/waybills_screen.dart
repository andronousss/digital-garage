import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:digital_garage/shared/widgets/status_chip.dart';
import 'package:flutter/material.dart';

import 'dispatcher_home_screen.dart';
import 'notifications_screen.dart';

class WaybillsScreen extends StatelessWidget {
  const WaybillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      userName: 'Руслан Омаров',
      roleName: 'Диспетчер',
      onNotificationTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const NotificationsScreen()),
        );
      },
      bottomNavigationBar: RoleBottomNav(
        items: dispatcherNavItems,
        currentIndex: 1,
        onChanged: (index) {
          if (index != 1) {
            navigateDispatcherTab(context, index);
          }
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.line),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Поиск',
                        hintStyle: TextStyle(color: AppColors.muted),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Icon(Icons.search, color: AppColors.muted),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const _FilterChip(
                  label: 'Все',
                  isSelected: true,
                ),
                const SizedBox(width: 8),
                const _FilterChip(
                  label: 'Создано',
                  textColor: AppColors.warning,
                  borderColor: AppColors.warningSoft,
                ),
                const SizedBox(width: 8),
                const _FilterChip(
                  label: 'Не активный',
                  textColor: AppColors.danger,
                  borderColor: AppColors.dangerSoft,
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'Закрытый',
                  textColor: AppColors.text,
                  borderColor: AppColors.line,
                  backgroundColor: AppColors.field.withOpacity(0.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const _WaybillListItem(
                  id: '063368',
                  driver: 'Руслан Омарович',
                  vehicle: '049ED',
                  time: '9:00 - 21:00',
                  status: 'Не активный',
                  statusColor: AppColors.danger,
                  statusBgColor: AppColors.dangerSoft,
                ),
                const SizedBox(height: 12),
                const _WaybillListItem(
                  id: '063368',
                  driver: 'Руслан Омарович',
                  vehicle: '049ED',
                  time: '9:00 - 21:00',
                  status: 'Активный',
                  statusColor: AppColors.success,
                  statusBgColor: AppColors.successSoft,
                ),
                const SizedBox(height: 12),
                const _WaybillListItem(
                  id: '063368',
                  driver: 'Руслан Омарович',
                  vehicle: '049ED',
                  time: '9:00 - 21:00',
                  status: 'Не активный',
                  statusColor: AppColors.danger,
                  statusBgColor: AppColors.dangerSoft,
                ),
                const SizedBox(height: 12),
                const _WaybillListItem(
                  id: '063368',
                  driver: 'Руслан Омарович',
                  vehicle: '049ED',
                  time: '9:00 - 21:00',
                  status: 'Не активный',
                  statusColor: AppColors.danger,
                  statusBgColor: AppColors.dangerSoft,
                ),
                const SizedBox(height: 12),
                _WaybillListItem(
                  id: '063368',
                  driver: 'Руслан Омарович',
                  vehicle: '049ED',
                  time: '9:00 - 21:00',
                  status: 'Закрытый',
                  statusColor: AppColors.text.withOpacity(0.8),
                  statusBgColor: AppColors.line,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    this.isSelected = false,
    this.textColor,
    this.borderColor,
    this.backgroundColor,
  });

  final String label;
  final bool isSelected;
  final Color? textColor;
  final Color? borderColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.field : (backgroundColor ?? Colors.transparent),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? AppColors.text.withOpacity(0.5) : (borderColor ?? AppColors.line),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? AppColors.text : (textColor ?? AppColors.text),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _WaybillListItem extends StatelessWidget {
  const _WaybillListItem({
    required this.id,
    required this.driver,
    required this.vehicle,
    required this.time,
    required this.status,
    required this.statusColor,
    required this.statusBgColor,
  });

  final String id;
  final String driver;
  final String vehicle;
  final String time;
  final String status;
  final Color statusColor;
  final Color statusBgColor;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.field,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  id,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ),
              ),
              StatusChip(
                label: status,
                backgroundColor: statusBgColor,
                foregroundColor: statusColor,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                driver,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: AppColors.text,
                ),
              ),
              const Icon(Icons.arrow_forward, color: AppColors.muted, size: 20),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.local_shipping_outlined, color: AppColors.primary, size: 18),
              const SizedBox(width: 4),
              Text(
                vehicle,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(width: 24),
              const Icon(Icons.schedule, color: AppColors.muted, size: 18),
              const SizedBox(width: 4),
              Text(
                time,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.text,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
