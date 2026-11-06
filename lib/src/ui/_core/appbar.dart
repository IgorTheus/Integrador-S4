import 'package:flutter/material.dart';
import 'package:integrador_s4/src/ui/widgets/profile/profileScreen.dart';

/// AppBar padrão do app: logo (ou seta de voltar) à esquerda, saudação
/// ao centro e menu hambúrguer à direita.
class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    this.userName,
    this.showBackButton = false,
  });

  final String? userName;

  /// Quando true, mostra uma seta de voltar no lugar da logo e esconde
  /// o menu hambúrguer. Usado apenas na tela de Perfil.
  final bool showBackButton;

  static Color backgroundColor = const Color(0xFFA9D3BB);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 12,
      title: Row(
        children: [
          if (showBackButton)
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
              onPressed: () => Navigator.pop(context),
            )
          else
            Image.asset(
              'assets/logo.png',
              width: 54,
              height: 54,
              fit: BoxFit.contain,
            ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Olá ${userName ?? 'usuário'}!',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (!showBackButton)
            IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
                size: 32,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}