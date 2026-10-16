import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('As senhas não conferem')),
      );
      return;
    }
  }

  void _goToLogin() {
    Navigator.pop(context);
  }

  InputDecoration _fieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.black38, fontSize: 13),
      isDense: true,
      filled: true,
      fillColor: Color(0xFFF7F8F7),
      contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: BorderSide(color: Color(0xFFE0E0E0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: BorderSide(color: Color(0xFFE0E0E0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: BorderSide(color: Color(0xFF4CAF7D), width: 1.4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 320),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/logo.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                  
                  SizedBox(height: 16),
                  
                  Center(
                    child: Text(
                      'CADASTRO',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 24),
                  
                  Text('Usuário:', style: TextStyle(fontSize: 14)),
                  
                  SizedBox(height: 6),
                  
                  TextField(
                    controller: _userController,
                    style: TextStyle(fontSize: 14),
                    decoration: _fieldDecoration('Digite seu usuário'),
                  ),
                  
                  SizedBox(height: 16),
                  
                  Text('Senha:', style: TextStyle(fontSize: 14)),
                  
                  SizedBox(height: 6),
                  
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    style: TextStyle(fontSize: 14),
                    decoration: _fieldDecoration('Digite sua senha'),
                  ),
                  
                  SizedBox(height: 16),
                  
                  Text('Confirmar senha:', style: TextStyle(fontSize: 14)),

                  
                  SizedBox(height: 6),
                  
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    onSubmitted: (_) => _register(),
                    style: TextStyle(fontSize: 14),
                    decoration: _fieldDecoration('Confirme sua senha'),
                  ),
                  
                  SizedBox(height: 20),

                  Center(
                   child: ElevatedButton(
                      onPressed: _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(229, 248, 236, 1),
                        foregroundColor: Colors.black
                      ),
                      child: Text("CADASTRAR")
                    ),
                  ),

                  SizedBox(height: 24,),
                  
                  Center(
                    child: GestureDetector(
                      onTap: _goToLogin,
                      child: Text(
                        'Já tem conta? Logar',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
