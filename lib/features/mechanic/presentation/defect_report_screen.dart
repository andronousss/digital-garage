import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_button.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'mechanic_form_providers.dart';
import 'mechanic_schedule_screen.dart';

class DefectReportScreen extends ConsumerStatefulWidget {
  const DefectReportScreen({super.key});

  @override
  ConsumerState<DefectReportScreen> createState() => _DefectReportScreenState();
}

class _DefectReportScreenState extends ConsumerState<DefectReportScreen> {
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _descriptionController =
        TextEditingController(text: ref.read(defectDescriptionProvider));
    _descriptionController.addListener(() {
      ref.read(defectDescriptionProvider.notifier).state =
          _descriptionController.text;
    });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final photoAttached = ref.watch(defectPhotoAttachedProvider);

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
                    Icon(
                      photoAttached ? Icons.check_circle_outline : Icons.image_outlined,
                      size: 40,
                      color: photoAttached ? AppColors.success : AppColors.muted,
                    ),
                    const SizedBox(height: 8),
                    if (photoAttached)
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text('Фото прикреплено', style: AppTextStyles.caption),
                      ),
                    ElevatedButton.icon(
                      icon: Icon(photoAttached ? Icons.refresh : Icons.add_a_photo),
                      label: Text(photoAttached ? 'Заменить фото' : 'Сделать фото'),
                      onPressed: () {
                        ref.read(defectPhotoAttachedProvider.notifier).state = true;
                      },
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
          AppButton(
            label: 'Отправить дефект',
            onPressed: () {
              final description = ref.read(defectDescriptionProvider);
              final hasPhoto = ref.read(defectPhotoAttachedProvider);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    hasPhoto
                        ? 'Дефект отправлен: ${description.isEmpty ? 'без описания' : description}'
                        : 'Сначала добавьте фото дефекта',
                  ),
                ),
              );
            },
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
