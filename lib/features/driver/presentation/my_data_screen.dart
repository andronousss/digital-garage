import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:flutter/material.dart';

import 'driver_home_screen.dart';

class MyDataScreen extends StatelessWidget {
  const MyDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoleScaffold(
      userName: 'Руслан Омарович',
      roleName: 'Водитель',
      bottomNavigationBar: RoleBottomNav(
        items: driverNavItems,
        currentIndex: 2,
        onChanged: (index) {
          navigateDriverTab(context, index);
        },
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 24),
        children: [
          const _PersonalDataSection(),
          const SizedBox(height: 22),
          const _DocumentsSection(),
          const SizedBox(height: 22),
          const _AvailabilitySection(),
        ],
      ),
    );
  }
}

class _PersonalDataSection extends StatelessWidget {
  const _PersonalDataSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader(title: 'Мои данные'),
        const SizedBox(height: 10),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('ФИО', style: AppTextStyles.caption),
                  Text('Руслан Омарович', style: AppTextStyles.cardTitle),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Телефон', style: AppTextStyles.caption),
                  Text('+7 (707) 999-0077', style: AppTextStyles.cardTitle),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('ИИН', style: AppTextStyles.caption),
                  Text('123456789012', style: AppTextStyles.cardTitle),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DocumentsSection extends StatelessWidget {
  const _DocumentsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader(title: 'Документы'),
        const SizedBox(height: 10),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Удостоверение личности', style: AppTextStyles.caption),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Номер', style: AppTextStyles.caption),
                  Text('№1100001234', style: AppTextStyles.cardTitle),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Действует до', style: AppTextStyles.caption),
                  Text('20.10.2030', style: AppTextStyles.cardTitle),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Водительские права', style: AppTextStyles.caption),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Номер', style: AppTextStyles.caption),
                  Text('KZ-777-2026', style: AppTextStyles.cardTitle),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Категории', style: AppTextStyles.caption),
                  Text('B, C', style: AppTextStyles.cardTitle),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Действуют до', style: AppTextStyles.caption),
                  Text('25.06.2027', style: AppTextStyles.cardTitle),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Медсправка', style: AppTextStyles.caption),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Номер', style: AppTextStyles.caption),
                  Text('MED-2026-55', style: AppTextStyles.cardTitle),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Действует до', style: AppTextStyles.caption),
                  Text('25.03.2030', style: AppTextStyles.cardTitle),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AvailabilitySection extends StatelessWidget {
  const _AvailabilitySection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader(title: 'Доступность'),
        const SizedBox(height: 10),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Июнь 2026', style: AppTextStyles.cardTitle),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.line),
                ),
                child: const Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Пн', style: AppTextStyles.caption),
                        Text('Вт', style: AppTextStyles.caption),
                        Text('Ср', style: AppTextStyles.caption),
                        Text('Чт', style: AppTextStyles.caption),
                        Text('Пт', style: AppTextStyles.caption),
                        Text('Сб', style: AppTextStyles.caption),
                        Text('Вс', style: AppTextStyles.caption),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _DayIndicator('15', isFree: true),
                        _DayIndicator('16', isFree: true),
                        _DayIndicator('17', isFree: true),
                        _DayIndicator('18', isFree: false),
                        _DayIndicator('19', isFree: false),
                        _DayIndicator('20', isFree: true),
                        _DayIndicator('21', isFree: true),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text('Быстрое действие', style: AppTextStyles.cardTitle),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'С',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'По',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DayIndicator extends StatelessWidget {
  const _DayIndicator(this.day, {required this.isFree});

  final String day;
  final bool isFree;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: isFree ? AppColors.successSoft : AppColors.primarySoft,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          day,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: isFree ? AppColors.success : AppColors.primary,
          ),
        ),
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
