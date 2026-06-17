import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:flutter/material.dart';

import 'warehouse_home_screen.dart';

class RequestDetailScreen extends StatelessWidget {
  const RequestDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      userName: 'Форма обработки #REQ-9079',
      roleName: '', // Empty role as the header is completely replaced by title
      bottomNavigationBar: RoleBottomNav(
        items: warehouseNavItems,
        currentIndex: 1, // Highlighting Requests tab
        onChanged: (index) {
          if (index != 1) {
            navigateWarehouseTab(context, index);
          }
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.line),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4, offset: const Offset(0, 2)),
                  ],
                ),
                child: const Icon(Icons.reply, color: AppColors.primary, size: 20),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F3F8), // Light grayish blue
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text('Снятие запчасти', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.muted, fontSize: 13)),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 2, offset: const Offset(0, 1)),
                        ],
                      ),
                      child: const Text('Установка / Выдача', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.text, fontSize: 13)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            AppCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Параметры выдачи', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.text)),
                  const SizedBox(height: 16),
                  _buildInputGroup('Деталь / Номенклатура', 'Колодки тормозные передние Hyundai', isDropdown: false),
                  const SizedBox(height: 12),
                  _buildInputGroup('Категория склада', 'Тормозная система', isDropdown: true),
                  const SizedBox(height: 12),
                  _buildInputGroup('Количество для списания', '2', isDropdown: false),
                  const SizedBox(height: 12),
                  _buildInputGroup('Ответственный механик', 'Асхат Калиев (ID-992)', isDropdown: true),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  elevation: 0,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check, size: 20),
                    SizedBox(width: 8),
                    Text('Подтвердить и выдать', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red.shade700,
                      side: BorderSide(color: Colors.red.shade100),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      backgroundColor: Colors.transparent, // or Colors.white
                    ),
                    child: const Text('Отклонить', style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFEF5E7), // Yellow bg
                      foregroundColor: const Color(0xFFF39C12), // Orange text
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      elevation: 0,
                    ),
                    child: const Text('Нет на складе', style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text('История прохождения заявки', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.text)),
            const SizedBox(height: 12),
            AppCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _TimelineItem(
                    title: 'Направлено на\nрассмотрение',
                    time: 'Сегодня,\n09:40',
                    subtitle: 'Автоматически назначена зона: Центральный склад',
                    color: AppColors.primary,
                    isFirst: true,
                  ),
                  _TimelineItem(
                    title: 'Создана механиком\nавтопарка',
                    time: 'Сегодня,\n09:35',
                    subtitle: 'Заявитель: Асхат Калиев. Для борта №753',
                    color: const Color(0xFF28A745),
                    isLast: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildInputGroup(String label, String value, {required bool isDropdown}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.muted)),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF4F6F9), // Light grayish blue fill
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.line),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.text)),
              if (isDropdown) const Icon(Icons.arrow_drop_down, color: AppColors.muted, size: 20),
            ],
          ),
        ),
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    required this.title,
    required this.time,
    required this.subtitle,
    required this.color,
    this.isFirst = false,
    this.isLast = false,
  });

  final String title;
  final String time;
  final String subtitle;
  final Color color;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              if (!isFirst) Container(width: 2, height: 16, color: AppColors.line) else const SizedBox(height: 16),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              if (!isLast) Expanded(child: Container(width: 2, color: AppColors.line)) else const Expanded(child: SizedBox()),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24, top: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.text))),
                      Text(time, style: const TextStyle(fontSize: 10, color: AppColors.muted), textAlign: TextAlign.right),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontSize: 11, color: AppColors.muted)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
