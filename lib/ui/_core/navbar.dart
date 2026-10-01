import 'package:flutter/material.dart';
import "package:integrador_s4/ui/widgets/scan/scanScreen.dart";

enum NavItem { dashboard, historico, home, qrcode, ra }

class MainNavBar extends StatelessWidget {
  const MainNavBar({
    super.key,
    required this.currentItem,
    required this.onItemSelected,
  });

  final NavItem currentItem;
  final ValueChanged<NavItem> onItemSelected;

  static const Color backgroundColor = Color(0xFFA9D3BB);

  static const _items = [
    (
      item: NavItem.dashboard,
      image: 'assets/dashboard.png',
      label: 'Dashboard',
      path: 'scanScreen.dart'
    ),
    (
      item: NavItem.historico,
      image: 'assets/historico.png',
      label: 'Histórico',
      path: 'scanScreen.dart'
    ),
    (
      item: NavItem.home,
      image: 'assets/home.png',
      label: 'Home',
      path: 'scanScreen.dart'
    ),
    (
      item: NavItem.qrcode,
      image: 'assets/qrcode.png',
      label: 'QRCode',
      path: 'scanScreen.dart'
    ),
    (
      item: NavItem.ra,
      image: 'assets/ra.png',
      label: 'RA',
      path: 'scanScreen.dart'
    ),
  ];

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

            final double scale = entry.item == NavItem.home
                ? (selected ? 1.15 : 1.0)
                : (selected ? 1.15 : 1.0);

            return GestureDetector(
              onTap: () {
                onItemSelected(entry.item);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const QRScannerPage(),
                  ),
                );
              },
              behavior: HitTestBehavior.opaque,
              child: SizedBox(
                width: 45,
                height: 45,
                child: Center(
                  child: Transform.scale(
                    scale: scale,
                    child: Image.asset(entry.image,
                        width: 35,
                        height: 35,
                        color: selected
                            ? Colors.black
                            : const Color.fromARGB(255, 71, 71, 71)),
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
