import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:digital_garage/shared/widgets/status_chip.dart';
import 'package:flutter/material.dart';

import 'dispatcher_home_screen.dart';

class ShiftsScreen extends StatelessWidget {
  const ShiftsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      userName: 'Руслан Омаров',
      roleName: 'Диспетчер',
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
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      navigateDispatcherTab(context, 0);
                    }
                  },
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
                const Text('Операционные смены', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.text)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: const [
                _ShiftListItem(
                  shiftId: '#SH-4091',
                  time: '09:00-21:00',
                  driver: 'Алексей Морозов',
                  vehicle: '522AB',
                  status: 'Активна',
                  statusColor: Color(0xFF28A745),
                  statusBgColor: Color(0xFFE6F7ED),
                ),
                _ShiftListItem(
                  shiftId: '#SH-4090',
                  time: '08:00-20:00',
                  driver: 'Марат Султанов',
                  vehicle: '701TT',
                  status: 'Завершена',
                  statusColor: AppColors.primary,
                  statusBgColor: AppColors.primarySoft,
                ),
                _ShiftListItem(
                  shiftId: '#SH-4089',
                  time: '12:00-00:00',
                  driver: 'Дмитрий Ким',
                  vehicle: '303XX',
                  status: 'Ожидание',
                  statusColor: Color(0xFFF39C12),
                  statusBgColor: Color(0xFFFEF5E7),
                ),
                _ShiftListItem(
                  shiftId: '#SH-4088',
                  time: '06:00-18:00',
                  driver: 'Берик Ибраев',
                  vehicle: '144OO',
                  status: 'Завершена',
                  statusColor: AppColors.primary,
                  statusBgColor: AppColors.primarySoft,
                ),
                _ShiftListItem(
                  shiftId: '#SH-4087',
                  time: '09:00-21:00',
                  driver: 'Игорь Николаев',
                  vehicle: '909LL',
                  status: 'Активна',
                  statusColor: Color(0xFF28A745),
                  statusBgColor: Color(0xFFE6F7ED),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ShiftListItem extends StatelessWidget {
  const _ShiftListItem({
    required this.shiftId,
    required this.time,
    required this.driver,
    required this.vehicle,
    required this.status,
    required this.statusColor,
    required this.statusBgColor,
  });

  final String shiftId;
  final String time;
  final String driver;
  final String vehicle;
  final String status;
  final Color statusColor;
  final Color statusBgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.line)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(shiftId, style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.text)),
                  const SizedBox(width: 8),
                  Text('• $time', style: const TextStyle(color: AppColors.muted, fontSize: 12)),
                ],
              ),
              const SizedBox(height: 4),
              Text('$driver • $vehicle', style: AppTextStyles.caption.copyWith(color: AppColors.muted)),
            ],
          ),
          StatusChip(
            label: status,
            backgroundColor: statusBgColor,
            foregroundColor: statusColor,
          ),
        ],
      ),
    );
  }
}
