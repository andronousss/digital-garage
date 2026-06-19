import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_button.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:flutter/material.dart';

import 'mechanic_schedule_screen.dart';

class VehiclePassportScreen extends StatelessWidget {
  const VehiclePassportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      userName: 'Азамат Рахимов',
      roleName: 'Механик',
      bottomNavigationBar: RoleBottomNav(
        currentIndex: 0,
        items: mechanicNavItems,
        onChanged: (index) {
          navigateMechanicTab(context, index);
        },
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 24),
        children: [
          const _SectionHeader(title: 'Паспорт борта'),
          const SizedBox(height: 10),
          AppCard(
            color: AppColors.primarySoft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Борт №55', style: AppTextStyles.cardTitle),
                SizedBox(height: 4),
                Text('Hyundai H 350 · 25.06.2020', style: AppTextStyles.caption),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const _SectionHeader(title: 'Технические данные'),
          const SizedBox(height: 10),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _DataRow('Номер техпаспорта', 'AA00110011'),
                SizedBox(height: 12),
                _DataRow('Гос. номер', '435ED'),
                SizedBox(height: 12),
                _DataRow('ID', '001'),
                SizedBox(height: 12),
                _DataRow('VIN', 'GF896XV2005349'),
                SizedBox(height: 12),
                _DataRow('Марка/модель', 'Hyundai H 350'),
                SizedBox(height: 12),
                _DataRow('Год выпуска', '2020'),
                SizedBox(height: 12),
                _DataRow('Пробег', '142 400 км'),
                SizedBox(height: 12),
                _DataRow('Объем двигателя', '3456 см³'),
                SizedBox(height: 12),
                _DataRow('Масса без нагрузки', '1600 кг'),
                SizedBox(height: 12),
                _DataRow('Максимальная масса', '2000 кг'),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const _SectionHeader(title: 'Информация о владельце'),
          const SizedBox(height: 10),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _DataRow('Дата получения', '25.06.2020'),
                SizedBox(height: 12),
                _DataRow('Последнее ТО', '12.04.2026'),
                SizedBox(height: 12),
                _DataRow('Статус', 'Активен'),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const AppButton(label: 'Изменить'),
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

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: AppTextStyles.cardTitle);
  }
}
