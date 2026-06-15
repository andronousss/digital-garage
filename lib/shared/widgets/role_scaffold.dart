import 'package:digital_garage/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RoleScaffold extends StatelessWidget {
  const RoleScaffold({
    super.key,
    required this.userName,
    required this.roleName,
    required this.body,
    this.bottomNavigationBar,
  });

  static const maxMobileWidth = 430.0;

  final String userName;
  final String roleName;
  final Widget body;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Align(
        alignment: Alignment.topLeft,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: maxMobileWidth),
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                _RoleHeader(userName: userName, roleName: roleName),
                Expanded(child: body),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigationBar == null
          ? null
          : Align(
              alignment: Alignment.bottomLeft,
              heightFactor: 1,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: maxMobileWidth),
                child: bottomNavigationBar,
              ),
            ),
    );
  }
}

class _RoleHeader extends StatelessWidget {
  const _RoleHeader({required this.userName, required this.roleName});

  final String userName;
  final String roleName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      padding: const EdgeInsets.fromLTRB(16, 8, 6, 8),
      color: AppColors.header,
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$userName ·\n$roleName',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.text,
                fontSize: 16,
                height: 1.18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
            tooltip: 'Уведомления',
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Настройки',
          ),
        ],
      ),
    );
  }
}
