import 'package:digital_garage/features/auth/auth_dev_menu_screen.dart';
import 'package:digital_garage/features/dispatcher/presentation/screens/board_status_screen.dart';
import 'package:digital_garage/features/dispatcher/presentation/screens/dispatcher_home_screen.dart';
import 'package:digital_garage/features/dispatcher/presentation/screens/notifications_screen.dart';
import 'package:digital_garage/features/dispatcher/presentation/screens/profile_screen.dart';
import 'package:digital_garage/features/dispatcher/presentation/screens/shift_detail_screen.dart';
import 'package:digital_garage/features/dispatcher/presentation/screens/shifts_screen.dart';
import 'package:digital_garage/features/warehouse/presentation/activity_log_screen.dart';
import 'package:digital_garage/features/warehouse/presentation/inventory_detail_screen.dart';
import 'package:digital_garage/features/warehouse/presentation/inventory_screen.dart';
import 'package:digital_garage/features/warehouse/presentation/profile_screen.dart' as warehouse_profile;
import 'package:digital_garage/features/warehouse/presentation/request_detail_screen.dart';
import 'package:digital_garage/features/warehouse/presentation/requests_screen.dart';
import 'package:digital_garage/features/warehouse/presentation/warehouse_home_screen.dart';
import 'package:flutter/material.dart';

class DevMenuScreen extends StatelessWidget {
  const DevMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dev Panel: All Screens')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Склад (Warehouse)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _buildButton(context, 'Главная (Warehouse Home)', const WarehouseHomeScreen()),
          _buildButton(context, 'Заявки (Requests)', const RequestsScreen()),
          _buildButton(context, 'Форма обработки (Request Detail)', const RequestDetailScreen()),
          _buildButton(context, 'Остатки (Inventory)', const InventoryScreen()),
          _buildButton(context, 'Логистика (Inventory Detail)', const InventoryDetailScreen()),
          _buildButton(context, 'Системный журнал (Activity Log)', const ActivityLogScreen()),
          _buildButton(context, 'Профиль (Profile)', const warehouse_profile.ProfileScreen()),
          const Divider(height: 32),
          const Text('Диспетчер', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _buildButton(context, 'Главная (Dispatcher Home)', const DispatcherHomeScreen()),
          _buildButton(context, 'Смены (Shifts)', const ShiftsScreen()),
          _buildButton(context, 'Статус бортов (Board Status)', const BoardStatusScreen()),
          _buildButton(context, 'Детали борта (Board Detail)', const ShiftDetailScreen()),
          _buildButton(context, 'Уведомления (Notifications)', const NotificationsScreen()),
          _buildButton(context, 'Профиль (Profile)', const ProfileScreen()),
          const Divider(height: 32),
          const Text('Аутентификация', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _buildButton(context, 'Все экраны Auth', const AuthDevMenuScreen()),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String title, Widget screen) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => screen),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(title, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
