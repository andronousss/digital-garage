import 'package:digital_garage/features/auth/auth_dev_menu_screen.dart';
import 'package:digital_garage/features/dispatcher/presentation/screens/board_status_screen.dart';
import 'package:digital_garage/features/dispatcher/presentation/screens/dispatcher_home_screen.dart';
import 'package:digital_garage/features/dispatcher/presentation/screens/notifications_screen.dart';
import 'package:digital_garage/features/dispatcher/presentation/screens/profile_screen.dart';
import 'package:digital_garage/features/dispatcher/presentation/screens/shift_detail_screen.dart';
import 'package:digital_garage/features/dispatcher/presentation/screens/shifts_screen.dart';
import 'package:digital_garage/features/dispatcher/presentation/screens/waybill_list_screen.dart';
import 'package:digital_garage/features/dispatcher/presentation/screens/vehicle_details_screen.dart';
import 'package:digital_garage/features/driver/presentation/driver_home_screen.dart';
import 'package:digital_garage/features/driver/presentation/my_shift_screen.dart';
import 'package:digital_garage/features/driver/presentation/waybill_screen.dart';
import 'package:digital_garage/features/driver/presentation/my_data_screen.dart';
import 'package:digital_garage/features/mechanic/presentation/mechanic_home_screen.dart';
import 'package:digital_garage/features/mechanic/presentation/mechanic_schedule_screen.dart';
import 'package:digital_garage/features/mechanic/presentation/mechanic_requests_screen.dart';
import 'package:digital_garage/features/mechanic/presentation/mechanic_request_detail_screen.dart';
import 'package:digital_garage/features/mechanic/presentation/defect_report_screen.dart';
import 'package:digital_garage/features/mechanic/presentation/vehicle_passport_screen.dart';
import 'package:digital_garage/features/warehouse/presentation/activity_log_screen.dart';
import 'package:digital_garage/features/warehouse/presentation/incident_report_screen.dart';
import 'package:digital_garage/features/warehouse/presentation/inventory_detail_screen.dart';
import 'package:digital_garage/features/warehouse/presentation/inventory_screen.dart';
import 'package:digital_garage/features/warehouse/presentation/profile_screen.dart' as warehouse_profile;
import 'package:digital_garage/features/warehouse/presentation/request_detail_screen.dart';
import 'package:digital_garage/features/warehouse/presentation/requests_screen.dart';
import 'package:digital_garage/features/warehouse/presentation/warehouse_home_screen.dart';
import 'package:digital_garage/features/senior_mechanic/presentation/senior_mechanic_home_screen.dart';
import 'package:digital_garage/features/senior_mechanic/presentation/senior_schedule_screen.dart';
import 'package:digital_garage/features/senior_mechanic/presentation/create_schedule_screen.dart';
import 'package:digital_garage/features/senior_mechanic/presentation/senior_vehicles_screen.dart';
import 'package:digital_garage/features/senior_mechanic/presentation/drivers_list_screen.dart';
import 'package:digital_garage/features/senior_mechanic/presentation/senior_requests_screen.dart';
import 'package:digital_garage/features/senior_mechanic/presentation/critical_faults_screen.dart';
import 'package:digital_garage/features/senior_mechanic/presentation/dtp_list_screen.dart';
import 'package:digital_garage/features/senior_mechanic/presentation/add_dtp_screen.dart';
import 'package:digital_garage/features/senior_mechanic/presentation/senior_mechanic_profile_screen.dart';
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
          const Text('Водитель (Driver)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _buildButton(context, 'Главная (Driver Home)', const DriverHomeScreen()),
          _buildButton(context, 'Моя смена (My Shift)', const MyShiftScreen()),
          _buildButton(context, 'Путевой лист (Waybill)', const WaybillScreen()),
          _buildButton(context, 'Мои данные (My Data)', const MyDataScreen()),
          const Divider(height: 32),
          const Text('Механик (Mechanic)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _buildButton(context, 'Главная (Mechanic Home)', const MechanicHomeScreen()),
          _buildButton(context, 'График ТО (Schedule)', const MechanicScheduleScreen()),
          _buildButton(context, 'Мои заявки (Requests)', const MechanicRequestsScreen()),
          _buildButton(context, 'Форма заявки (Request Detail)', const MechanicRequestDetailScreen()),
          _buildButton(context, 'Дефект (Defect Report)', const DefectReportScreen()),
          _buildButton(context, 'Паспорт борта (Vehicle Passport)', const VehiclePassportScreen()),
          const Divider(height: 32),
          const Text('Склад (Warehouse)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _buildButton(context, 'Главная (Warehouse Home)', const WarehouseHomeScreen()),
          _buildButton(context, 'Заявки (Requests)', const RequestsScreen()),
          _buildButton(context, 'Форма обработки (Request Detail)', const RequestDetailScreen()),
          _buildButton(context, 'Остатки (Inventory)', const InventoryScreen()),
          _buildButton(context, 'Логистика (Inventory Detail)', const InventoryDetailScreen()),
          _buildButton(context, 'Системный журнал (Activity Log)', const ActivityLogScreen()),
          _buildButton(context, 'ДТП / Инцидент (Incident Report)', const IncidentReportScreen()),
          _buildButton(context, 'Профиль (Profile)', const warehouse_profile.ProfileScreen()),
          const Divider(height: 32),
          const Text('Диспетчер (Dispatcher)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _buildButton(context, 'Главная (Dispatcher Home)', const DispatcherHomeScreen()),
          _buildButton(context, 'Смены (Shifts)', const ShiftsScreen()),
          _buildButton(context, 'Статус бортов (Board Status)', const BoardStatusScreen()),
          _buildButton(context, 'Детали борта (Board Detail)', const ShiftDetailScreen()),
          _buildButton(context, 'Путевые листы (Waybill List)', const WaybillListScreen()),
          _buildButton(context, 'Детали борта (Vehicle Details)', const VehicleDetailsScreen()),
          _buildButton(context, 'Уведомления (Notifications)', const NotificationsScreen()),
          _buildButton(context, 'Профиль (Profile)', const ProfileScreen()),
          const Divider(height: 32),
          const Text('Аутентификация (Auth)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _buildButton(context, 'Все экраны Auth', const AuthDevMenuScreen()),
          const Divider(height: 32),
          const Text('Старший механик (Senior Mechanic)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _buildButton(context, 'Главная (Senior Mechanic Home)', const SeniorMechanicHomeScreen()),
          _buildButton(context, 'График ТО (Senior Schedule)', const SeniorScheduleScreen()),
          _buildButton(context, 'Создать График ТО (Create Schedule)', const CreateScheduleScreen()),
          _buildButton(context, 'Борты (Senior Vehicles)', const SeniorVehiclesScreen()),
          _buildButton(context, 'Список водителей (Drivers List)', const DriversListScreen()),
          _buildButton(context, 'Заявки (Senior Requests)', const SeniorRequestsScreen()),
          _buildButton(context, 'Критические неисправности (Critical Faults)', const CriticalFaultsScreen()),
          _buildButton(context, 'ДТП (DTP List)', const DtpListScreen()),
          _buildButton(context, 'Добавить ДТП (Add DTP)', const AddDtpScreen()),
          _buildButton(context, 'Таблица норм (Fuel Norms)', const FuelNormsScreen()),
          _buildButton(context, 'Профиль (Senior Mechanic Profile)', const SeniorMechanicProfileScreen()),
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
