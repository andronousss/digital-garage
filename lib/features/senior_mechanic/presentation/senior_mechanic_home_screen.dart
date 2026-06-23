import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
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
          _HeroRequestCard(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SeniorRequestsScreen()),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _MiniHomeCard(
                  title: 'Таблица норм',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const FuelNormsScreen()),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MiniHomeCard(
                  title: 'Критические\nнеисправности',
                  subtitle: '2 неисправности',
                  withDot: true,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const CriticalFaultsScreen()),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _MiniHomeCard(
                  title: 'ДТП',
                  subtitle: '1 на рассмотрении',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const DtpListScreen()),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MiniHomeCard(
                  title: 'Водители',
                  subtitle: 'Документы истекают у\n0 водителей',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const DriversListScreen()),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const _TasksHeader(),
          const SizedBox(height: 8),
          _TaskTile(
            subtitle: 'Заявка · Борт 55',
            title: 'Колесо А · требуется\nсогласование',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SeniorRequestsScreen()),
            ),
          ),
          const SizedBox(height: 10),
          _TaskTile(
            subtitle: 'Критическая неисправность',
            title: 'Передняя правая стойка ·\nразбита',
            color: AppColors.dangerSoft,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CriticalFaultsScreen()),
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

class _HeroRequestCard extends StatelessWidget {
  const _HeroRequestCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(18),
          ),
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Text(
                      'Новые заявки',
                      style: TextStyle(
                        fontSize: 34 / 2,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF2FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.description_outlined,
                      color: AppColors.primary,
                      size: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                'Проверить и согласовать →',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiniHomeCard extends StatelessWidget {
  const _MiniHomeCard({
    required this.title,
    required this.onTap,
    this.subtitle,
    this.withDot = false,
  });

  final String title;
  final String? subtitle;
  final bool withDot;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Ink(
          height: 110,
          decoration: BoxDecoration(
            color: const Color(0xFFF1F1F1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFD8D8D8)),
          ),
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18 / 1.25,
                      height: 1.2,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: const TextStyle(
                        fontSize: 16 / 1.2,
                        height: 1.2,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF4F4F4F),
                      ),
                    ),
                ],
              ),
              if (withDot)
                const Positioned(
                  top: 0,
                  right: 0,
                  child: _RedDot(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TasksHeader extends StatelessWidget {
  const _TasksHeader();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Ближайшие задачи',
          style: TextStyle(
            fontSize: 34 / 2,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        Text(
          'Сегодня',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}

class _TaskTile extends StatelessWidget {
  const _TaskTile({
    required this.subtitle,
    required this.title,
    required this.onTap,
    this.color = Colors.white,
  });

  final String subtitle;
  final String title;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFD5D5D5)),
          ),
          padding: const EdgeInsets.fromLTRB(10, 8, 28, 10),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 15 / 1.2,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF9699A3),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 36 / 2,
                      height: 1.05,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const Positioned(
                top: 0,
                right: -16,
                child: _RedDot(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RedDot extends StatelessWidget {
  const _RedDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: const BoxDecoration(
        color: Color(0xFFFF0000),
        shape: BoxShape.circle,
      ),
    );
  }
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
