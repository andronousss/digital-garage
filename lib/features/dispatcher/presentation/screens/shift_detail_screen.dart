import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:flutter/material.dart';

import 'dispatcher_home_screen.dart';

class ShiftDetailScreen extends StatelessWidget {
  const ShiftDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      userName: 'Руслан Омаров',
      roleName: 'Диспетчер',
      bottomNavigationBar: RoleBottomNav(
        items: dispatcherNavItems,
        currentIndex: 2,
        onChanged: (index) {
          if (index != 2) {
            navigateDispatcherTab(context, index);
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
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFD6DBE1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.image_outlined, size: 40, color: Color(0xFF587096)),
                  const SizedBox(height: 8),
                  Text('Фото транспортного средства', style: AppTextStyles.caption.copyWith(color: const Color(0xFF587096))),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('Технические данные', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.text)),
            const SizedBox(height: 12),
            AppCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _TechDataRow('Бортовой номер', '753'),
                  _TechDataRow('Гос. номер', '049ED'),
                  _TechDataRow('VIN код', 'XTA21150089123'),
                  _TechDataRow('Марка / Модель', 'Hyundai H350'),
                  _TechDataRow('Год выпуска', '2022'),
                  _TechDataRow('Пробег', '142,400 км'),
                  _TechDataRow('Последнее ТО', '12.04.2026'),
                  _TechDataRow('Текущий водитель', 'Руслан Омарович', isLink: true),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('История статусов', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.text)),
            const SizedBox(height: 12),
            AppCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _TimelineItem(
                    title: 'Выход на линию',
                    time: 'Сегодня, 09:12',
                    subtitle: 'Маршрут №12A, водитель Р. Омарович',
                    color: AppColors.primary,
                    isFirst: true,
                  ),
                  _TimelineItem(
                    title: 'Завершено техническое ТО',
                    time: 'Вчера, 16:45',
                    subtitle: 'Плановое обслуживание, замена фильтров',
                    color: const Color(0xFF28A745),
                  ),
                  _TimelineItem(
                    title: 'Направлен на диагностику',
                    time: '10 июня, 11:00',
                    subtitle: 'Заявка по датчику давления масла',
                    color: const Color(0xFFF39C12),
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
}

class _TechDataRow extends StatelessWidget {
  const _TechDataRow(this.label, this.value, {this.isLink = false});
  final String label;
  final String value;
  final bool isLink;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.muted)),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: isLink ? AppColors.primary : AppColors.text,
            ),
          ),
        ],
      ),
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
                    children: [
                      Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.text)),
                      Text(time, style: const TextStyle(fontSize: 11, color: AppColors.muted)),
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
