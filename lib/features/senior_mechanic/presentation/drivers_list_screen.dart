import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:digital_garage/shared/widgets/status_chip.dart';
import 'package:flutter/material.dart';

import 'senior_mechanic_home_screen.dart';
import 'driver_card_screen.dart';

class DriversListScreen extends StatefulWidget {
  const DriversListScreen({super.key});

  @override
  State<DriversListScreen> createState() => _DriversListScreenState();
}

class _DriversListScreenState extends State<DriversListScreen> {
  final _searchController = TextEditingController();
  String _selectedStatus = 'Все';

  final _drivers = const [
    DriverSummary(
      iin: '123456789012',
      name: 'Руслан Омарович',
      phone: '+7 701 111 22 33',
      certificate: '№1100001234',
      rights: 'B, C · до 25.03.2030',
      medical: 'до 25.06.2026',
      status: 'Доступен',
      bort: '55',
    ),
    DriverSummary(
      iin: '987654321098',
      name: 'Алибек Дауренов',
      phone: '+7 702 222 33 44',
      certificate: '№2200002345',
      rights: 'B · до 14.07.2028',
      medical: 'до 10.01.2026',
      status: 'На выезде',
      bort: '33',
    ),
    DriverSummary(
      iin: '456789012345',
      name: 'Серик Жаксыбеков',
      phone: '+7 705 333 44 55',
      certificate: '№3300003456',
      rights: 'B, C, D · до 30.11.2029',
      medical: 'до 05.09.2027',
      status: 'Заявки',
      bort: '41',
    ),
  ];

  List<DriverSummary> get _filtered {
    var list = _drivers;
    if (_selectedStatus != 'Все') {
      list = list.where((d) => d.status == _selectedStatus).toList();
    }
    final q = _searchController.text.toLowerCase();
    if (q.isNotEmpty) {
      list = list
          .where((d) =>
              d.name.toLowerCase().contains(q) ||
              d.iin.contains(q) ||
              d.bort.contains(q))
          .toList();
    }
    return list;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      userName: 'Руслан Омарович',
      roleName: 'Старший механик',
      bottomNavigationBar: RoleBottomNav(
        items: seniorMechanicNavItems,
        currentIndex: 0,
        onChanged: (i) => navigateSeniorTab(context, i),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
            child: Column(
              children: [
                // Фильтры
                Row(
                  children: [
                    Expanded(
                      child: _FilterDropdown(
                        label: 'Борт',
                        value: 'Поиск',
                        onChanged: (_) {},
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _FilterDropdown(
                        label: 'Статус',
                        value: _selectedStatus,
                        onChanged: (v) =>
                            setState(() => _selectedStatus = v ?? 'Все'),
                        items: const [
                          'Все',
                          'Доступен',
                          'На выезде',
                          'Заявки'
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Поиск
                TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  decoration: const InputDecoration(
                    hintText: 'Поиск по имени или ИИН',
                    prefixIcon: Icon(Icons.search, size: 18),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 24),
              itemCount: _filtered.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                final d = _filtered[i];
                return _DriverCard(
                  driver: d,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => DriverCardScreen(driver: d)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DriverCard extends StatelessWidget {
  const _DriverCard({required this.driver, required this.onTap});
  final DriverSummary driver;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Color chipBg;
    Color chipFg;
    switch (driver.status) {
      case 'На выезде':
        chipBg = AppColors.successSoft;
        chipFg = AppColors.success;
        break;
      case 'Заявки':
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ИИН ${driver.iin}',
                      style: AppTextStyles.caption),
                  Text(driver.name,
                      style: AppTextStyles.body
                          .copyWith(fontWeight: FontWeight.w800)),
                ],
              ),
              StatusChip(
                  label: driver.status,
                  backgroundColor: chipBg,
                  foregroundColor: chipFg),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Телефон',
                        style: AppTextStyles.caption),
                    Text(driver.phone, style: AppTextStyles.body),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Удостоверение',
                        style: AppTextStyles.caption),
                    Text(driver.certificate,
                        style: AppTextStyles.body),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Права', style: AppTextStyles.caption),
                    Text(driver.rights, style: AppTextStyles.body),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Медсправка',
                        style: AppTextStyles.caption),
                    Text(driver.medical, style: AppTextStyles.body),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: onTap,
              icon: const Icon(Icons.arrow_forward, size: 16),
              label: const Text('Перейти'),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  const _FilterDropdown({
    required this.label,
    required this.value,
    required this.onChanged,
    this.items,
  });

  final String label;
  final String value;
  final ValueChanged<String?> onChanged;
  final List<String>? items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.field,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.line),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$label: $value', style: AppTextStyles.body),
          const Icon(Icons.arrow_drop_down, color: AppColors.muted),
        ],
      ),
    );
  }
}

class DriverSummary {
  const DriverSummary({
    required this.iin,
    required this.name,
    required this.phone,
    required this.certificate,
    required this.rights,
    required this.medical,
    required this.status,
    required this.bort,
  });

  final String iin;
  final String name;
  final String phone;
  final String certificate;
  final String rights;
  final String medical;
  final String status;
  final String bort;
}
