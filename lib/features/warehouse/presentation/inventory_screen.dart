import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:digital_garage/shared/widgets/status_chip.dart';
import 'package:flutter/material.dart';

import 'warehouse_home_screen.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      userName: 'Складской учет / Остатки',
      roleName: '', // Assuming the design means to override the whole header, but since we use RoleScaffold it might be better to just pass it to userName
      bottomNavigationBar: RoleBottomNav(
        items: warehouseNavItems,
        currentIndex: 2,
        onChanged: (index) {
          if (index != 2) {
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
                _FilterChip(label: 'Все категории', isSelected: true),
                const SizedBox(width: 8),
                _FilterChip(label: 'Расходники'),
                const SizedBox(width: 8),
                _FilterChip(label: 'Тормозная система'),
                const SizedBox(width: 8),
                _FilterChip(label: 'Шины и диски'),
                const SizedBox(width: 8),
                _FilterChip(label: 'Технические жидкости'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: const [
                _InventoryItem(
                  title: 'Колодки тормозные передние Hyundai',
                  category: 'Расходники',
                  minQty: '5',
                  currentQty: '14 шт',
                  status: 'В наличии',
                  statusColor: Color(0xFF28A745),
                  statusBgColor: Color(0xFFE6F7ED),
                ),
                _InventoryItem(
                  title: 'Шины Michelin Agilis 215/65 R16C',
                  category: 'Шины и диски',
                  minQty: '8',
                  currentQty: '2 шт',
                  currentQtyColor: Colors.red,
                  status: 'Заканчивается',
                  statusColor: Colors.red,
                  statusBgColor: Color(0xFFFFEBEE),
                ),
                _InventoryItem(
                  title: 'Масло моторное Shell Helix 5W40',
                  category: 'Технические жидкости',
                  minQty: '20',
                  currentQty: '45 л',
                  status: 'В наличии',
                  statusColor: Color(0xFF28A745),
                  statusBgColor: Color(0xFFE6F7ED),
                ),
                _InventoryItem(
                  title: 'Фильтр воздушный Ford Transit',
                  category: 'Расходники',
                  minQty: '10',
                  currentQty: '0 шт',
                  currentQtyColor: Colors.red,
                  status: 'Нет на складе',
                  statusColor: Colors.red,
                  statusBgColor: Color(0xFFFFEBEE),
                ),
                _InventoryItem(
                  title: 'Антифриз концентрат G12 Red',
                  category: 'Технические жидкости',
                  minQty: '15',
                  currentQty: '18 л',
                  status: 'В наличии',
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
  const _FilterChip({required this.label, this.isSelected = false});

  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? AppColors.primary : AppColors.line),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : AppColors.text,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }
}

class _InventoryItem extends StatelessWidget {
  const _InventoryItem({
    required this.title,
    required this.category,
    required this.minQty,
    required this.currentQty,
    this.currentQtyColor = AppColors.text,
    required this.status,
    required this.statusColor,
    required this.statusBgColor,
  });

  final String title;
  final String category;
  final String minQty;
  final String currentQty;
  final Color currentQtyColor;
  final String status;
  final Color statusColor;
  final Color statusBgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.line)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.text, fontSize: 13)),
                const SizedBox(height: 6),
                RichText(
                  text: TextSpan(
                    style: AppTextStyles.caption.copyWith(color: AppColors.muted),
                    children: [
                      TextSpan(text: 'Категория: $category • Мин: '),
                      TextSpan(text: minQty, style: const TextStyle(color: AppColors.text, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(currentQty, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: currentQtyColor)),
              const SizedBox(height: 6),
              StatusChip(
                label: status,
                backgroundColor: statusBgColor,
                foregroundColor: statusColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
