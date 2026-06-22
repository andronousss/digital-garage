import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:digital_garage/core/theme/app_text_styles.dart';
import 'package:digital_garage/shared/widgets/app_card.dart';
import 'package:digital_garage/shared/widgets/role_bottom_nav.dart';
import 'package:digital_garage/shared/widgets/role_scaffold.dart';
import 'package:digital_garage/shared/widgets/status_chip.dart';
import 'package:flutter/material.dart';

import 'senior_mechanic_home_screen.dart';
import 'add_dtp_screen.dart';

class DtpListScreen extends StatefulWidget {
  const DtpListScreen({super.key});

  @override
  State<DtpListScreen> createState() => _DtpListScreenState();
}

class _DtpListScreenState extends State<DtpListScreen> {
  final _searchController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
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
          // Заголовок + добавить
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('ДТП', style: AppTextStyles.cardTitle),
              FilledButton.icon(
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Добавить ДТП',
                    style: TextStyle(fontSize: 13)),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const AddDtpScreen()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Поиск + дата
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Поиск',
                    prefixIcon: Icon(Icons.search, size: 18),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 130,
                child: TextField(
                  controller: _dateController,
                  decoration: const InputDecoration(
                    hintText: '----.--.----',
                    suffixIcon: Icon(
                        Icons.calendar_today_outlined,
                        size: 16),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // ДТП-001
          _DtpCard(
            id: 'ДТП-001',
            source: 'Путевой №6543',
            bort: '55',
            address: 'Ахмет Байтұрсынова 14',
            time: '06.10.2025 16:47',
            mode: 'В работе',
            modeBg: AppColors.warningSoft,
            modeFg: AppColors.warning,
            chain: const ['Водитель 1', 'Инцидент', 'ДТП'],
            photos: null,
            videos: null,
            note: null,
          ),
          const SizedBox(height: 10),

          // ДТП-002
          _DtpCard(
            id: 'ДТП-002',
            source: 'из инцидента водителя',
            bort: '33',
            address: 'Любое столкновение',
            time: '21.03.2026 09:44',
            mode: 'На стоянку',
            modeBg: AppColors.dangerSoft,
            modeFg: AppColors.danger,
            chain: const [],
            photos: 4,
            videos: 1,
            note: 'Осмотр нужен',
          ),
        ],
      ),
    );
  }
}

class _DtpCard extends StatelessWidget {
  const _DtpCard({
    required this.id,
    required this.source,
    required this.bort,
    required this.address,
    required this.time,
    required this.mode,
    required this.modeBg,
    required this.modeFg,
    required this.chain,
    required this.photos,
    required this.videos,
    required this.note,
  });

  final String id;
  final String source;
  final String bort;
  final String address;
  final String time;
  final String mode;
  final Color modeBg;
  final Color modeFg;
  final List<String> chain;
  final int? photos;
  final int? videos;
  final String? note;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$id · $source',
                      style: AppTextStyles.caption),
                  Text('Борт $bort · $address',
                      style: AppTextStyles.body
                          .copyWith(fontWeight: FontWeight.w800)),
                ],
              ),
              StatusChip(
                  label: mode,
                  backgroundColor: modeBg,
                  foregroundColor: modeFg),
            ],
          ),
          const SizedBox(height: 8),

          Row(
            children: [
              const Icon(Icons.access_time_outlined,
                  size: 13, color: AppColors.muted),
              const SizedBox(width: 4),
              Text('Время: $time',
                  style: AppTextStyles.caption),
            ],
          ),
          const SizedBox(height: 4),

          // Цепочка
          if (chain.isNotEmpty) ...[
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: [
                for (int i = 0; i < chain.length; i++) ...[
                  _ChainItem(label: chain[i]),
                  if (i < chain.length - 1)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      child: Icon(Icons.arrow_forward,
                          size: 13, color: AppColors.muted),
                    ),
                ],
              ],
            ),
            const SizedBox(height: 4),
          ],

          // Фото/видео
          if (photos != null || videos != null)
            Row(
              children: [
                if (photos != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text('Фото $photos',
                        style: AppTextStyles.caption),
                  ),
                if (videos != null)
                  Text('Видео $videos',
                      style: AppTextStyles.caption),
              ],
            ),

          // Примечание
          if (note != null) ...[
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.warningSoft,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(note!,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.warning)),
            ),
          ],
        ],
      ),
    );
  }
}

class _ChainItem extends StatelessWidget {
  const _ChainItem({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.field,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(label,
          style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.text)),
    );
  }
}
