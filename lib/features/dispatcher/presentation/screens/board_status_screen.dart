import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:digital_garage/shared/widgets/status_chip.dart';
import 'package:flutter/material.dart';

import 'dispatcher_home_screen.dart';

class BoardStatusScreen extends StatelessWidget {
  const BoardStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      userName: 'Руслан Омаров',
      roleName: 'Диспетчер',
      bottomNavigationBar: RoleBottomNav(
        items: dispatcherNavItems,
        currentIndex: 2,
        onChanged: (index) {
          if (index != 2) {
            navigateDispatcherTab(context, index);
          }
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.line),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Поиск',
                        hintStyle: TextStyle(color: AppColors.muted),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Icon(Icons.search, color: AppColors.muted),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _FilterChip(label: 'Все', isSelected: true),
                const SizedBox(width: 8),
                _FilterChip(label: 'На ТО', color: Color(0xFFF39C12)),
                const SizedBox(width: 8),
                _FilterChip(label: 'В ремонте', color: Colors.red.shade700),
                const SizedBox(width: 8),
                _FilterChip(label: 'На линии', color: Color(0xFF28A745)),
                const SizedBox(width: 8),
                _FilterChip(label: 'Резерв', color: AppColors.muted),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: const [
                _BoardCard(
                  title: 'Hyundai H350',
                  subtitle: 'Борт №753 • Гос: 049ED',
                  status: 'На линии',
                  statusColor: Color(0xFF28A745),
                  statusBgColor: Color(0xFFE6F7ED),
                ),
                SizedBox(height: 12),
                _BoardCard(
                  title: 'Газель NEXT',
                  subtitle: 'Борт №102 • Гос: A777KE',
                  status: 'В ремонте',
                  statusColor: Colors.red,
                  statusBgColor: Color(0xFFFFEBEE),
                ),
                SizedBox(height: 12),
                _BoardCard(
                  title: 'Mercedes Sprinter',
                  subtitle: 'Борт №441 • Гос: 322DI',
                  status: 'На ТО',
                  statusColor: Color(0xFFF39C12),
                  statusBgColor: Color(0xFFFEF5E7),
                ),
                SizedBox(height: 12),
                _BoardCard(
                  title: 'Ford Transit',
                  subtitle: 'Борт №901 • Гос: 881AS',
                  status: 'Резерв',
                  statusColor: AppColors.muted,
                  statusBgColor: AppColors.bg,
                ),
                SizedBox(height: 12),
                _BoardCard(
                  title: 'Iveco Daily',
                  subtitle: 'Борт №305 • Гос: 611MK',
                  status: 'На линии',
                  statusColor: Color(0xFF28A745),
                  statusBgColor: Color(0xFFE6F7ED),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, this.isSelected = false, this.color});

  final String label;
  final bool isSelected;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.bg : AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? AppColors.muted : AppColors.line),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color ?? AppColors.text,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }
}

class _BoardCard extends StatelessWidget {
  const _BoardCard({
    required this.title,
    required this.subtitle,
    required this.status,
    required this.statusColor,
    required this.statusBgColor,
  });

  final String title;
  final String subtitle;
  final String status;
  final Color statusColor;
  final Color statusBgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            border: Border(left: BorderSide(color: statusColor, width: 4)),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: AppColors.text)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: AppTextStyles.caption.copyWith(color: AppColors.muted)),
                ],
              ),
              StatusChip(
                label: status,
                backgroundColor: statusBgColor,
                foregroundColor: statusColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
