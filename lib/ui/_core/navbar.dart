import 'package:flutter/material.dart';

enum NavItem { dashboard, historico, home, qrcode, ra }

/// Barra de navegação inferior padrão do app, com os 5 itens principais.
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
    (item: NavItem.dashboard, icon: Icons.bar_chart, label: 'Dashboard'),
    (item: NavItem.historico, icon: Icons.receipt_long, label: 'Histórico'),
    (item: NavItem.home, icon: Icons.home, label: 'Home'),
    (item: NavItem.qrcode, icon: Icons.qr_code, label: 'QRCode'),
    (item: NavItem.ra, icon: Icons.desktop_windows_outlined, label: 'RA'),
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
            return GestureDetector(
              onTap: () => onItemSelected(entry.item),
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Icon(
                  entry.icon,
                  size: 24,
                  color: selected ? Colors.black87 : Colors.black45,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
