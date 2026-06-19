import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_button.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:flutter/material.dart';

import 'mechanic_schedule_screen.dart';

class DefectReportScreen extends StatefulWidget {
  const DefectReportScreen({super.key});

  @override
  State<DefectReportScreen> createState() => _DefectReportScreenState();
}

class _DefectReportScreenState extends State<DefectReportScreen> {
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
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
          const _SectionHeader(title: 'Дефект'),
          const SizedBox(height: 10),
          AppCard(
            color: AppColors.primarySoft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Борт 55 · Hyundai H 350', style: AppTextStyles.cardTitle),
                SizedBox(height: 4),
                Text('Гос. номер: 435ED', style: AppTextStyles.caption),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const _SectionHeader(title: 'Фото дефекта'),
          const SizedBox(height: 10),
          AppCard(
            color: AppColors.card,
            child: Container(
              height: 140,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.line, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.image_outlined, size: 40, color: AppColors.muted),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add_a_photo),
                      label: const Text('Сделать фото'),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 22),
          const _SectionHeader(title: 'Описание'),
          const SizedBox(height: 10),
          AppCard(
            child: TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Описание дефекта...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const AppButton(label: 'Отправить дефект'),
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
