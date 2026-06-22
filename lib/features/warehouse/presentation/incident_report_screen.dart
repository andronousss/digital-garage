import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_button.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:flutter/material.dart';

import 'warehouse_home_screen.dart';

class IncidentReportScreen extends StatefulWidget {
  const IncidentReportScreen({super.key});

  @override
  State<IncidentReportScreen> createState() => _IncidentReportScreenState();
}

class _IncidentReportScreenState extends State<IncidentReportScreen> {
  late TextEditingController _locationController;
  late TextEditingController _commentController;
  String _selectedSeverity = 'Средняя';

  @override
  void initState() {
    super.initState();
    _locationController = TextEditingController(text: 'Астана, Абая 18');
    _commentController = TextEditingController();
  }

  @override
  void dispose() {
    _locationController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      userName: 'Заведующий складом',
      roleName: 'Завсклад',
      bottomNavigationBar: RoleBottomNav(
        items: warehouseNavItems,
        currentIndex: 0,
        onChanged: (index) {
          navigateWarehouseTab(context, index);
        },
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 24),
        children: [
          const _SectionHeader(title: 'ДТП / Инцидент'),
          const SizedBox(height: 10),
          AppCard(
            color: AppColors.primarySoft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Новый инцидент', style: AppTextStyles.cardTitle),
                SizedBox(height: 4),
                Text('Требует заполнения', style: AppTextStyles.caption),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const _SectionHeader(title: 'Адрес и время'),
          const SizedBox(height: 10),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Адрес', style: AppTextStyles.caption),
                const SizedBox(height: 8),
                TextField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Время события', style: AppTextStyles.caption),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'xx.xx.xxxx · --:--',
                    hintStyle: TextStyle(color: AppColors.muted),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const _SectionHeader(title: 'Степень инцидента'),
          const SizedBox(height: 10),
          AppCard(
            child: DropdownButtonFormField<String>(
              initialValue: _selectedSeverity,
              items: const [
                DropdownMenuItem(value: 'Легкая', child: Text('Легкая')),
                DropdownMenuItem(value: 'Средняя', child: Text('Средняя')),
                DropdownMenuItem(value: 'Тяжелая', child: Text('Тяжелая')),
              ],
              onChanged: (val) => setState(() => _selectedSeverity = val ?? 'Средняя'),
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          ),
          const SizedBox(height: 22),
          const _SectionHeader(title: 'Материалы'),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.image),
                  label: const Text('Фото'),
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
                  icon: const Icon(Icons.videocam),
                  label: const Text('Видео'),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.card,
                    foregroundColor: AppColors.text,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const _SectionHeader(title: 'Комментарий'),
          const SizedBox(height: 10),
          AppCard(
            child: TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Описание инцидента...',
                hintStyle: TextStyle(color: AppColors.muted),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const AppButton(label: 'Отправить'),
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
