import 'package:flutter/material.dart';
import '../../_core/appbar.dart';
import '../../_core/navbar.dart';

class HistoricoScreen extends StatelessWidget {
  const HistoricoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MainAppBar(userName: 'usuário'),
      body: const Center(child: Text('Histórico s/ movimentação')),
      bottomNavigationBar: const MainNavBar(currentItem: NavItem.historico),
    );
  }
}