import 'package:flutter/material.dart';
import 'package:integrador_s4/src/ui/widgets/profile/profileScreen.dart';

/// AppBar padrão do app: logo à esquerda, saudação ao centro/esquerda
/// e menu hambúrguer à direita.
class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    this.userName,
  });

  final String? userName;

  static Color backgroundColor = Color(0xFFA9D3BB);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 12,
      title: Row(
        children: [
          Image.asset(
            'assets/logo.png',
            width: 54,
            height: 54,
            fit: BoxFit.contain,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Olá ${userName ?? 'usuário'}!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          IconButton(
            icon: Icon(
              Icons.menu, 
              color: Colors.black,
              size: 32,
            ),
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => ProfileScreen()
                )
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
