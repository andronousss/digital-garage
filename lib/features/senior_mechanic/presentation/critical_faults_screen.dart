import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:digital_garage/shared/widgets/status_chip.dart';
import 'package:flutter/material.dart';

import 'senior_mechanic_home_screen.dart';

class CriticalFaultsScreen extends StatefulWidget {
  const CriticalFaultsScreen({super.key});

  @override
  State<CriticalFaultsScreen> createState() => _CriticalFaultsScreenState();
}

class _CriticalFaultsScreenState extends State<CriticalFaultsScreen> {
  final _dateController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

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
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        color: AppColors.text,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 24),
        children: [
          const Text('Критические неисправности',
              style: AppTextStyles.cardTitle),
          const SizedBox(height: 12),

          // Фильтр по дате
          TextField(
            controller: _dateController,
            decoration: const InputDecoration(
              hintText: '----.--.----',
              labelText: 'Дата',
              suffixIcon: Icon(Icons.calendar_today_outlined, size: 16),
            ),
          ),
          const SizedBox(height: 16),

          // Неисправность 1
          _FaultCard(
            bort: '41',
            bortStatus: 'на стоянке',
            description: 'Разбита передняя правая стойка',
            fullDescription: null,
            mechanic: 'Механик 1',
            attachments: 'См. 3 вложения',
            status: 'В работе',
            statusBg: AppColors.warningSoft,
            statusFg: AppColors.warning,
          ),
          const SizedBox(height: 10),

          // Неисправность 2 (развернутая)
          _FaultCard(
            bort: '33',
            bortStatus: 'на стоянке',
            description: 'Пробита защита днища',
            fullDescription:
                'Разбита передняя правая ступица и погнут рычаг, внутри требуется замена мотора в связи с тем, что при ударе о бордюр сорвало приводы, вырвало внутреннюю гранату и раскололо корпус коробки вместе с отливом блока цилиндров',
            mechanic: 'Механик 2',
            attachments: 'См. 1 вложение',
            status: 'Новая',
            statusBg: AppColors.primarySoft,
            statusFg: AppColors.primary,
          ),
        ],
      ),
    );
  }
}

class _FaultCard extends StatefulWidget {
  const _FaultCard({
    required this.bort,
    required this.bortStatus,
    required this.description,
    required this.fullDescription,
    required this.mechanic,
    required this.attachments,
    required this.status,
    required this.statusBg,
    required this.statusFg,
  });

  final String bort;
  final String bortStatus;
  final String description;
  final String? fullDescription;
  final String mechanic;
  final String attachments;
  final String status;
  final Color statusBg;
  final Color statusFg;

  @override
  State<_FaultCard> createState() => _FaultCardState();
}

class _FaultCardState extends State<_FaultCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Борт ${widget.bort} · ${widget.bortStatus}',
                      style: AppTextStyles.caption,
                    ),
                    const SizedBox(height: 4),
                    Text(widget.description,
                        style: AppTextStyles.body
                            .copyWith(fontWeight: FontWeight.w800)),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              StatusChip(
                label: widget.status,
                backgroundColor: widget.statusBg,
                foregroundColor: widget.statusFg,
              ),
            ],
          ),

          if (widget.fullDescription != null) ...[
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => setState(() => _expanded = !_expanded),
              child: Text(
                _expanded
                    ? widget.fullDescription!
                    : '${widget.fullDescription!.substring(0, widget.fullDescription!.length > 80 ? 80 : widget.fullDescription!.length)}...',
                style: AppTextStyles.body,
              ),
            ),
            if (!_expanded)
              TextButton(
                onPressed: () => setState(() => _expanded = true),
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                child: const Text('Читать полностью',
                    style: TextStyle(fontSize: 12)),
              ),
          ],

          const SizedBox(height: 10),

          // Механик + вложения
          Row(
            children: [
              const Icon(Icons.person_outline,
                  size: 14, color: AppColors.muted),
              const SizedBox(width: 4),
              Text(widget.mechanic, style: AppTextStyles.caption),
              const SizedBox(width: 12),
              const Icon(Icons.attach_file,
                  size: 14, color: AppColors.muted),
              const SizedBox(width: 4),
              Text(widget.attachments,
                  style: AppTextStyles.caption),
            ],
          ),
          const SizedBox(height: 12),

          // Кнопки
          Row(
            children: [
              if (widget.status == 'Новая')
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.warning,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      textStyle: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w700),
                    ),
                    onPressed: () {},
                    child: const Text('В работе'),
                  ),
                ),
              if (widget.status == 'В работе') ...[
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.danger,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      textStyle: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w700),
                    ),
                    onPressed: () {},
                    child: const Text('Закрыть'),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
