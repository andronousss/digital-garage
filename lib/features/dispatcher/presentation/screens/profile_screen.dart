import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:flutter/material.dart';

import 'dispatcher_home_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      userName: 'Руслан Омаров',
      roleName: 'Диспетчер',
      bottomNavigationBar: RoleBottomNav(
        items: dispatcherNavItems,
        currentIndex: 3,
        onChanged: (index) {
          if (index != 3) {
            navigateDispatcherTab(context, index);
          }
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F0FE),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary.withOpacity(0.2), width: 2),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'РО',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Руслан Омаров', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.text)),
            const SizedBox(height: 4),
            Text('ID Диспетчера: #DSP-9982', style: AppTextStyles.caption.copyWith(color: AppColors.muted)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.bg,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.line),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.phone_outlined, size: 14, color: AppColors.muted),
                  SizedBox(width: 6),
                  Text('+7 (707) *** ** 54', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.muted)),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'УПРАВЛЕНИЕ ОПЕРАЦИЯМИ',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.muted, letterSpacing: 0.5),
              ),
            ),
            const SizedBox(height: 16),
            _ProfileMenuItem(
              title: 'Синхронизация данных',
              icon: Icons.sync,
              iconColor: AppColors.primary,
              iconBgColor: AppColors.primarySoft,
              trailing: const Text('Успешно', style: TextStyle(color: Color(0xFF28A745), fontSize: 12, fontWeight: FontWeight.w700)),
              onTap: () {},
            ),
            const SizedBox(height: 12),
            _ProfileMenuItem(
              title: 'Настройки приложения',
              icon: Icons.settings_outlined,
              iconColor: const Color(0xFF9B51E0),
              iconBgColor: const Color(0xFFF3E5F5),
              onTap: () {},
            ),
            const SizedBox(height: 12),
            _ProfileMenuItem(
              title: 'Безопасность сессии',
              icon: Icons.shield_outlined,
              iconColor: const Color(0xFFF2994A),
              iconBgColor: const Color(0xFFFEF5E7),
              onTap: () {},
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(color: Colors.red.shade100, shape: BoxShape.circle),
                      child: Icon(Icons.logout, color: Colors.red.shade700, size: 20),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text('Выйти из системы', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.red.shade700)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  const _ProfileMenuItem({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    this.trailing,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final Widget? trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: iconBgColor, shape: BoxShape.circle),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.text)),
            ),
            if (trailing != null) trailing! else const Icon(Icons.chevron_right, color: AppColors.muted),
          ],
        ),
      ),
    );
  }
}
