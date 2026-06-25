import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:digital_garage/shared/widgets/status_chip.dart';
import 'package:flutter/material.dart';

import 'senior_mechanic_home_screen.dart';
import 'senior_vehicle_passport_screen.dart';

class SeniorVehiclesScreen extends StatefulWidget {
  const SeniorVehiclesScreen({super.key});

  @override
  State<SeniorVehiclesScreen> createState() => _SeniorVehiclesScreenState();
}

class _SeniorVehiclesScreenState extends State<SeniorVehiclesScreen> {
  String _selectedStatus = 'Все';

  static const _allVehicles = [
    VehicleData(
      brand: 'Hyundai H350',
      date: '25.06.2020',
      bortNum: '55',
      govNum: '435ED',
      id: '001',
      passport: 'AA00110011',
      status: 'Резерв',
    ),
    VehicleData(
      brand: 'Hyundai H350',
      date: '11.03.2019',
      bortNum: '33',
      govNum: '220KD',
      id: '002',
      passport: 'BB00220022',
      status: 'В смене',
    ),
    VehicleData(
      brand: 'ГАЗ Соболь 27527',
      date: '05.07.2021',
      bortNum: '41',
      govNum: '753QE',
      id: '003',
      passport: 'CC00330033',
      status: 'На ремонте/ТО',
    ),
    VehicleData(
      brand: 'Hyundai H350',
      date: '13.01.2020',
      bortNum: '60',
      govNum: '049ED',
      id: '004',
      passport: 'DD00440044',
      status: 'Резерв',
    ),
  ];

  List<VehicleData> get _filtered => _selectedStatus == 'Все'
      ? _allVehicles
      : _allVehicles.where((v) => v.status == _selectedStatus).toList();

  @override
  Widget build(BuildContext context) {
    final vehicles = _filtered;
    return RoleScaffold(
      userName: 'Руслан Омарович',
      roleName: 'Старший механик',
      bottomNavigationBar: RoleBottomNav(
        items: seniorMechanicNavItems,
        currentIndex: 2,
        onChanged: (i) => navigateSeniorTab(context, i),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 24),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Борты', style: AppTextStyles.cardTitle),
              FilledButton.icon(
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Добавить борт', style: TextStyle(fontSize: 13)),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ['Все', 'Резерв', 'В смене', 'На ремонте/ТО']
                  .map(
                    (status) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedStatus = status),
                        child: status == _selectedStatus
                            ? StatusChip(label: status)
                            : StatusChip(
                                label: status,
                                backgroundColor: AppColors.field,
                                foregroundColor: AppColors.muted,
                              ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 12),
          if (vehicles.isEmpty)
            const AppCard(
              child: Text(
                'Нет бортов по выбранному фильтру',
                style: AppTextStyles.caption,
              ),
            )
          else
            ...List.generate(vehicles.length, (index) {
              final vehicle = vehicles[index];
              return Padding(
                padding: EdgeInsets.only(bottom: index == vehicles.length - 1 ? 0 : 10),
                child: _VehicleCard(
                  vehicle: vehicle,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SeniorVehiclePassportScreen(vehicle: vehicle),
                    ),
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }
}

class _VehicleCard extends StatelessWidget {
  const _VehicleCard({required this.vehicle, required this.onTap});
  final VehicleData vehicle;
  final VoidCallback onTap;

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

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '${vehicle.brand} · ${vehicle.date}',
                  style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(width: 8),
              StatusChip(
                  label: vehicle.status,
                  backgroundColor: chipBg,
                  foregroundColor: chipFg),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Борт №${vehicle.bortNum} · Гос. номер: ${vehicle.govNum}',
            style: AppTextStyles.body,
          ),
          Text('ID: ${vehicle.id}', style: AppTextStyles.caption),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Номер тех. паспорта', style: AppTextStyles.caption),
                    Text(
                      vehicle.passport,
                      style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              TextButton.icon(
                onPressed: onTap,
                icon: const Icon(Icons.arrow_forward, size: 16),
                label: const Text('Перейти'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Публичная модель данных — используется в passport screen
class VehicleData {
  const VehicleData({
    required this.brand,
    required this.date,
    required this.bortNum,
    required this.govNum,
    required this.id,
    required this.passport,
    required this.status,
  });

  final String brand;
  final String date;
  final String bortNum;
  final String govNum;
  final String id;
  final String passport;
  final String status;
}
