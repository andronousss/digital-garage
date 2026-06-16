import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:digital_garage/shared/widgets/status_chip.dart';
import 'package:flutter/material.dart';

import 'board_status_screen.dart';
import 'profile_screen.dart';
import 'shifts_screen.dart';
import 'notifications_screen.dart';

const dispatcherNavItems = [
  RoleBottomNavItem(icon: Icons.home, label: 'Главная'),
  RoleBottomNavItem(icon: Icons.view_day, label: 'Путевые'),
  RoleBottomNavItem(icon: Icons.local_shipping, label: 'Борты'),
  RoleBottomNavItem(icon: Icons.person, label: 'Профиль'),
];

void navigateDispatcherTab(BuildContext context, int index) {
  Widget? target;
  switch (index) {
    case 0:
      target = const DispatcherHomeScreen();
      break;
    case 1:
      target = const ShiftsScreen();
      break;
    case 2:
      target = const BoardStatusScreen();
      break;
    case 3:
      target = const ProfileScreen();
      break;
  }
  if (target != null) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => target!,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }
}

class DispatcherHomeScreen extends StatelessWidget {
  const DispatcherHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      userName: 'Руслан Омаров',
      roleName: 'Диспетчер',
      bottomNavigationBar: RoleBottomNav(
        items: dispatcherNavItems,
        currentIndex: 0,
        onChanged: (index) {
          if (index != 0) {
            navigateDispatcherTab(context, index);
          }
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Активные ПЛ',
                    value: '12',
                    icon: Icons.receipt_long_outlined,
                    iconColor: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _StatCard(
                    title: 'Смены',
                    value: '4',
                    icon: Icons.assignment_ind_outlined,
                    iconColor: AppColors.primary,
                    isOutlined: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'На линии',
                    value: '18',
                    icon: Icons.local_shipping_outlined,
                    iconColor: AppColors.muted,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _StatCard(
                    title: 'Задержки возврата',
                    value: '2',
                    icon: Icons.warning_amber_rounded,
                    iconColor: Colors.red.shade700,
                    backgroundColor: Colors.red.shade100,
                    textColor: Colors.red.shade900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _SectionHeader(title: 'Активные смены', onSeeAll: () => navigateDispatcherTab(context, 1)),
            const SizedBox(height: 12),
            AppCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.local_shipping_outlined, color: AppColors.muted, size: 20),
                          const SizedBox(width: 8),
                          const Text('Hyundai H350', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.text)),
                        ],
                      ),
                      const StatusChip(label: 'Активна', backgroundColor: Color(0xFFE6F7ED), foregroundColor: Color(0xFF28A745)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Борт №753', style: AppTextStyles.caption.copyWith(color: AppColors.muted)),
                      const Text('09:00 - 21:00', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.text)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _SectionHeader(title: 'Проблемные борты', onSeeAll: () => navigateDispatcherTab(context, 2)),
            const SizedBox(height: 12),
            AppCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.error_outline, color: Colors.red.shade700, size: 20),
                          const SizedBox(width: 8),
                          const Text('Газель NEXT', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.text)),
                        ],
                      ),
                      StatusChip(label: 'Задержка 2ч', backgroundColor: Colors.red.shade50, foregroundColor: Colors.red.shade700),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Гос. номер:\nA777KE', style: AppTextStyles.caption.copyWith(color: AppColors.muted)),
                      Text('Маршрут сорван', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.red.shade700, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    this.iconColor,
    this.backgroundColor = AppColors.card,
    this.textColor = AppColors.text,
    this.isOutlined = false,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color? iconColor;
  final Color backgroundColor;
  final Color textColor;
  final bool isOutlined;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: isOutlined ? Border.all(color: AppColors.primary, width: 2) : null,
        boxShadow: isOutlined ? [] : [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: textColor.withOpacity(0.8)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(icon, size: 20, color: iconColor),
            ],
          ),
          Text(
            value,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: textColor),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.onSeeAll});
  final String title;
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.text)),
        TextButton(
          onPressed: onSeeAll,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(50, 30),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text('Все', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}
