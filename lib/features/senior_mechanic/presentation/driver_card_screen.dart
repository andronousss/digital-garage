import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:flutter/material.dart';

import 'senior_mechanic_home_screen.dart';
import 'drivers_list_screen.dart';

class DriverCardScreen extends StatelessWidget {
  const DriverCardScreen({super.key, required this.driver});

  final DriverSummary driver;

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
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 32),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(driver.name, style: AppTextStyles.cardTitle),
              TextButton.icon(
                icon: const Icon(Icons.edit_outlined, size: 16),
                label: const Text('Изменить'),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Основные данные
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _InfoRow(label: 'ФИО', value: driver.name),
                _InfoRow(
                    label: 'Телефон',
                    value: '+7 (707) 999 00 77'),
                _InfoRow(label: 'ИИН', value: driver.iin),
                const Divider(color: AppColors.line, height: 20),
                const Text('Удостоверение',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.muted)),
                const SizedBox(height: 6),
                _InfoRow(label: 'Номер', value: '012345678'),
                _InfoRow(
                    label: 'Срок',
                    value: '08.05.2017 – 08.05.2027'),
                const Divider(color: AppColors.line, height: 20),
                const Text('Водительское удостоверение',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.muted)),
                const SizedBox(height: 6),
                _InfoRow(label: 'Номер', value: '______'),
                _InfoRow(
                    label: 'Категории (B, C, D...)',
                    value: driver.rights),
                _InfoRow(
                    label: 'Дата выдачи',
                    value: '--.--.----'),
                _InfoRow(
                    label: 'Действительно до',
                    value: '--.--.----'),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Файлы удостоверений
          _DocumentBlock(
            title: 'Водительское удостоверение',
            entries: const [
              _DocEntry(
                  addedDate: '09.11.2017',
                  expiry: '10 лет'),
              _DocEntry(
                  addedDate: '20.04.2024',
                  expiry: '2 года'),
            ],
          ),
          const SizedBox(height: 12),

          // Страхование
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Страхование',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.muted)),
                const SizedBox(height: 8),
                _InfoRow(label: 'Полис', value: '1100001234'),
                _InfoRow(
                    label: 'Срок',
                    value: '25.03.2025 – 25.03.2026'),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Смотреть историю'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Техосмотр
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Техосмотр',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.muted)),
                const SizedBox(height: 8),
                _InfoRow(label: 'Номер', value: 'A1234567'),
                _InfoRow(
                    label: 'Срок',
                    value: '25.06.2025 – 25.06.2026'),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Смотреть историю'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Водители борта
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Водители',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.muted)),
                SizedBox(height: 8),
                _InfoRow(label: 'Водитель 1', value: 'Руслан Омарович'),
                _InfoRow(label: 'Водитель 2', value: 'Руслан Омарович'),
                _InfoRow(label: 'Водитель 3', value: 'Руслан Омарович'),
                _InfoRow(label: 'Водитель 4', value: '___'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 160,
            child: Text(label, style: AppTextStyles.caption),
          ),
          Expanded(
            child: Text(value,
                style: AppTextStyles.body
                    .copyWith(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}

class _DocumentBlock extends StatelessWidget {
  const _DocumentBlock({
    required this.title,
    required this.entries,
  });

  final String title;
  final List<_DocEntry> entries;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.muted)),
          const SizedBox(height: 8),
          ...entries.map((e) => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Дата получения',
                              style: AppTextStyles.caption),
                          Text(e.addedDate,
                              style: AppTextStyles.body),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Срок действия',
                              style: AppTextStyles.caption),
                          Text(e.expiry,
                              style: AppTextStyles.body),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child:
                              const Text('Добавить файл')),
                      TextButton(
                          onPressed: () {},
                          child: const Text('Смотреть историю')),
                    ],
                  ),
                  if (entries.last != e)
                    const Divider(color: AppColors.line),
                ],
              )),
        ],
      ),
    );
  }
}

class _DocEntry {
  const _DocEntry({required this.addedDate, required this.expiry});
  final String addedDate;
  final String expiry;

  @override
  bool operator ==(Object other) =>
      other is _DocEntry &&
      other.addedDate == addedDate &&
      other.expiry == expiry;

  @override
  int get hashCode => Object.hash(addedDate, expiry);
}
