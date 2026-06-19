import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_button.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:flutter/material.dart';

import 'mechanic_schedule_screen.dart';

class MechanicRequestDetailScreen extends StatefulWidget {
  const MechanicRequestDetailScreen({super.key});

  @override
  State<MechanicRequestDetailScreen> createState() => _MechanicRequestDetailScreenState();
}

class _MechanicRequestDetailScreenState extends State<MechanicRequestDetailScreen> {
  late TextEditingController _categoryController;
  late TextEditingController _detailController;
  late TextEditingController _commentController;

  @override
  void initState() {
    super.initState();
    _categoryController = TextEditingController(text: 'Колеса');
    _detailController = TextEditingController(text: 'Колесо A');
    _commentController = TextEditingController(text: 'Нужна замена после осмотра ТО.');
  }

  @override
  void dispose() {
    _categoryController.dispose();
    _detailController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      userName: 'Азамат Рахимов',
      roleName: 'Механик',
      bottomNavigationBar: RoleBottomNav(
        currentIndex: 2,
        items: mechanicNavItems,
        onChanged: (index) {
          navigateMechanicTab(context, index);
        },
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 24),
        children: [
          const _SectionHeader(title: 'Заявка на замену'),
          const SizedBox(height: 10),
          AppCard(
            color: AppColors.primarySoft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Заявка №007', style: AppTextStyles.cardTitle),
                SizedBox(height: 4),
                Text('Борт 55 · Hyundai H350', style: AppTextStyles.caption),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const _SectionHeader(title: 'Информация о детали'),
          const SizedBox(height: 10),
          _buildInputGroup('Категория', _categoryController, isDropdown: true),
          const SizedBox(height: 12),
          _buildInputGroup('Деталь', _detailController),
          const SizedBox(height: 12),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Количество', style: AppTextStyles.caption),
                const SizedBox(height: 8),
                TextField(
                  controller: TextEditingController(text: '1'),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const _SectionHeader(title: 'Комментарий'),
          const SizedBox(height: 10),
          AppCard(
            child: TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          ),
          const SizedBox(height: 22),
          const _SectionHeader(title: 'Статус'),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.close),
                  label: const Text('Снять на склад'),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.card,
                    foregroundColor: AppColors.text,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.check),
                  label: const Text('На списание'),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.card,
                    foregroundColor: AppColors.text,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const AppButton(label: 'Подать заявку'),
        ],
      ),
    );
  }

  Widget _buildInputGroup(String label, TextEditingController? controller, {bool isDropdown = false}) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.caption),
          const SizedBox(height: 8),
          isDropdown
              ? DropdownButtonFormField<String>(
                  initialValue: controller?.text,
                  items: const [
                    DropdownMenuItem(value: 'Колеса', child: Text('Колеса')),
                    DropdownMenuItem(value: 'Тормоза', child: Text('Тормоза')),
                    DropdownMenuItem(value: 'Двигатель', child: Text('Двигатель')),
                  ],
                  onChanged: (val) => controller?.text = val ?? '',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                )
              : TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: AppTextStyles.cardTitle);
  }
}
