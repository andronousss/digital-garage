import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:digital_garage/shared/widgets/status_chip.dart';
import 'package:flutter/material.dart';

import 'senior_mechanic_home_screen.dart';
import 'senior_vehicles_screen.dart';

class SeniorVehiclePassportScreen extends StatelessWidget {
  const SeniorVehiclePassportScreen({
    super.key,
    required this.vehicle,
  });

  final VehicleData vehicle;

  @override
  Widget build(BuildContext context) {
    Color chipBg;
    Color chipFg;
    switch (vehicle.status) {
      case 'В смене':
        chipBg = AppColors.successSoft;
        chipFg = AppColors.success;
        break;
      case 'На ремонте/ТО':
        chipBg = AppColors.warningSoft;
        chipFg = AppColors.warning;
        break;
      default:
        chipBg = AppColors.primarySoft;
        chipFg = AppColors.primary;
    }

    return RoleScaffold(
      userName: 'Руслан Омарович',
      roleName: 'Старший механик',
      bottomNavigationBar: RoleBottomNav(
        items: seniorMechanicNavItems,
        currentIndex: 2,
        onChanged: (i) => navigateSeniorTab(context, i),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 32),
        children: [
          // Заголовок
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Борт №${vehicle.bortNum}',
                      style: AppTextStyles.cardTitle),
                  Text('Номер тех. паспорта: ${vehicle.passport}',
                      style: AppTextStyles.caption),
                ],
              ),
              TextButton.icon(
                icon: const Icon(Icons.edit_outlined, size: 16),
                label: const Text('Изменить'),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 10),
          StatusChip(
            label: vehicle.status,
            backgroundColor: chipBg,
            foregroundColor: chipFg,
          ),
          const SizedBox(height: 16),

          // Технические данные
          AppCard(
            child: Column(
              children: [
                _TechRow(label: 'Борт', value: vehicle.bortNum),
                _TechRow(
                    label: 'Номер тех. паспорта',
                    value: vehicle.passport),
                _TechRow(
                    label: 'VIN',
                    value: 'GF896XV2005349786000'),
                _TechRow(label: 'Год выпуска', value: '2016'),
                _TechRow(
                    label: 'Масса без нагрузки, kg',
                    value: '1600'),
                _TechRow(
                    label: 'Объем двигателя, см³',
                    value: '3456'),
                _TechRow(label: 'Гос номер', value: vehicle.govNum),
                _TechRow(
                    label: 'Марка, модель',
                    value: vehicle.brand),
                _TechRow(
                    label: 'Дата получения',
                    value: vehicle.date),
                _TechRow(
                    label: 'Максимальная масса, kg',
                    value: '2000'),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Нормы расхода
          AppCard(
            color: AppColors.successSoft,
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Нормы расхода',
                        style: AppTextStyles.body),
                    SizedBox(height: 4),
                    Text('Дизельное топливо',
                        style: AppTextStyles.caption),
                  ],
                ),
                Icon(Icons.arrow_forward_ios,
                    size: 16, color: AppColors.muted),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Список водителей
          AppCard(
            color: AppColors.primarySoft,
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Список водителей',
                        style: AppTextStyles.body),
                    SizedBox(height: 4),
                    Text('Водители, закреплённые за бортом',
                        style: AppTextStyles.caption),
                  ],
                ),
                Icon(Icons.arrow_forward_ios,
                    size: 16, color: AppColors.muted),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TechRow extends StatelessWidget {
  const _TechRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Text(label, style: AppTextStyles.caption)),
          Expanded(
            flex: 3,
            child: Text(value,
                style: AppTextStyles.body
                    .copyWith(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}
