import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_button.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:flutter/material.dart';

import 'senior_mechanic_home_screen.dart';

class AddDtpScreen extends StatefulWidget {
  const AddDtpScreen({super.key});

  @override
  State<AddDtpScreen> createState() => _AddDtpScreenState();
}

class _AddDtpScreenState extends State<AddDtpScreen> {
  final _govNumController = TextEditingController();
  final _dateTimeController = TextEditingController();
  final _addressController = TextEditingController(
      text: 'Ахмет Байтұрсынова 14');
  final _commentController = TextEditingController(
      text:
          'Создано из инцидента водителя. Нужна проверка повреждений.');

  bool _modeParking = true;
  bool _modeWork = false;

  @override
  void initState() {
    super.initState();
    _govNumController.text = '049ED';
    _dateTimeController.text = '06.10.2025 16:47';
  }

  @override
  void dispose() {
    _govNumController.dispose();
    _dateTimeController.dispose();
    _addressController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      userName: 'Руслан Омарович',
      roleName: 'Старший механик',
      bottomNavigationBar: RoleBottomNav(
        items: seniorMechanicNavItems,
        currentIndex: 0,
        onChanged: (i) => navigateSeniorTab(context, i),
      ),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        color: AppColors.text,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 32),
        children: [
          const Text('Добавить ДТП', style: AppTextStyles.cardTitle),
          const SizedBox(height: 16),

          // Путевой лист
          AppCard(
            color: AppColors.primarySoft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Путевой лист', style: AppTextStyles.caption),
                SizedBox(height: 4),
                Text('№6543 · Борт 55 · Руслан Омарович',
                    style: AppTextStyles.body),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Гос. номер и дата/время
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _govNumController,
                  decoration: const InputDecoration(
                    labelText: 'Гос. номер',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: _dateTimeController,
                  decoration: const InputDecoration(
                    labelText: 'Дата и время',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Режим борта
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Режим борта',
                    style: AppTextStyles.caption),
                const SizedBox(height: 10),
                CheckboxListTile(
                  title: const Text('На стоянку',
                      style: AppTextStyles.body),
                  value: _modeParking,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  activeColor: AppColors.primary,
                  onChanged: (v) =>
                      setState(() => _modeParking = v ?? false),
                ),
                CheckboxListTile(
                  title: const Text('ДТП · в работе',
                      style: AppTextStyles.body),
                  value: _modeWork,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  activeColor: AppColors.primary,
                  onChanged: (v) =>
                      setState(() => _modeWork = v ?? false),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.warningSoft,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'На стоянке борт станет недоступен для новых путевых.',
                    style: TextStyle(
                        fontSize: 12,
                        color: AppColors.warning,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Адрес
          TextFormField(
            controller: _addressController,
            decoration: const InputDecoration(
              labelText: 'Адрес',
            ),
          ),
          const SizedBox(height: 12),

          // Комментарий
          TextFormField(
            controller: _commentController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Комментарий',
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 12),

          // Добавить фото/видео
          OutlinedButton.icon(
            icon: const Icon(Icons.attach_file, size: 16),
            label: const Text('Добавить Фото/Видео'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              side: const BorderSide(color: AppColors.line),
              foregroundColor: AppColors.text,
            ),
            onPressed: () {},
          ),
          const SizedBox(height: 24),

          // Кнопки
          AppButton(
            label: 'Сохранить (На рассмотрении)',
            onPressed: () {},
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              side: const BorderSide(color: AppColors.muted),
              foregroundColor: AppColors.muted,
            ),
            child: const Text('Отмена'),
          ),
        ],
      ),
    );
  }
}
