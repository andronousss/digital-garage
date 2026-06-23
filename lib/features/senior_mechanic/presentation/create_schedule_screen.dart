import 'package:digital_garage/core/theme/app_colors.dart';
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
  DateTime? _dateFrom;
  DateTime? _dateTo;
  TimeOfDay? _timeFrom;
  TimeOfDay? _timeTo;

  int _consecutiveDays = 0;
  int _everyDays = 0;
  int _durationMinutes = 0;
  bool _limitByTime = false;
  int _limitCurrent = 0;
  int _limitMax = 0;

  final Set<String> _selectedCategories = {};
  final Set<String> _selectedBorty = {};

  static const _dayUnits = ['Дней', 'Недель'];
  static const _minuteUnits = ['Минут', 'Часов'];
  static const _categories = ['Шины', 'Капот', 'Тормоза', 'Свечи', 'Колёса'];
  static const _borty = ['30', '31', '33', '40', '41', '44', '50', '55', '57'];

  String _consecutiveUnit = _dayUnits.first;
  String _everyUnit = _dayUnits.first;
  String _durationUnit = _minuteUnits.first;

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
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.undo, size: 20, color: AppColors.primary),
                visualDensity: VisualDensity.compact,
                splashRadius: 18,
              ),
              const SizedBox(width: 2),
              const Expanded(
                child: Text(
                  'Создать График ТО',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _InputBlock(
            title: 'Дата:',
            child: Row(
              children: [
                Expanded(
                  child: _InputTile(
                    value: _dateFrom == null ? '--.--.----' : _formatDate(_dateFrom!),
                    icon: Icons.calendar_today,
                    onTap: () => _pickDate(isFrom: true),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _InputTile(
                    value: _dateTo == null ? '--.--.----' : _formatDate(_dateTo!),
                    icon: Icons.calendar_today,
                    onTap: () => _pickDate(isFrom: false),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          _InputBlock(
            title: 'Подряд:',
            child: Row(
              children: [
                _StepperBox(
                  value: _consecutiveDays,
                  onMinus: () => setState(() {
                    if (_consecutiveDays > 0) _consecutiveDays--;
                  }),
                  onPlus: () => setState(() => _consecutiveDays++),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _DropdownTile(
                    label: _consecutiveUnit,
                    onTap: () => _pickOption(
                      title: 'Единицы',
                      options: _dayUnits,
                      current: _consecutiveUnit,
                      onSelected: (v) => setState(() => _consecutiveUnit = v),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          _InputBlock(
            title: 'Каждые:',
            child: Row(
              children: [
                _StepperBox(
                  value: _everyDays,
                  onMinus: () => setState(() {
                    if (_everyDays > 0) _everyDays--;
                  }),
                  onPlus: () => setState(() => _everyDays++),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _DropdownTile(
                    label: _everyUnit,
                    onTap: () => _pickOption(
                      title: 'Единицы',
                      options: _dayUnits,
                      current: _everyUnit,
                      onSelected: (v) => setState(() => _everyUnit = v),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          _InputBlock(
            child: Row(
              children: [
                Expanded(
                  child: _InputTile(
                    value: _timeFrom == null ? 'С   --:--' : 'С   ${_formatTime(_timeFrom!)}',
                    icon: Icons.access_time_filled,
                    onTap: () => _pickTime(isFrom: true),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _InputTile(
                    value: _timeTo == null ? 'до   --:--' : 'до   ${_formatTime(_timeTo!)}',
                    icon: Icons.access_time_filled,
                    onTap: () => _pickTime(isFrom: false),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          _InputBlock(
            title: 'Длительность:',
            child: Row(
              children: [
                _SignPill(sign: '-'),
                const SizedBox(width: 8),
                Expanded(
                  child: _DropdownTile(
                    label: _durationUnit,
                    onTap: () => _pickOption(
                      title: 'Единицы',
                      options: _minuteUnits,
                      current: _durationUnit,
                      onSelected: (v) => setState(() => _durationUnit = v),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                _StepperBox(
                  value: _durationMinutes,
                  onMinus: () => setState(() {
                    if (_durationMinutes > 0) _durationMinutes--;
                  }),
                  onPlus: () => setState(() => _durationMinutes++),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          _InputBlock(
            title: 'Категории',
            child: _DropdownTile(
              label: _selectedCategories.isEmpty
                  ? 'Выбрать'
                  : _selectedCategories.join(', '),
              isHint: _selectedCategories.isEmpty,
              onTap: _pickCategories,
            ),
          ),
          const SizedBox(height: 8),
          _InputBlock(
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Лимит бортов по времени:',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF9AA9C0),
                    ),
                  ),
                ),
                Checkbox(
                  value: _limitByTime,
                  onChanged: (v) => setState(() => _limitByTime = v ?? false),
                  activeColor: AppColors.primary,
                  visualDensity: VisualDensity.compact,
                ),
                Text(
                  '$_limitCurrent/$_limitMax',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF9AA9C0),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          _InputBlock(
            title: 'Борты',
            child: _DropdownTile(
              label: _selectedBorty.isEmpty ? 'Выбрать' : _selectedBorty.join(', '),
              isHint: _selectedBorty.isEmpty,
              onTap: _pickBorty,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Кол-во бортов: ${_selectedBorty.length}',
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF9AA9C0),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Сохранено как черновик')),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(0, 44),
                    side: const BorderSide(color: Color(0xFFD4DCE8)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    foregroundColor: AppColors.primary,
                  ),
                  child: const Text(
                    'Сохранить как\nчерновик',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('График опубликован')),
                    );
                  },
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(0, 44),
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Опубликовать',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Отмена',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDate({required bool isFrom}) async {
    final current = isFrom ? _dateFrom : _dateTo;
    final picked = await showDatePicker(
      context: context,
      initialDate: current ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
      locale: const Locale('ru'),
    );
    if (picked == null) {
      return;
    }

    setState(() {
      if (isFrom) {
        _dateFrom = picked;
        if (_dateTo != null && _dateTo!.isBefore(_dateFrom!)) {
          _dateTo = _dateFrom;
        }
      } else {
        _dateTo = picked;
        if (_dateFrom != null && _dateFrom!.isAfter(_dateTo!)) {
          _dateFrom = _dateTo;
        }
      }
    });
  }

  Future<void> _pickTime({required bool isFrom}) async {
    final current = isFrom ? _timeFrom : _timeTo;
    final picked = await showTimePicker(
      context: context,
      initialTime: current ?? const TimeOfDay(hour: 9, minute: 0),
      helpText: isFrom ? 'Выберите время начала' : 'Выберите время окончания',
    );
    if (picked == null) {
      return;
    }

    setState(() {
      if (isFrom) {
        _timeFrom = picked;
      } else {
        _timeTo = picked;
      }
    });
  }

  Future<void> _pickOption({
    required String title,
    required List<String> options,
    required String current,
    required ValueChanged<String> onSelected,
  }) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
              ),
              ...options.map(
                (item) => ListTile(
                  title: Text(item),
                  trailing: item == current
                      ? const Icon(Icons.check, color: AppColors.primary)
                      : null,
                  onTap: () => Navigator.pop(context, item),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (selected != null) {
      onSelected(selected);
    }
  }

  Future<void> _pickCategories() async {
    final picked = await _pickMulti('Категории', _categories, _selectedCategories);
    if (picked != null) {
      setState(() {
        _selectedCategories
          ..clear()
          ..addAll(picked);
      });
    }
  }

  Future<void> _pickBorty() async {
    final picked = await _pickMulti('Борты', _borty, _selectedBorty);
    if (picked != null) {
      setState(() {
        _selectedBorty
          ..clear()
          ..addAll(picked);
        _limitCurrent = _selectedBorty.length;
        if (_limitMax < _limitCurrent) {
          _limitMax = _limitCurrent;
        }
      });
    }
  }

  Future<Set<String>?> _pickMulti(String title, List<String> values, Set<String> initial) async {
    final local = {...initial};

    return showModalBottomSheet<Set<String>>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 18),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, local),
                          child: const Text('Готово'),
                        ),
                      ],
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 330),
                      child: ListView(
                        shrinkWrap: true,
                        children: values.map((value) {
                          final checked = local.contains(value);
                          return CheckboxListTile(
                            value: checked,
                            title: Text(value),
                            activeColor: AppColors.primary,
                            onChanged: (v) {
                              setSheetState(() {
                                if (v ?? false) {
                                  local.add(value);
                                } else {
                                  local.remove(value);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _InputBlock extends StatelessWidget {
  const _InputBlock({required this.child, this.title});

  final String? title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4F8),
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                title!,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF4F5E74),
                ),
              ),
            ),
          child,
        ],
      ),
    );
  }
}

class _InputTile extends StatelessWidget {
  const _InputTile({required this.value, required this.icon, required this.onTap});

  final String value;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(9),
        child: Ink(
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFFEAF0FA),
            borderRadius: BorderRadius.circular(9),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF8DA0BC),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(icon, size: 14, color: const Color(0xFF7288A9)),
            ],
          ),
        ),
      ),
    );
  }
}

class _DropdownTile extends StatelessWidget {
  const _DropdownTile({
    required this.label,
    required this.onTap,
    this.isHint = false,
  });

  final String label;
  final bool isHint;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(9),
        child: Ink(
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFFEAF0FA),
            borderRadius: BorderRadius.circular(9),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isHint ? const Color(0xFF9EB0C7) : const Color(0xFF4B5F80),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, size: 16, color: Color(0xFF6F84A5)),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignPill extends StatelessWidget {
  const _SignPill({required this.sign});

  final String sign;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFEAF0FA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        sign,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Color(0xFF7388A8),
        ),
      ),
    );
  }
}

class _StepperBox extends StatelessWidget {
  const _StepperBox({
    required this.value,
    required this.onMinus,
    required this.onPlus,
  });

  final int value;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: const Color(0xFFEAF0FA),
        borderRadius: BorderRadius.circular(9),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          _SignButton(sign: '-', onTap: onMinus),
          const SizedBox(width: 10),
          Text(
            '$value',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF516482),
            ),
          ),
          const SizedBox(width: 10),
          _SignButton(sign: '+', onTap: onPlus),
        ],
      ),
    );
  }
}

class _SignButton extends StatelessWidget {
  const _SignButton({required this.sign, required this.onTap});

  final String sign;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 20,
        height: 20,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFFDCE6F8),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          sign,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}

String _formatDate(DateTime date) {
  final d = date.day.toString().padLeft(2, '0');
  final m = date.month.toString().padLeft(2, '0');
  final y = (date.year % 100).toString().padLeft(2, '0');
  return '$d.$m.$y';
}

String _formatTime(TimeOfDay time) {
  final h = time.hour.toString().padLeft(2, '0');
  final m = time.minute.toString().padLeft(2, '0');
  return '$h:$m';
}
