import "package:flutter/material.dart";
import 'package:integrador_s4/src/ui/_core/appbar.dart';
import "package:integrador_s4/src/ui/_core/navbar.dart";

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(userName: 'usuário'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "MEU PERFIL", 
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
              ),
            ),

            Container(
              width: 60,
              height: 3,
              decoration: BoxDecoration(
                color: Color.fromRGBO(16, 153, 60, 100)
              ),
            ),

            SizedBox(height: 34,),

            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black,
                  width: 3
                )
              ),
              child: Icon(
                Icons.person,
                size: 120,
              ),
            ),

            SizedBox(height: 34,),

            Container(
              width: 280,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(159, 236, 187, 100),
                  width: 2
                ),
                borderRadius: BorderRadius.circular(12)
              ),
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.person,
                    size: 46,
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "NOME",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Danilo Macri",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),


          ]
        )
      ),
      bottomNavigationBar: MainNavBar(currentItem: NavItem.home),
    );
  }
}