import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:flutter/material.dart';

import 'dispatcher_home_screen.dart';

class VehicleDetailsScreen extends StatelessWidget {
  const VehicleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      userName: 'Руслан Омаров',
      roleName: 'Диспетчер',
      bottomNavigationBar: RoleBottomNav(
        items: dispatcherNavItems,
        currentIndex: 2,
        onChanged: (index) {
          navigateDispatcherTab(context, index);
        },
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 24),
        children: [
          const _VehicleHeaderCard(),
          const SizedBox(height: 22),
          const _SectionHeader(title: 'Технические данные'),
          const SizedBox(height: 10),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _DataRow('Бортовой номер', '753'),
                SizedBox(height: 12),
                _DataRow('Гос. номер', '049ED'),
                SizedBox(height: 12),
                _DataRow('VIN код', 'XTA2115008912'),
                SizedBox(height: 12),
                _DataRow('Марка/Модель', 'Hyundai H350'),
                SizedBox(height: 12),
                _DataRow('Год выпуска', '2022'),
                SizedBox(height: 12),
                _DataRow('Пробег', '142 400 км'),
                SizedBox(height: 12),
                _DataRow('Последнее ТО', '12.04.2026'),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const _SectionHeader(title: 'Текущий статус'),
          const SizedBox(height: 10),
          AppCard(
            color: AppColors.primarySoft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('На линии', style: AppTextStyles.cardTitle),
                SizedBox(height: 8),
                Text('Текущий водитель: Руслан Омарович', style: AppTextStyles.caption),
                SizedBox(height: 8),
                Text('Маршрут №12А', style: AppTextStyles.caption),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const _SectionHeader(title: 'История статусов'),
          const SizedBox(height: 10),
          const _StatusHistoryItem(
            title: 'Выход на линию',
            time: 'Сегодня, 09:12',
            details: 'Маршрут №12А, водитель Р. Омарович',
          ),
          const SizedBox(height: 10),
          const _StatusHistoryItem(
            title: 'На техническое обслуживание',
            time: 'Вчера, 18:30',
            details: 'Завершено',
          ),
        ],
      ),
    );
  }
}

class _VehicleHeaderCard extends StatelessWidget {
  const _VehicleHeaderCard();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: AppColors.primarySoft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Hyundai H350', style: AppTextStyles.cardTitle),
          SizedBox(height: 4),
          Text('Борт №753', style: AppTextStyles.caption),
          SizedBox(height: 4),
          Text('Гос. номер: 049ED', style: AppTextStyles.caption),
        ],
      ),
    );
  }
}

class _DataRow extends StatelessWidget {
  const _DataRow(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.caption),
        Text(value, style: AppTextStyles.cardTitle),
      ],
    );
  }
}

class _StatusHistoryItem extends StatelessWidget {
  const _StatusHistoryItem({
    required this.title,
    required this.time,
    required this.details,
  });

  final String title;
  final String time;
  final String details;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.cardTitle),
          const SizedBox(height: 4),
          Text(time, style: AppTextStyles.caption),
          const SizedBox(height: 8),
          Text(details, style: AppTextStyles.caption),
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
