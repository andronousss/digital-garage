import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:digital_garage/shared/widgets/status_chip.dart';
import 'package:flutter/material.dart';

import 'warehouse_home_screen.dart';

class RequestsScreen extends StatelessWidget {
  const RequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      userName: 'Руслан Омаров',
      roleName: 'Завсклад',
      bottomNavigationBar: RoleBottomNav(
        items: warehouseNavItems,
        currentIndex: 1,
        onChanged: (index) {
          if (index != 1) {
            navigateWarehouseTab(context, index);
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
                _FilterChip(label: 'Новые'),
                const SizedBox(width: 8),
                _FilterChip(label: 'На рассмотрении'),
                const SizedBox(width: 8),
                _FilterChip(label: 'Готово к выдаче'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _RequestCard(
                  reqId: 'ЗАЯВКА #REQ-90B2',
                  reqIdColor: AppColors.primary,
                  vehicle: 'Ford Transit (Борт №112)',
                  status: 'Новая',
                  statusColor: AppColors.primary,
                  statusBgColor: AppColors.primarySoft,
                  detail: 'Фильтр масляный оригинальный',
                  mechanic: 'С. Ахметов',
                  quantity: '1 шт',
                  date: 'Сегодня, 11:24',
                  primaryActionText: 'Одобрить',
                  primaryActionColor: AppColors.primary,
                  secondaryActionText: 'Смотреть',
                ),
                const SizedBox(height: 12),
                _RequestCard(
                  reqId: 'ЗАЯВКА #REQ-8079',
                  reqIdColor: const Color(0xFFF39C12),
                  vehicle: 'Hyundai H350 (Борт №753)',
                  status: 'На рассмотрении',
                  statusColor: const Color(0xFFF39C12),
                  statusBgColor: const Color(0xFFFEF5E7),
                  detail: 'Колодки тормозные передние',
                  mechanic: 'А. Калиев',
                  quantity: '2 шт',
                  date: 'Сегодня, 09:40',
                  primaryActionText: 'Отклонить',
                  primaryActionColor: Colors.red.shade50,
                  primaryActionTextColor: Colors.red.shade700,
                  secondaryActionText: 'Смотреть',
                ),
                const SizedBox(height: 12),
                _RequestCard(
                  reqId: 'ЗАЯВКА #REQ-9064',
                  reqIdColor: const Color(0xFF28A745),
                  vehicle: 'Газель NEXT (Борт №102)',
                  status: 'Готово к выдаче',
                  statusColor: const Color(0xFF28A745),
                  statusBgColor: const Color(0xFFE6F7ED),
                  detail: 'Ремень ГРМ с роликами',
                  mechanic: 'Иван Петров',
                  quantity: '1 комплект',
                  date: 'Сегодня, 09:35',
                  primaryActionText: 'Выдать в работу',
                  primaryActionColor: const Color(0xFF28A745),
                  isFullWidthPrimary: true,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, this.isSelected = false});

  final String label;
  final bool isSelected;

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
          color: AppColors.text,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  const _RequestCard({
    required this.reqId,
    required this.reqIdColor,
    required this.vehicle,
    required this.status,
    required this.statusColor,
    required this.statusBgColor,
    required this.detail,
    required this.mechanic,
    required this.quantity,
    this.date,
    required this.primaryActionText,
    required this.primaryActionColor,
    this.primaryActionTextColor = Colors.white,
    this.secondaryActionText,
    this.isFullWidthPrimary = false,
  });

  final String reqId;
  final Color reqIdColor;
  final String vehicle;
  final String status;
  final Color statusColor;
  final Color statusBgColor;
  final String detail;
  final String mechanic;
  final String quantity;
  final String? date;
  final String primaryActionText;
  final Color primaryActionColor;
  final Color primaryActionTextColor;
  final String? secondaryActionText;
  final bool isFullWidthPrimary;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(reqId, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: reqIdColor, letterSpacing: 0.5)),
              StatusChip(label: status, backgroundColor: statusBgColor, foregroundColor: statusColor),
            ],
          ),
          const SizedBox(height: 4),
          Text(vehicle, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: AppColors.text)),
          const SizedBox(height: 12),
          RichText(
            text: TextSpan(
              style: AppTextStyles.caption.copyWith(color: AppColors.muted),
              children: [
                const TextSpan(text: 'Деталь: '),
                TextSpan(text: detail, style: const TextStyle(color: AppColors.text, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              style: AppTextStyles.caption.copyWith(color: AppColors.muted),
              children: [
                const TextSpan(text: 'Механик: '),
                TextSpan(text: mechanic, style: const TextStyle(color: AppColors.text, fontWeight: FontWeight.w700)),
                const TextSpan(text: ' • Количество: '),
                TextSpan(text: quantity, style: const TextStyle(color: AppColors.text, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          if (date != null) ...[
            const SizedBox(height: 4),
            Text('Дата: $date', style: AppTextStyles.caption.copyWith(color: AppColors.muted)),
          ],
          const SizedBox(height: 16),
          if (isFullWidthPrimary)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryActionColor,
                  foregroundColor: primaryActionTextColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                ),
                child: Text(primaryActionText, style: const TextStyle(fontWeight: FontWeight.w700)),
              ),
            )
          else
            Row(
              children: [
                if (secondaryActionText != null) ...[
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.text,
                        side: const BorderSide(color: AppColors.line),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(secondaryActionText!, style: const TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryActionColor,
                      foregroundColor: primaryActionTextColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      elevation: 0,
                    ),
                    child: Text(primaryActionText, style: const TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
