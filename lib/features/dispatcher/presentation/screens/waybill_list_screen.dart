import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:flutter/material.dart';

import 'dispatcher_home_screen.dart';

class WaybillListScreen extends StatelessWidget {
  const WaybillListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      userName: 'Руслан Омаров',
      roleName: 'Диспетчер',
      bottomNavigationBar: RoleBottomNav(
        items: dispatcherNavItems,
        currentIndex: 1,
        onChanged: (index) {
          navigateDispatcherTab(context, index);
        },
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 24),
        children: [
          const _FilterSection(),
          const SizedBox(height: 16),
          const _WaybillItem(
            number: '063368',
            driver: 'Руслан Омарович',
            vehicle: '049ED',
            time: '9:00 - 21:00',
            status: 'Активный',
            statusColor: AppColors.successSoft,
          ),
          const SizedBox(height: 10),
          const _WaybillItem(
            number: '063367',
            driver: 'Марат Султанов',
            vehicle: '435ED',
            time: '9:00 - 21:00',
            status: 'Завершенный',
            statusColor: Color(0xFFF0F0F0),
          ),
          const SizedBox(height: 10),
          const _WaybillItem(
            number: '063366',
            driver: 'Алексей Морозов',
            vehicle: '322DI',
            time: '12:00 - 00:00',
            status: 'Не активный',
            statusColor: Color(0xFFF0F0F0),
          ),
        ],
      ),
    );
  }
}

class _FilterSection extends StatelessWidget {
  const _FilterSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Поиск...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
            ),
          ),
        ),
      ],
    );
  }
}

class _WaybillItem extends StatelessWidget {
  const _WaybillItem({
    required this.number,
    required this.driver,
    required this.vehicle,
    required this.time,
    required this.status,
    required this.statusColor,
  });

  final String number;
  final String driver;
  final String vehicle;
  final String time;
  final String status;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: statusColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Путевой лист №$number', style: AppTextStyles.cardTitle),
              Chip(
                label: Text(status, style: const TextStyle(fontSize: 11)),
                backgroundColor: Colors.transparent,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(driver, style: AppTextStyles.caption),
          const SizedBox(height: 4),
          Text('Борт: $vehicle', style: AppTextStyles.caption),
          const SizedBox(height: 4),
          Text('Время: $time', style: AppTextStyles.caption),
        ],
      ),
    );
  }
}
