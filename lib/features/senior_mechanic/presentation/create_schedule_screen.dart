import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_button.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:flutter/material.dart';

import 'senior_mechanic_home_screen.dart';

class CreateScheduleScreen extends StatefulWidget {
  const CreateScheduleScreen({super.key});

  @override
  State<CreateScheduleScreen> createState() => _CreateScheduleScreenState();
}

class _CreateScheduleScreenState extends State<CreateScheduleScreen> {
  final _dateFromController = TextEditingController();
  final _dateToController = TextEditingController();
  final _timeFromController = TextEditingController();
  final _timeToController = TextEditingController();
  final _repeatDaysController = TextEditingController();
  final _everyDaysController = TextEditingController();

  final _categories = {
    'Шины': false,
    'Капот': false,
    'Тормоза': false,
    'Свечи': false,
    'Колёса': false,
  };

  @override
  void dispose() {
    _dateFromController.dispose();
    _dateToController.dispose();
    _timeFromController.dispose();
    _timeToController.dispose();
    _repeatDaysController.dispose();
    _everyDaysController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      userName: 'Руслан Омарович',
      roleName: 'Старший механик',
      bottomNavigationBar: RoleBottomNav(
        items: seniorMechanicNavItems,
        currentIndex: 1,
        onChanged: (i) => navigateSeniorTab(context, i),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 32),
        children: [
          const Text('Создать График ТО',
              style: AppTextStyles.cardTitle),
          const SizedBox(height: 16),

          // Дата
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Дата', style: AppTextStyles.caption),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _dateFromController,
                        decoration: const InputDecoration(
                          hintText: '--.--.----',
                          labelText: 'С',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _dateToController,
                        decoration: const InputDecoration(
                          hintText: '--.--.----',
                          labelText: 'До',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Категории
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Категории', style: AppTextStyles.caption),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Выбрать',
                          style: TextStyle(fontSize: 13)),
                    ),
                  ],
                ),
                ..._categories.entries.map((e) => CheckboxListTile(
                      title: Text(e.key, style: AppTextStyles.body),
                      value: e.value,
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      activeColor: AppColors.primary,
                      onChanged: (v) =>
                          setState(() => _categories[e.key] = v ?? false),
                    )),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Время
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Время', style: AppTextStyles.caption),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _timeFromController,
                        decoration: const InputDecoration(
                          hintText: '--:--',
                          labelText: 'С',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _timeToController,
                        decoration: const InputDecoration(
                          hintText: '--:--',
                          labelText: 'До',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: const [
                    Text('Длительность: ', style: AppTextStyles.caption),
                    Text('-- Минут', style: AppTextStyles.body),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Борты
          AppCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Борты', style: AppTextStyles.body),
                TextButton(
                  onPressed: () {},
                  child: const Text('Выбрать',
                      style: TextStyle(fontSize: 13)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Повтор
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Повтор', style: AppTextStyles.caption),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _repeatDaysController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: '---',
                          labelText: 'Подряд, дней',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _everyDaysController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: '---',
                          labelText: 'Каждые, дней',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          AppButton(label: 'Опубликовать', onPressed: () {}),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              side: const BorderSide(color: AppColors.primary),
            ),
            child: const Text('Сохранить как черновик'),
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
