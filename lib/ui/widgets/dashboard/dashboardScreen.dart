import 'package:flutter/material.dart';
import '../../_core/appbar.dart';
import '../../_core/navbar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MainAppBar(userName: 'usuário'),
      body: const Center(child: Text('Dashboard')),
      bottomNavigationBar: const MainNavBar(currentItem: NavItem.dashboard),
    );
  }
}