import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:digital_garage/shared/widgets/status_chip.dart';
import 'package:flutter/material.dart';

import 'mechanic_schedule_screen.dart';

class MechanicHomeScreen extends StatelessWidget {
  const MechanicHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      userName: 'Азамат Рахимов',
      roleName: 'Механик',
      bottomNavigationBar: RoleBottomNav(
        currentIndex: 0,
        items: const [
          RoleBottomNavItem(icon: Icons.home_outlined, label: 'Главная'),
          RoleBottomNavItem(icon: Icons.grid_view_outlined, label: 'График ТО'),
          RoleBottomNavItem(icon: Icons.assignment_outlined, label: 'Заявки'),
          RoleBottomNavItem(icon: Icons.person_outline, label: 'Профиль'),
        ],
        onChanged: (index) {
          navigateMechanicTab(context, index);
        },
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 24),
        children: const [
          _ScanQrAction(),
          SizedBox(height: 10),
          _QuickActionsGrid(),
          SizedBox(height: 22),
          _SectionHeader(title: 'Сегодня', trailing: '09:00-18:00'),
          SizedBox(height: 10),
          _MaintenanceTaskCard(),
          SizedBox(height: 10),
          _ReadyPartCard(),
        ],
      ),
    );
  }
}

class _ScanQrAction extends StatelessWidget {
  const _ScanQrAction();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: AppColors.primary,
      padding: const EdgeInsets.all(14),
      child: SizedBox(
        height: 92,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Row(
              children: [
                Icon(Icons.qr_code_scanner, color: Colors.white),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Сканировать QR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              'Открыть паспорт борта из кабины',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionsGrid extends StatelessWidget {
  const _QuickActionsGrid();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Expanded(
              child: _QuickActionCard(
                title: 'График ТО',
                subtitle: '3 борта сегодня',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _QuickActionCard(
                title: 'Мои заявки',
                subtitle: '1 готова к выдаче',
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: const [
            Expanded(
              child: _QuickActionCard(
                title: 'Дефект',
                subtitle: 'Фото и описание',
              ),
            ),
            SizedBox(width: 10),
            Spacer(),
          ],
        ),
      ],
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.cardTitle),
          Text(subtitle, style: AppTextStyles.caption),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.trailing});

  final String title;
  final String trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title, style: AppTextStyles.cardTitle)),
        StatusChip(label: trailing),
      ],
    );
  }
}

class _MaintenanceTaskCard extends StatelessWidget {
  const _MaintenanceTaskCard();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ТО · 13:00-16:00', style: AppTextStyles.caption),
                SizedBox(height: 6),
                Text(
                  'Борт 55 · шины, капот, свечи',
                  style: AppTextStyles.cardTitle,
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          StatusChip(label: 'В работе'),
        ],
      ),
    );
  }
}

class _ReadyPartCard extends StatelessWidget {
  const _ReadyPartCard();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: AppColors.successSoft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Заявка №007', style: AppTextStyles.caption),
                SizedBox(height: 6),
                Text('Деталь готова к выдаче', style: AppTextStyles.cardTitle),
              ],
            ),
          ),
          SizedBox(width: 10),
          StatusChip(
            label: 'Склад',
            backgroundColor: AppColors.successSoft,
            foregroundColor: AppColors.success,
          ),
        ],
      ),
    );
  }
}
