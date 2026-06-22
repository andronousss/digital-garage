import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_button.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:flutter/material.dart';

import 'senior_mechanic_home_screen.dart';
import 'create_schedule_screen.dart';

class SeniorScheduleScreen extends StatefulWidget {
  const SeniorScheduleScreen({super.key});

  @override
  State<SeniorScheduleScreen> createState() => _SeniorScheduleScreenState();
}

class _SeniorScheduleScreenState extends State<SeniorScheduleScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedWeekDay = 2; // среда

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
      body: Column(
        children: [
          // Создать график кнопка
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
            child: AppButton(
              label: 'Создать график',
              icon: Icons.add,
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const CreateScheduleScreen())),
            ),
          ),
          const SizedBox(height: 12),

          // Табы
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: AppColors.field,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.line),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelStyle: const TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w700),
              unselectedLabelStyle: const TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w600),
              labelColor: AppColors.text,
              unselectedLabelColor: AppColors.muted,
              tabs: const [
                Tab(text: 'Черновики'),
                Tab(text: 'Активные'),
                Tab(text: 'Запланир.'),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Мини-календарь (неделя)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (i) {
                const days = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
                const dates = ['23', '24', '25', '26', '27', '28', '29'];
                final isSelected = i == _selectedWeekDay;
                return GestureDetector(
                  onTap: () => setState(() => _selectedWeekDay = i),
                  child: Column(
                    children: [
                      Text(days[i],
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.muted)),
                      const SizedBox(height: 4),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(dates[i],
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: isSelected
                                      ? Colors.white
                                      : AppColors.text)),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 12),

          // Список графиков
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Черновики
                const Center(
                  child: Text('Черновиков нет',
                      style: AppTextStyles.caption),
                ),

                // Активные
                ListView(
                  padding: const EdgeInsets.fromLTRB(14, 0, 14, 24),
                  children: [
                    _ScheduleCard(
                      dateRange: '01.03.26 – 31.03.26',
                      timeRange: '13:00 – 16:00',
                      vehicles: 20,
                      categories: 9,
                      daysLeft: 13,
                      bortyList: '30, 31, 33, 40, 41, 44, 50, 55, 57',
                      categoryList: 'Шины, Капот, Свечи',
                      progress: 60,
                      progressColor: AppColors.primary,
                    ),
                    const SizedBox(height: 10),
                    _ScheduleCard(
                      dateRange: '01.03.26 – 31.03.26',
                      timeRange: '19:00 – 12:00',
                      vehicles: 10,
                      categories: 6,
                      daysLeft: 9,
                      bortyList: '58, 60, 62, 64, 67, 68',
                      categoryList: 'Шины',
                      progress: 80,
                      progressColor: AppColors.success,
                    ),
                  ],
                ),

                // Запланированные
                const Center(
                  child: Text('Нет запланированных',
                      style: AppTextStyles.caption),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ScheduleCard extends StatelessWidget {
  const _ScheduleCard({
    required this.dateRange,
    required this.timeRange,
    required this.vehicles,
    required this.categories,
    required this.daysLeft,
    required this.bortyList,
    required this.categoryList,
    required this.progress,
    required this.progressColor,
  });

  final String dateRange;
  final String timeRange;
  final int vehicles;
  final int categories;
  final int daysLeft;
  final String bortyList;
  final String categoryList;
  final int progress;
  final Color progressColor;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '$dateRange · $timeRange',
                  style: AppTextStyles.body
                      .copyWith(fontWeight: FontWeight.w800),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: progressColor == AppColors.success
                      ? AppColors.successSoft
                      : AppColors.primarySoft,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$progress%',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: progressColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _MetaBadge(label: '$vehicles', sub: 'бортов'),
              const SizedBox(width: 8),
              _MetaBadge(label: '$categories', sub: 'кат.'),
              const SizedBox(width: 8),
              _MetaBadge(label: '$daysLeft', sub: 'дней'),
            ],
          ),
          const SizedBox(height: 10),
          Text('Борты: $bortyList', style: AppTextStyles.caption),
          const SizedBox(height: 4),
          Text('Категории: $categoryList',
              style: AppTextStyles.caption),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress / 100,
              minHeight: 6,
              backgroundColor: AppColors.field,
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaBadge extends StatelessWidget {
  const _MetaBadge({required this.label, required this.sub});
  final String label;
  final String sub;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.field,
        borderRadius: BorderRadius.circular(6),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
                text: label,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: AppColors.text)),
            TextSpan(
                text: ' $sub',
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.muted)),
          ],
        ),
      ),
    );
  }
}
