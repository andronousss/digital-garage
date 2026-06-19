import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_button.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:flutter/material.dart';

import 'driver_home_screen.dart';

class WaybillScreen extends StatefulWidget {
  const WaybillScreen({super.key});

  @override
  State<WaybillScreen> createState() => _WaybillScreenState();
}

class _WaybillScreenState extends State<WaybillScreen> {
  late TextEditingController _mileageStartController;
  late TextEditingController _mileageEndController;

  @override
  void initState() {
    super.initState();
    _mileageStartController = TextEditingController(text: '128 450');
    _mileageEndController = TextEditingController(text: '128 522');
  }

  @override
  void dispose() {
    _mileageStartController.dispose();
    _mileageEndController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      userName: 'Руслан Омарович',
      roleName: 'Водитель',
      bottomNavigationBar: RoleBottomNav(
        items: driverNavItems,
        currentIndex: 1,
        onChanged: (index) {
          navigateDriverTab(context, index);
        },
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 24),
        children: [
          const _WaybillHeaderCard(),
          const SizedBox(height: 22),
          const _SectionHeader(title: 'Информация путевого листа'),
          const SizedBox(height: 10),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Борт', style: AppTextStyles.caption),
                    Text('55 · 049ED', style: AppTextStyles.cardTitle),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Дата', style: AppTextStyles.caption),
                    Text('11.06.2026', style: AppTextStyles.cardTitle),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Смена', style: AppTextStyles.caption),
                    Text('09:00-18:00', style: AppTextStyles.cardTitle),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const _SectionHeader(title: 'Маршрут'),
          const SizedBox(height: 10),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Вызов', style: AppTextStyles.cardTitle),
                SizedBox(height: 8),
                Text('Склад №2 → Абая 18', style: AppTextStyles.caption),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const _SectionHeader(title: 'Пробег и топливо'),
          const SizedBox(height: 10),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Пробег на начало', style: AppTextStyles.caption),
                const SizedBox(height: 8),
                TextField(
                  controller: _mileageStartController,
                  decoration: InputDecoration(
                    hintText: 'км',
                    hintStyle: TextStyle(color: AppColors.muted),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Пробег на конец', style: AppTextStyles.caption),
                const SizedBox(height: 8),
                TextField(
                  controller: _mileageEndController,
                  decoration: InputDecoration(
                    hintText: 'км',
                    hintStyle: TextStyle(color: AppColors.muted),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Расход топлива', style: AppTextStyles.caption),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'л',
                    hintStyle: TextStyle(color: AppColors.muted),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const _SectionHeader(title: 'Подпись'),
          const SizedBox(height: 10),
          AppCard(
            color: AppColors.card,
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.line),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'Зона для подписи',
                  style: TextStyle(color: AppColors.muted, fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const AppButton(label: 'Сохранить путевой лист'),
        ],
      ),
    );
  }
}

class _WaybillHeaderCard extends StatelessWidget {
  const _WaybillHeaderCard();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: AppColors.primarySoft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Путевой лист №063368', style: AppTextStyles.cardTitle),
              Chip(
                label: Text('К заполнению'),
                backgroundColor: AppColors.primarySoft,
                labelStyle: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text('11.06.2026', style: AppTextStyles.caption),
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
