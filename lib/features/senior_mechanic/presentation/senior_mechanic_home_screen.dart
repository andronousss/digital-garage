import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:digital_garage/shared/widgets/status_chip.dart';
import 'package:flutter/material.dart';

import 'senior_schedule_screen.dart';
import 'senior_vehicles_screen.dart';
import 'senior_mechanic_profile_screen.dart';
import 'senior_requests_screen.dart';
import 'critical_faults_screen.dart';

const seniorMechanicNavItems = [
  RoleBottomNavItem(icon: Icons.home_outlined, label: 'Главная'),
  RoleBottomNavItem(icon: Icons.grid_view_outlined, label: 'График ТО'),
  RoleBottomNavItem(icon: Icons.local_shipping_outlined, label: 'Борты'),
  RoleBottomNavItem(icon: Icons.person_outline, label: 'Профиль'),
];

void navigateSeniorTab(BuildContext context, int index) {
  Widget target;
  switch (index) {
    case 1:
      target = const SeniorScheduleScreen();
      break;
    case 2:
      target = const SeniorVehiclesScreen();
      break;
    case 3:
      target = const SeniorMechanicProfileScreen();
      break;
    default:
      target = const SeniorMechanicHomeScreen();
  }
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => target),
  );
}

class SeniorMechanicHomeScreen extends StatelessWidget {
  const SeniorMechanicHomeScreen({super.key});

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
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 24),
        children: [
          // Счётчики ДТП и Водители
          Row(
            children: [
              Expanded(
                child: AppCard(
                  color: AppColors.dangerSoft,
                  onTap: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('ДТП', style: AppTextStyles.caption),
                      SizedBox(height: 4),
                      Text('1 на рассмотрении',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: AppColors.danger,
                          )),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: AppCard(
                  color: AppColors.warningSoft,
                  onTap: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Водители', style: AppTextStyles.caption),
                      SizedBox(height: 4),
                      Text('Документы истекают у 0 водителей',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.warning,
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Ближайшие задачи
          const _SectionHeader(title: 'Ближайшие задачи'),
          const SizedBox(height: 10),
          AppCard(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const SeniorRequestsScreen())),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Заявка · Борт 55', style: AppTextStyles.caption),
                      SizedBox(height: 4),
                      Text('Колесо А · требуется согласование',
                          style: AppTextStyles.body),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                StatusChip(
                  label: 'Новая',
                  backgroundColor: AppColors.primarySoft,
                  foregroundColor: AppColors.primary,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          AppCard(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const CriticalFaultsScreen())),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Критическая неисправность',
                          style: AppTextStyles.caption),
                      SizedBox(height: 4),
                      Text('Передняя правая стойка · разбита',
                          style: AppTextStyles.body),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                StatusChip(
                  label: '!',
                  backgroundColor: AppColors.dangerSoft,
                  foregroundColor: AppColors.danger,
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),

          // Быстрые действия
          _QuickActionGrid(context: context),
          const SizedBox(height: 22),

          // Сегодня
          const _SectionHeader(title: 'Сегодня'),
          const SizedBox(height: 10),
          AppCard(
            color: AppColors.primarySoft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('График ТО · 13:00–16:00', style: AppTextStyles.caption),
                SizedBox(height: 4),
                Text('Борты: 30, 31, 33, 40, 41, 44, 50, 55, 57',
                    style: AppTextStyles.body),
                SizedBox(height: 4),
                Text('Категории: Шины, Капот, Свечи',
                    style: AppTextStyles.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionGrid extends StatelessWidget {
  const _QuickActionGrid({required this.context});
  final BuildContext context;

  @override
  Widget build(BuildContext _) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _QuickCard(
                title: 'Новые заявки',
                subtitle: 'Проверить и согласовать',
                color: AppColors.primarySoft,
                iconColor: AppColors.primary,
                icon: Icons.assignment_outlined,
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const SeniorRequestsScreen())),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _QuickCard(
                title: 'Критические неисправности',
                subtitle: '2 неисправности',
                color: AppColors.dangerSoft,
                iconColor: AppColors.danger,
                icon: Icons.warning_amber_outlined,
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const CriticalFaultsScreen())),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _QuickCard(
                title: 'Таблица норм',
                subtitle: 'Нормы расхода топлива',
                color: AppColors.successSoft,
                iconColor: AppColors.success,
                icon: Icons.table_chart_outlined,
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const FuelNormsScreen())),
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ],
    );
  }
}

class _QuickCard extends StatelessWidget {
  const _QuickCard({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.iconColor,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final Color color;
  final Color iconColor;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: color,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: iconColor),
          const SizedBox(height: 8),
          Text(title,
              style: AppTextStyles.body
                  .copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 2),
          Text(subtitle, style: AppTextStyles.caption),
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
    return Text(title,
        style: AppTextStyles.cardTitle
            .copyWith(fontSize: 15, fontWeight: FontWeight.w800));
  }
}

// Заглушка для экрана таблицы норм (объявляется здесь чтобы home мог её импортировать)
class FuelNormsScreen extends StatelessWidget {
  const FuelNormsScreen({super.key});

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
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 24),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Таблица норм', style: AppTextStyles.cardTitle),
              TextButton.icon(
                icon: const Icon(Icons.edit_outlined, size: 16),
                label: const Text('Изменить'),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          const _FuelNormCard(
            name: 'ГАЗ Соболь 27527',
            fuel: 'АИ-92',
            summer: '16.30 л',
            winter: '14.59 л',
            warmAir: '1.14 л',
            coldAir: '1.14 л',
          ),
          const SizedBox(height: 10),
          const _FuelNormCard(
            name: 'Hyundai H350 · Борт 55',
            fuel: 'Дизельное топливо',
            summer: '18.36 л',
            winter: '16.56 л',
            warmAir: '1.2 л',
            coldAir: '1.2 л',
          ),
          const SizedBox(height: 10),
          const _FuelNormCard(
            name: 'Газ А64 R45-50',
            fuel: 'АИ-92',
            summer: '17.94 л',
            winter: '15.99 л',
            warmAir: '0.00 л',
            coldAir: '1.30 л',
          ),
          const SizedBox(height: 10),
          const _FuelNormCard(
            name: 'ГАЗ 32212-авт',
            fuel: 'АИ-92',
            summer: '22.77 л',
            winter: '20.30 л',
            warmAir: '0.00 л',
            coldAir: '1.65 л',
          ),
          const SizedBox(height: 10),
          const _FuelNormCard(
            name: 'Газель "NEXT"',
            fuel: 'АИ-92',
            summer: '24.80 л',
            winter: '23.61 л',
            warmAir: '1.21 л',
            coldAir: '1.21 л',
          ),
        ],
      ),
    );
  }
}

class _FuelNormCard extends StatelessWidget {
  const _FuelNormCard({
    required this.name,
    required this.fuel,
    required this.summer,
    required this.winter,
    required this.warmAir,
    required this.coldAir,
  });

  final String name;
  final String fuel;
  final String summer;
  final String winter;
  final String warmAir;
  final String coldAir;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name,
              style: AppTextStyles.body
                  .copyWith(fontWeight: FontWeight.w800)),
          Text(fuel, style: AppTextStyles.caption),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _NormItem(label: 'Норма лето', value: summer),
              ),
              Expanded(
                child: _NormItem(label: 'Норма зима', value: winter),
              ),
              Expanded(
                child: _NormItem(label: 'Тёплый воздух', value: warmAir),
              ),
              Expanded(
                child: _NormItem(label: 'Холодный воздух', value: coldAir),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NormItem extends StatelessWidget {
  const _NormItem({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: AppColors.text)),
        const SizedBox(height: 2),
        Text(label,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppColors.muted)),
      ],
    );
  }
}
