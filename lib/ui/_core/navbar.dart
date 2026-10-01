import 'package:flutter/material.dart';
import '../widgets/home/home_screen.dart';
import '../widgets/scan/scanScreen.dart';
import '../widgets/dashboard/dashboardScreen.dart';
import '../widgets/historic/historicScreen.dart';
import '../widgets/ra/raScreen.dart';

enum NavItem { dashboard, historico, home, qrcode, ra }

class MainNavBar extends StatelessWidget {
  const MainNavBar({
    super.key,
    required this.currentItem,
  });

  final NavItem currentItem;

  static const Color backgroundColor = Color(0xFFA9D3BB);

  static const _items = [
    (
      item: NavItem.dashboard,
      image: 'assets/dashboard.png',
      label: 'Dashboard'
    ),
    (
      item: NavItem.historico,
      image: 'assets/historico.png',
      label: 'Histórico'
    ),
    (item: NavItem.home, image: 'assets/home.png', label: 'Home'),
    (item: NavItem.qrcode, image: 'assets/qrcode.png', label: 'QRCode'),
    (item: NavItem.ra, image: 'assets/ra.png', label: 'RA'),
  ];

  void _navigate(BuildContext context, NavItem item) {
    if (item == currentItem) return; // já está nessa tela, não faz nada

    final Widget screen = switch (item) {
      NavItem.home => const HomeScreen(),
      NavItem.qrcode => const ScanScreen(),
      NavItem.dashboard => const DashboardScreen(),
      NavItem.historico => const HistoricoScreen(),
      NavItem.ra => const RaScreen(),
    };

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _items.map((entry) {
            final bool selected = entry.item == currentItem;
            final double scale = selected ? 1.15 : 1.0;

            return GestureDetector(
              onTap: () => _navigate(context, entry.item),
              behavior: HitTestBehavior.opaque,
              child: SizedBox(
                width: 45,
                height: 45,
                child: Center(
                  child: Transform.scale(
                    scale: scale,
                    child: Image.asset(
                      entry.image,
                      width: 35,
                      height: 35,
                      color: selected
                          ? Colors.black
                          : const Color.fromARGB(255, 71, 71, 71),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
