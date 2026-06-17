import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:digital_garage/shared/widgets/status_chip.dart';
import 'package:flutter/material.dart';

import 'requests_screen.dart';
import 'inventory_screen.dart';
import 'profile_screen.dart';

const warehouseNavItems = [
  RoleBottomNavItem(icon: Icons.home, label: 'Главная'),
  RoleBottomNavItem(icon: Icons.assignment_outlined, label: 'Заявки'),
  RoleBottomNavItem(icon: Icons.inventory_2_outlined, label: 'Остатки'),
  RoleBottomNavItem(icon: Icons.person, label: 'Профиль'),
];

void navigateWarehouseTab(BuildContext context, int index) {
  Widget? target;
  switch (index) {
    case 0:
      target = const WarehouseHomeScreen();
      break;
    case 1:
      target = const RequestsScreen();
      break;
    case 2:
      target = const InventoryScreen();
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

class WarehouseHomeScreen extends StatelessWidget {
  const WarehouseHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      userName: 'Руслан Омаров',
      roleName: 'Завсклад',
      bottomNavigationBar: RoleBottomNav(
        items: warehouseNavItems,
        currentIndex: 0,
        onChanged: (index) {
          if (index != 0) {
            navigateWarehouseTab(context, index);
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
                    title: 'Новые заявки',
                    value: '7',
                    icon: Icons.assignment_outlined,
                    iconColor: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: _StatCard(
                    title: 'Остатки номенкл.',
                    value: '128',
                    icon: Icons.inventory_2_outlined,
                    iconColor: Color(0xFF28A745),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Дефицит',
                    value: '5',
                    icon: Icons.trending_down_outlined,
                    iconColor: Colors.red.shade700,
                    textColor: Colors.red.shade700,
                    backgroundColor: Colors.red.shade50,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    title: 'Перемещения',
                    value: '3',
                    icon: Icons.local_shipping_outlined,
                    iconColor: const Color(0xFFF39C12),
                    textColor: const Color(0xFFD68910),
                    backgroundColor: const Color(0xFFFEF5E7),
                    isOutlined: true,
                    outlineColor: const Color(0xFFF39C12).withOpacity(0.3),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _SectionHeader(title: 'Последние заявки автопарка', actionText: 'Все заявки', onAction: () => navigateWarehouseTab(context, 1)),
            const SizedBox(height: 12),
            AppCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Hyundai H350 (Борт 753)', style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.text)),
                            const SizedBox(height: 4),
                            const Text('Колодки тормозные передние', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.primary, fontSize: 13)),
                          ],
                        ),
                      ),
                      const StatusChip(label: 'На рассмотрении', backgroundColor: Color(0xFFFEF5E7), foregroundColor: Color(0xFFF39C12)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: AppTextStyles.caption.copyWith(color: AppColors.muted),
                          children: const [
                            TextSpan(text: 'Количество: '),
                            TextSpan(text: '2 шт', style: TextStyle(color: AppColors.text, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: AppTextStyles.caption.copyWith(color: AppColors.muted),
                          children: const [
                            TextSpan(text: 'Механик: '),
                            TextSpan(text: 'А. Калиев', style: TextStyle(color: AppColors.text, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Критический дефицит товаров', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.text)),
                StatusChip(label: 'Внимание', backgroundColor: Colors.red.shade50, foregroundColor: Colors.red.shade700),
              ],
            ),
            const SizedBox(height: 12),
            AppCard(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Шины Michelin Agilis 215/65 R16C', style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.text)),
                        const SizedBox(height: 6),
                        Text('Категория: Шины и диски', style: AppTextStyles.caption.copyWith(color: AppColors.muted)),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Осталось 2', style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red.shade700, fontSize: 16)),
                      const SizedBox(height: 4),
                      Text('Минимум: 8 шт', style: AppTextStyles.caption.copyWith(color: AppColors.muted)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text('Активные выдачи в работу', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.text)),
            const SizedBox(height: 12),
            AppCard(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Масло моторное Shell Helix 5W40', style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.text)),
                        const SizedBox(height: 6),
                        RichText(
                          text: TextSpan(
                            style: AppTextStyles.caption.copyWith(color: AppColors.muted),
                            children: const [
                              TextSpan(text: 'Выдача механику: '),
                              TextSpan(text: 'Иван Петров', style: TextStyle(color: AppColors.text, fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const StatusChip(label: 'Готово к выдаче', backgroundColor: AppColors.primarySoft, foregroundColor: AppColors.primary),
                ],
              ),
            ),
            const SizedBox(height: 16),
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
    this.outlineColor,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color? iconColor;
  final Color backgroundColor;
  final Color textColor;
  final bool isOutlined;
  final Color? outlineColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: isOutlined ? Border.all(color: outlineColor ?? AppColors.primary, width: 2) : Border.all(color: AppColors.line, width: 1),
        boxShadow: isOutlined ? [] : [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: textColor.withOpacity(0.8), height: 1.2),
                  maxLines: 2,
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
  const _SectionHeader({required this.title, required this.actionText, required this.onAction});
  final String title;
  final String actionText;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.text))),
        TextButton(
          onPressed: onAction,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(50, 30),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(actionText, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}
