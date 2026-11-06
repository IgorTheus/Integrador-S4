import 'package:flutter/material.dart';
import 'package:integrador_s4/src/ui/_core/appbar.dart';
import "package:integrador_s4/src/ui/_core/navbar.dart";
import 'package:integrador_s4/src/ui/widgets/dashboard/dashboardScreen.dart';
import 'package:integrador_s4/src/ui/widgets/historic/historicScreen.dart';
import 'package:integrador_s4/src/ui/widgets/ra/raScreen.dart';
import 'package:integrador_s4/src/ui/widgets/scan/scanScreen.dart';

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
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => DashboardScreen()));
        break;
      case NavItem.historico:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => HistoricScreen()));
        break;
      case NavItem.home:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
        break;
      case NavItem.qrcode:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => ScanScreen()));
        break;
      case NavItem.ra:
        Navigator.push(context, MaterialPageRoute(builder: (_) => RaScreen()));
        break;
    }
  }

  void _scanQrCode() {
    // Navigator.push para a tela de scan (lib/ui/widgets/scan/scan.dart))
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
      bottomNavigationBar: MainNavBar(currentItem: _currentItem),
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
            Transform.scale(
              scale: 1.3,
              child: Image.asset(
                'assets/qrcodehd.png',
                width: 90,
                height: 90,
              ),
            ),
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
