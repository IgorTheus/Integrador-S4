import 'package:flutter/material.dart';
import 'package:integrador_s4/ui/_core/appbar.dart';
import "package:integrador_s4/ui/_core/navbar.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NavItem _currentItem = NavItem.home;

  static const Color _borderColor = Color(0xFFA9D3BB);

  void _onNavTap(NavItem item) {
    setState(() => _currentItem = item);

    switch (item) {
      case NavItem.dashboard:
        // TODO: Navigator.push para Dashboard
        break;
      case NavItem.historico:
        // TODO: Navigator.push para Histórico
        break;
      case NavItem.home:
        break;
      case NavItem.qrcode:
        _scanQrCode();
        break;
      case NavItem.ra:
        // TODO: Navigator.push para RA
        break;
    }
  }

  void _scanQrCode() {
    // TODO: Navigator.push para a tela de scan (lib/ui/widgets/scan/scan.dart)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MainAppBar(userName: 'usuário'),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            children: [
              _QrCodeCard(onTap: _scanQrCode, borderColor: _borderColor),
              const SizedBox(height: 20),
              _MenuButton(
                label: 'DASHBOARD',
                borderColor: _borderColor,
                onTap: () => _onNavTap(NavItem.dashboard),
              ),
              const SizedBox(height: 20),
              _MenuButton(
                label: 'HISTÓRICO',
                borderColor: _borderColor,
                onTap: () => _onNavTap(NavItem.historico),
              ),
              const SizedBox(height: 20),
              _MenuButton(
                label: 'RA',
                borderColor: _borderColor,
                onTap: () => _onNavTap(NavItem.ra),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MainNavBar(
        currentItem: _currentItem,
        onItemSelected: _onNavTap,
      ),
    );
  }
}

class _QrCodeCard extends StatelessWidget {
  const _QrCodeCard({required this.onTap, required this.borderColor});

  final VoidCallback onTap;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Column(
          children: [
            const Text(
              'QUER ACHAR UM ATIVO?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 16),
            const Icon(Icons.qr_code_2, size: 90, color: Colors.black87),
            const SizedBox(height: 16),
            const Text(
              'ESCANEAR QRCODE',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton({
    required this.label,
    required this.onTap,
    required this.borderColor,
  });

  final String label;
  final VoidCallback onTap;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
