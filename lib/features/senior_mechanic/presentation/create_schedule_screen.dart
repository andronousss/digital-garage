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
  int _consecutiveDays = 0;
  int _everyDays = 0;
  bool _limitByTime = false;

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
                    fontSize: 34 / 2,
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
              children: const [
                Expanded(child: _InputTile(value: '--.--.----', icon: Icons.calendar_today)),
                SizedBox(width: 8),
                Expanded(child: _InputTile(value: '--.--.----', icon: Icons.calendar_today)),
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
                const Expanded(child: _DropdownTile(label: 'Дней')),
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
                const Expanded(child: _DropdownTile(label: 'Дней')),
              ],
            ),
          ),
          const SizedBox(height: 8),
          _InputBlock(
            child: Row(
              children: const [
                Expanded(child: _InputTile(value: 'С   --:--', icon: Icons.access_time_filled)),
                SizedBox(width: 8),
                Expanded(child: _InputTile(value: 'до   --:--', icon: Icons.access_time_filled)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          _InputBlock(
            title: 'Длительность:',
            child: Row(
              children: const [
                _SignPill(sign: '-'),
                SizedBox(width: 8),
                Expanded(child: _DropdownTile(label: 'Минут')),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const _InputBlock(
            title: 'Категории',
            child: _DropdownTile(label: 'Выбрать', isHint: true),
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
                const Text(
                  '-/-',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF9AA9C0),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const _InputBlock(
            title: 'Борты',
            child: _DropdownTile(label: 'Выбрать'),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Кол-во бортов: -',
              style: TextStyle(
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
                  onPressed: () {},
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
                  onPressed: () {},
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
  const _InputTile({required this.value, required this.icon});

  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class _DropdownTile extends StatelessWidget {
  const _DropdownTile({required this.label, this.isHint = false});

  final String label;
  final bool isHint;

  @override
  Widget build(BuildContext context) {
    return Container(
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
