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
import 'dtp_list_screen.dart';
import 'drivers_list_screen.dart';

// Nav items и helper навигации
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

// ─────────────────────────────────────────────────────────────
// Главный экран Старшего механика (точно по макету)
// ─────────────────────────────────────────────────────────────
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
          // 1. ДТП | Водители
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  title: 'ДТП',
                  count: '1',
                  subtitle: 'на рассмотрении',
                  bg: AppColors.dangerSoft,
                  color: AppColors.danger,
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const DtpListScreen())),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _StatCard(
                  title: 'Водители',
                  count: '0',
                  subtitle: 'Документы\nистекают у 0 водителей',
                  bg: AppColors.warningSoft,
                  color: AppColors.warning,
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(
                          builder: (_) => const DriversListScreen())),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 2. Ближайшие задачи
          const _SectionTitle('Ближайшие задачи'),
          const SizedBox(height: 10),

          // Карточка — заявка
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Заявка · Борт 55',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.muted)),
                    StatusChip(label: 'Новая'),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  'Колесо А · требуется согласование',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.text),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(
                            builder: (_) => const SeniorRequestsScreen())),
                    child: const Text('Проверить и согласовать'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Карточка — критическая неисправность
          AppCard(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Критическая неисправность',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.muted),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Передняя правая стойка · разбита',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.text),
                      ),
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
          const SizedBox(height: 20),

          // 3. Быстрые действия
          Row(
            children: [
              Expanded(
                child: _ActionCard(
                  icon: Icons.assignment_outlined,
                  iconColor: AppColors.primary,
                  bg: AppColors.primarySoft,
                  title: 'Новые заявки',
                  subtitle: 'Проверить и согласовать',
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(
                          builder: (_) => const SeniorRequestsScreen())),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ActionCard(
                  icon: Icons.warning_amber_outlined,
                  iconColor: AppColors.danger,
                  bg: AppColors.dangerSoft,
                  title: 'Критические\nнеисправности',
                  subtitle: '2 неисправности',
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(
                          builder: (_) => const CriticalFaultsScreen())),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Таблица норм — полная ширина
          AppCard(
            color: AppColors.successSoft,
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const FuelNormsScreen())),
            child: Row(
              children: const [
                Icon(Icons.table_chart_outlined,
                    size: 20, color: AppColors.success),
                SizedBox(width: 12),
                Text('Таблица норм',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: AppColors.text)),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 4. Сегодня
          const _SectionTitle('Сегодня'),
          const SizedBox(height: 10),
          AppCard(
            color: AppColors.primarySoft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('График ТО · 13:00 – 16:00',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary)),
                SizedBox(height: 4),
                Text('Борты: 30, 31, 33, 40, 41, 44, 50, 55, 57',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text)),
                SizedBox(height: 2),
                Text('Категории: Шины, Капот, Свечи',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.muted)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Вспомогательные виджеты
// ─────────────────────────────────────────────────────────────
class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);
  final String title;

  @override
  Widget build(BuildContext context) => Text(
        title,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.text),
      );
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.count,
    required this.subtitle,
    required this.bg,
    required this.color,
    required this.onTap,
  });
  final String title;
  final String count;
  final String subtitle;
  final Color bg;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => AppCard(
        color: bg,
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w700, color: color)),
            const SizedBox(height: 8),
            Text(count,
                style: TextStyle(
                    fontSize: 26, fontWeight: FontWeight.w900, color: color)),
            Text(subtitle,
                style: TextStyle(
                    fontSize: 11, fontWeight: FontWeight.w600, color: color)),
          ],
        ),
      );
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.iconColor,
    required this.bg,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
  final IconData icon;
  final Color iconColor;
  final Color bg;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => AppCard(
        color: bg,
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 22, color: iconColor),
            const SizedBox(height: 8),
            Text(title,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: AppColors.text)),
            const SizedBox(height: 2),
            Text(subtitle,
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.muted)),
          ],
        ),
      );
}

// ─────────────────────────────────────────────────────────────
// Таблица норм расхода
// ─────────────────────────────────────────────────────────────
class FuelNormsScreen extends StatelessWidget {
  const FuelNormsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const rows = [
      _NormRow('ГАЗ Соболь 27527', 'АИ-92', '16.30', '14.59', '1.14', '1.14'),
      _NormRow('Hyundai H350', 'Дизельное', '18.36', '16.56', '1.20', '1.20'),
      _NormRow('Газ А64 R45-50', 'АИ-92', '17.94', '15.99', '0.00', '1.30'),
      _NormRow('Газ А64 R45-50', 'Газ', '21.53', '19.73', '0.00', '1.56'),
      _NormRow('ГАЗ 32212-авт', 'АИ-92', '22.77', '20.30', '0.00', '1.65'),
      _NormRow('ГАЗ 32212-авт', 'Газ', '30.06', '26.79', '0.00', '2.18'),
      _NormRow('Газель NEXT', 'АИ-92', '24.80', '23.61', '1.21', '1.21'),
    ];

    return RoleScaffold(
      userName: 'Руслан Омарович',
      roleName: 'Старший механик',
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        color: AppColors.text,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 32),
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
          const SizedBox(height: 8),
          // Заголовок таблицы
          _tableHeader(),
          // Строки
          ...List.generate(rows.length, (i) => _tableRow(rows[i], i)),
        ],
      ),
    );
  }

  Widget _tableHeader() => Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        color: AppColors.field,
        child: Row(
          children: const [
            Expanded(flex: 3, child: _ColLabel('Название')),
            Expanded(flex: 2, child: _ColLabel('Топливо')),
            Expanded(child: _ColLabel('Зима')),
            Expanded(child: _ColLabel('Лето')),
            Expanded(child: _ColLabel('Хол.в')),
            Expanded(child: _ColLabel('Тёпл.в')),
          ],
        ),
      );

  Widget _tableRow(_NormRow r, int i) => Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: i.isEven ? AppColors.card : AppColors.field,
          border: const Border(bottom: BorderSide(color: AppColors.line)),
        ),
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Text(r.name,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text))),
            Expanded(
                flex: 2,
                child: Text(r.fuel,
                    style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColors.muted))),
            Expanded(child: _CellValue(r.winter)),
            Expanded(child: _CellValue(r.summer)),
            Expanded(child: _CellValue(r.coldAir)),
            Expanded(child: _CellValue(r.warmAir)),
          ],
        ),
      );
}

class _ColLabel extends StatelessWidget {
  const _ColLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.muted),
      );
}

class _CellValue extends StatelessWidget {
  const _CellValue(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: AppColors.text),
      );
}

class _NormRow {
  const _NormRow(this.name, this.fuel, this.winter, this.summer, this.coldAir,
      this.warmAir);
  final String name;
  final String fuel;
  final String winter;
  final String summer;
  final String coldAir;
  final String warmAir;
}
