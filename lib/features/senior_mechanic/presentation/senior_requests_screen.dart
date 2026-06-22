import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:digital_garage/shared/widgets/status_chip.dart';
import 'package:flutter/material.dart';

import 'senior_mechanic_home_screen.dart';

class SeniorRequestsScreen extends StatefulWidget {
  const SeniorRequestsScreen({super.key});

  @override
  State<SeniorRequestsScreen> createState() => _SeniorRequestsScreenState();
}

class _SeniorRequestsScreenState extends State<SeniorRequestsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Счётчики
                Row(
                  children: [
                    _CountBadge(
                        count: '1',
                        label: 'новые',
                        color: AppColors.primarySoft,
                        textColor: AppColors.primary),
                    const SizedBox(width: 8),
                    _CountBadge(
                        count: '4',
                        label: 'доработка',
                        color: AppColors.warningSoft,
                        textColor: AppColors.warning),
                    const SizedBox(width: 8),
                    _CountBadge(
                        count: '1',
                        label: 'на складе',
                        color: AppColors.successSoft,
                        textColor: AppColors.success),
                  ],
                ),
                const SizedBox(height: 12),
                // Поиск
                TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Поиск',
                    prefixIcon: Icon(Icons.search, size: 18),
                    suffixIcon: Icon(Icons.filter_list, size: 18),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

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
                  fontSize: 12, fontWeight: FontWeight.w700),
              unselectedLabelStyle: const TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w600),
              labelColor: AppColors.text,
              unselectedLabelColor: AppColors.muted,
              tabs: const [
                Tab(text: 'Все'),
                Tab(text: 'Новые'),
                Tab(text: 'Доработка'),
                Tab(text: 'Одобрены'),
              ],
            ),
          ),
          const SizedBox(height: 12),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildRequestList(),
                _buildRequestList(filterStatus: 'Новая'),
                _buildRequestList(filterStatus: 'Доработка'),
                _buildRequestList(filterStatus: 'Одобрена'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestList({String? filterStatus}) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(14, 0, 14, 24),
      children: [
        if (filterStatus == null || filterStatus == 'Новая') ...[
          _RequestCard(
            num: '001',
            time: 'сегодня 09:44',
            status: 'Новая',
            bort: '55',
            reason: 'замена колеса',
            mechanic: 'Механик 1',
            detail: 'Колесо A',
            qty: '12 шт',
            action: 'Установка',
          ),
          const SizedBox(height: 10),
          _RequestCard(
            num: '002',
            time: 'сегодня 09:31',
            status: 'Новая',
            bort: '33',
            reason: 'ремонт защиты днища',
            mechanic: 'Механик 2',
            detail: 'Защита днища',
            qty: 'Фото 3',
            action: 'Замена',
          ),
        ],
        if (filterStatus == 'Доработка' || filterStatus == null)
          Padding(
            padding: EdgeInsets.only(
                top: filterStatus == null ? 10 : 0),
            child: const Center(
              child: Text('Нет заявок на доработку',
                  style: AppTextStyles.caption),
            ),
          ),
        if (filterStatus == 'Одобрена')
          const Center(
            child: Text('Нет одобренных заявок',
                style: AppTextStyles.caption),
          ),
      ],
    );
  }
}

class _CountBadge extends StatelessWidget {
  const _CountBadge({
    required this.count,
    required this.label,
    required this.color,
    required this.textColor,
  });

  final String count;
  final String label;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
                text: count,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: textColor)),
            TextSpan(
                text: ' $label',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: textColor)),
          ],
        ),
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  const _RequestCard({
    required this.num,
    required this.time,
    required this.status,
    required this.bort,
    required this.reason,
    required this.mechanic,
    required this.detail,
    required this.qty,
    required this.action,
  });

  final String num;
  final String time;
  final String status;
  final String bort;
  final String reason;
  final String mechanic;
  final String detail;
  final String qty;
  final String action;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('№$num · $time',
                  style: AppTextStyles.caption),
              StatusChip(
                label: status,
                backgroundColor: AppColors.primarySoft,
                foregroundColor: AppColors.primary,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text('Борт $bort · $reason',
              style: AppTextStyles.body
                  .copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),

          // Цепочка
          Row(
            children: [
              _ChainNode(label: mechanic),
              const _ChainArrow(),
              const _ChainNode(label: 'Ст. механик', isActive: true),
              const _ChainArrow(),
              const _ChainNode(label: 'Завсклад'),
            ],
          ),
          const SizedBox(height: 10),

          Row(
            children: [
              _TagChip(label: detail),
              const SizedBox(width: 6),
              _TagChip(label: qty),
              const SizedBox(width: 6),
              _TagChip(label: action),
            ],
          ),
          const SizedBox(height: 12),

          // Кнопки действий
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.success,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    textStyle: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                  onPressed: () {},
                  child: const Text('Одобрить'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.warning),
                    foregroundColor: AppColors.warning,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    textStyle: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                  onPressed: () {},
                  child: const Text('Доработка'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.danger),
                    foregroundColor: AppColors.danger,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    textStyle: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                  onPressed: () {},
                  child: const Text('Отклонить'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChainNode extends StatelessWidget {
  const _ChainNode({required this.label, this.isActive = false});
  final String label;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.field,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
            color: isActive ? AppColors.primary : AppColors.line),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: isActive ? Colors.white : AppColors.text,
        ),
      ),
    );
  }
}

class _ChainArrow extends StatelessWidget {
  const _ChainArrow();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Icon(Icons.arrow_forward, size: 14, color: AppColors.muted),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.field,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(label,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.text)),
    );
  }
}
