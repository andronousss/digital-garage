import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:flutter/material.dart';

import 'create_schedule_screen.dart';
import 'senior_mechanic_home_screen.dart';

class SeniorScheduleScreen extends StatefulWidget {
  const SeniorScheduleScreen({super.key});

  @override
  State<SeniorScheduleScreen> createState() => _SeniorScheduleScreenState();
}

class _SeniorScheduleScreenState extends State<SeniorScheduleScreen> {
  int _selectedTab = 1;
  int _selectedDay = 2;

  static const _tabLabels = ['Черновики', 'Активные', 'Запланирова'];
  static const _days = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
  static const _dates = ['23', '24', '25', '26', '27', '28', '29'];

  static const _cards = [
    _ScheduleItem(
      dateRange: '01.03.26  -  31.03.26',
      timeRange: '13:00  -  16:00',
      vehicles: 20,
      categories: 9,
      days: 13,
      borty: ['30', '31', '33', '40', '41', '44', '50', '55', '57'],
      categoriesList: ['Шины', 'Капот', 'Свечи'],
      progress: 60,
    ),
    _ScheduleItem(
      dateRange: '01.03.26  -  31.03.26',
      timeRange: '19:00  -  12:00',
      vehicles: 10,
      categories: 6,
      days: 9,
      borty: ['58', '60', '62', '64', '67', '68'],
      categoriesList: ['Шины'],
      progress: 80,
    ),
    _ScheduleItem(
      dateRange: '01.03.26  -  31.03.26',
      timeRange: '19:00  -  12:00',
      vehicles: 10,
      categories: 6,
      days: 9,
      borty: ['33', '35', '36'],
      categoriesList: ['Шины', 'Капот'],
      progress: 40,
    ),
  ];

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
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 16),
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => navigateSeniorTab(context, 0),
                icon: const Icon(Icons.undo, size: 20, color: AppColors.primary),
                visualDensity: VisualDensity.compact,
                splashRadius: 18,
              ),
              const SizedBox(width: 2),
              const Expanded(
                child: Text(
                  'График ТО',
                  style: TextStyle(
                    fontSize: 36 / 2,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
              ),
              FilledButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CreateScheduleScreen()),
                ),
                icon: const Icon(Icons.add_box_outlined, size: 16),
                label: const Text(
                  'Создать график',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(130, 34),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 38,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: const Color(0xFFE4EAF3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: List.generate(_tabLabels.length, (index) {
                final selected = _selectedTab == index;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedTab = index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: selected ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _tabLabels[index],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 28 / 2,
                          fontWeight: FontWeight.w700,
                          color: selected ? AppColors.primary : const Color(0xFF8DA0BC),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.arrow_left, size: 15, color: Color(0xFF707070)),
              Expanded(
                child: Container(
                  height: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF777777),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const Icon(Icons.arrow_right, size: 15, color: Color(0xFF707070)),
            ],
          ),
          const SizedBox(height: 7),
          Row(
            children: [
              ...List.generate(7, (index) {
                final selected = _selectedDay == index;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedDay = index),
                    child: Container(
                      margin: const EdgeInsets.only(right: 4),
                      height: 48,
                      decoration: BoxDecoration(
                        color: selected ? AppColors.primary : const Color(0xFFE8EDF5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _days[index],
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: selected ? Colors.white : const Color(0xFF93A3BB),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _dates[index],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: selected ? Colors.white : const Color(0xFF93A3BB),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFFDCE6F8),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: const Icon(Icons.calendar_month, size: 22, color: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (_selectedTab == 1)
            ..._cards.map((card) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _ScheduleCard(item: card),
                ))
          else
            Container(
              height: 160,
              alignment: Alignment.center,
              child: Text(
                _selectedTab == 0 ? 'Черновиков нет' : 'Нет запланированных',
                style: const TextStyle(
                  color: Color(0xFF8396B3),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ScheduleCard extends StatelessWidget {
  const _ScheduleCard({required this.item});

  final _ScheduleItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFD5D9E2)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_month, size: 17, color: AppColors.primary),
                      const SizedBox(width: 6),
                      Text(
                        item.dateRange,
                        style: const TextStyle(
                          fontSize: 15 / 1.2,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF20345B),
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.access_time_filled, size: 15, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Text(
                        item.timeRange,
                        style: const TextStyle(
                          fontSize: 15 / 1.2,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF20345B),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.access_time_filled, size: 15, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Text('${item.vehicles}', style: const TextStyle(fontSize: 16 / 1.2, color: Color(0xFF20345B))),
                      const SizedBox(width: 14),
                      const Icon(Icons.local_shipping_outlined, size: 15, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Text('${item.categories}', style: const TextStyle(fontSize: 16 / 1.2, color: Color(0xFF20345B))),
                      const SizedBox(width: 14),
                      const Icon(Icons.check_box, size: 15, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Text('${item.days} дней', style: const TextStyle(fontSize: 16 / 1.2, color: Color(0xFF20345B))),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Text(
                        'Борты:',
                        style: TextStyle(fontSize: 18 / 1.2, color: Color(0xFF20345B)),
                      ),
                      ...item.borty.map(
                        (value) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEAF2FF),
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontSize: 16 / 1.2,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Text(
                        'Категории:',
                        style: TextStyle(fontSize: 18 / 1.2, color: Color(0xFF20345B)),
                      ),
                      ...item.categoriesList.map(
                        (value) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEAF2FF),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontSize: 16 / 1.2,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 28,
              color: AppColors.primary,
              alignment: Alignment.center,
              child: Text(
                '${item.progress}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScheduleItem {
  const _ScheduleItem({
    required this.dateRange,
    required this.timeRange,
    required this.vehicles,
    required this.categories,
    required this.days,
    required this.borty,
    required this.categoriesList,
    required this.progress,
  });

  final String dateRange;
  final String timeRange;
  final int vehicles;
  final int categories;
  final int days;
  final List<String> borty;
  final List<String> categoriesList;
  final int progress;
}
