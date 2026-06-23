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
  static const _tabs = ['Активные', 'Черновики', 'Запланированные', 'Предыдущие'];

  final ScrollController _tabsController = ScrollController();

  int _selectedTab = 0;
  DateTime _selectedDay = DateTime.now();
  late DateTime _weekStart;
  DateTime _filterFrom = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime _filterTo = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);

  static final List<_ScheduleItem> _allItems = [
    _ScheduleItem(
      status: _ScheduleStatus.active,
      from: DateTime(2026, 3, 1),
      to: DateTime(2026, 3, 31),
      timeRange: '13:00  -  16:00',
      vehicles: 20,
      categories: 9,
      days: 13,
      borty: ['30', '31', '33', '40', '41', '44', '50', '55', '57'],
      categoriesList: ['Шины', 'Капот', 'Свечи'],
      progress: 60,
    ),
    _ScheduleItem(
      status: _ScheduleStatus.active,
      from: DateTime(2026, 3, 1),
      to: DateTime(2026, 3, 31),
      timeRange: '19:00  -  12:00',
      vehicles: 10,
      categories: 6,
      days: 9,
      borty: ['58', '60', '62', '64', '67', '68'],
      categoriesList: ['Шины'],
      progress: 80,
    ),
    _ScheduleItem(
      status: _ScheduleStatus.draft,
      from: DateTime(2026, 4, 1),
      to: DateTime(2026, 4, 15),
      timeRange: '10:00  -  13:00',
      vehicles: 6,
      categories: 4,
      days: 6,
      borty: ['33', '35', '36'],
      categoriesList: ['Шины', 'Капот'],
      progress: 25,
    ),
    _ScheduleItem(
      status: _ScheduleStatus.planned,
      from: DateTime(2026, 5, 1),
      to: DateTime(2026, 5, 31),
      timeRange: '09:00  -  12:00',
      vehicles: 12,
      categories: 5,
      days: 10,
      borty: ['41', '44', '50'],
      categoriesList: ['Свечи', 'Капот'],
      progress: 0,
    ),
    _ScheduleItem(
      status: _ScheduleStatus.previous,
      from: DateTime(2026, 2, 1),
      to: DateTime(2026, 2, 28),
      timeRange: '14:00  -  17:00',
      vehicles: 14,
      categories: 8,
      days: 11,
      borty: ['22', '24', '26', '28'],
      categoriesList: ['Шины', 'Тормоза'],
      progress: 100,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day);
    _weekStart = _mondayOf(_selectedDay);
  }

  @override
  void dispose() {
    _tabsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = _filteredItems();

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
                    fontSize: 18,
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 38,
            child: ListView.separated(
              controller: _tabsController,
              scrollDirection: Axis.horizontal,
              itemCount: _tabs.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final selected = _selectedTab == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedTab = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 140),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: selected ? Colors.white : const Color(0xFFE4EAF3),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: selected ? const Color(0xFFD4DDEB) : Colors.transparent,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _tabs[index],
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: selected ? AppColors.primary : const Color(0xFF8DA0BC),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _FilterDateTile(
                  label: 'С',
                  value: _formatDate(_filterFrom),
                  onTap: () => _pickFilterDate(from: true),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _FilterDateTile(
                  label: 'По',
                  value: _formatDate(_filterTo),
                  onTap: () => _pickFilterDate(from: false),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              IconButton(
                onPressed: () => _moveWeek(-1),
                icon: const Icon(Icons.arrow_left, size: 18, color: Color(0xFF707070)),
                visualDensity: VisualDensity.compact,
              ),
              Expanded(
                child: Container(
                  height: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF777777),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              IconButton(
                onPressed: () => _moveWeek(1),
                icon: const Icon(Icons.arrow_right, size: 18, color: Color(0xFF707070)),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
          const SizedBox(height: 7),
          Row(
            children: [
              ...List.generate(7, (index) {
                final day = _weekStart.add(Duration(days: index));
                final selected = _isSameDate(day, _selectedDay);
                final weekday = const ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'][index];

                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedDay = day),
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
                            weekday,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: selected ? Colors.white : const Color(0xFF93A3BB),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            day.day.toString(),
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
              GestureDetector(
                onTap: _pickCalendarDate,
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCE6F8),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: const Icon(Icons.calendar_month, size: 22, color: AppColors.primary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (items.isEmpty)
            Container(
              height: 140,
              alignment: Alignment.center,
              child: const Text(
                'Нет записей по выбранным фильтрам',
                style: TextStyle(color: Color(0xFF8396B3), fontWeight: FontWeight.w700),
              ),
            )
          else
            ...items.map(
              (card) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _ScheduleCard(item: card),
              ),
            ),
        ],
      ),
    );
  }

  List<_ScheduleItem> _filteredItems() {
    final status = _statusForTab(_selectedTab);

    return _allItems.where((item) {
      if (item.status != status) {
        return false;
      }

      if (_filterFrom.isAfter(item.to) || _filterTo.isBefore(item.from)) {
        return false;
      }

      return !_selectedDay.isBefore(item.from) && !_selectedDay.isAfter(item.to);
    }).toList();
  }

  _ScheduleStatus _statusForTab(int index) {
    switch (index) {
      case 0:
        return _ScheduleStatus.active;
      case 1:
        return _ScheduleStatus.draft;
      case 2:
        return _ScheduleStatus.planned;
      default:
        return _ScheduleStatus.previous;
    }
  }

  Future<void> _pickFilterDate({required bool from}) async {
    final current = from ? _filterFrom : _filterTo;
    final picked = await showDatePicker(
      context: context,
      initialDate: current,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
      locale: const Locale('ru'),
    );
    if (picked == null) {
      return;
    }

    setState(() {
      if (from) {
        _filterFrom = DateTime(picked.year, picked.month, picked.day);
        if (_filterFrom.isAfter(_filterTo)) {
          _filterTo = _filterFrom;
        }
      } else {
        _filterTo = DateTime(picked.year, picked.month, picked.day);
        if (_filterTo.isBefore(_filterFrom)) {
          _filterFrom = _filterTo;
        }
      }
    });
  }

  Future<void> _pickCalendarDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDay,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
      locale: const Locale('ru'),
    );
    if (picked == null) {
      return;
    }

    setState(() {
      _selectedDay = DateTime(picked.year, picked.month, picked.day);
      _weekStart = _mondayOf(_selectedDay);
    });
  }

  void _moveWeek(int diff) {
    setState(() {
      _weekStart = _weekStart.add(Duration(days: diff * 7));
      _selectedDay = _weekStart;
    });
  }
}

class _FilterDateTile extends StatelessWidget {
  const _FilterDateTile({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFEAF0FA),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Text(
              '$label: $value',
              style: const TextStyle(
                color: Color(0xFF4B5F80),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            const Icon(Icons.calendar_today, size: 14, color: Color(0xFF7288A9)),
          ],
        ),
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
                        '${_formatDate(item.from)}  -  ${_formatDate(item.to)}',
                        style: const TextStyle(
                          fontSize: 12,
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
                          fontSize: 12,
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
                      Text('${item.vehicles}', style: const TextStyle(fontSize: 13, color: Color(0xFF20345B))),
                      const SizedBox(width: 14),
                      const Icon(Icons.local_shipping_outlined, size: 15, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Text('${item.categories}', style: const TextStyle(fontSize: 13, color: Color(0xFF20345B))),
                      const SizedBox(width: 14),
                      const Icon(Icons.check_box, size: 15, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Text('${item.days} дней', style: const TextStyle(fontSize: 13, color: Color(0xFF20345B))),
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
                        style: TextStyle(fontSize: 14, color: Color(0xFF20345B)),
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
                              fontSize: 13,
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
                        style: TextStyle(fontSize: 14, color: Color(0xFF20345B)),
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
                              fontSize: 13,
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

enum _ScheduleStatus { active, draft, planned, previous }

class _ScheduleItem {
  const _ScheduleItem({
    required this.status,
    required this.from,
    required this.to,
    required this.timeRange,
    required this.vehicles,
    required this.categories,
    required this.days,
    required this.borty,
    required this.categoriesList,
    required this.progress,
  });

  final _ScheduleStatus status;
  final DateTime from;
  final DateTime to;
  final String timeRange;
  final int vehicles;
  final int categories;
  final int days;
  final List<String> borty;
  final List<String> categoriesList;
  final int progress;
}

DateTime _mondayOf(DateTime date) {
  final d = DateTime(date.year, date.month, date.day);
  return d.subtract(Duration(days: d.weekday - DateTime.monday));
}

bool _isSameDate(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

String _formatDate(DateTime date) {
  final d = date.day.toString().padLeft(2, '0');
  final m = date.month.toString().padLeft(2, '0');
  final y = (date.year % 100).toString().padLeft(2, '0');
  return '$d.$m.$y';
}
