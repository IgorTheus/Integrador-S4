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
        const SnackBar(content: Text('As senhas não conferem')),
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
      hintStyle: const TextStyle(color: Colors.black38, fontSize: 13),
      isDense: true,
      filled: true,
      fillColor: const Color(0xFFF7F8F7),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: const BorderSide(color: Color(0xFF4CAF7D), width: 1.4),
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
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 320),
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
                  
                  const SizedBox(height: 16),
                  
                  const Center(
                    child: Text(
                      'CADASTRO',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  const Text('Usuário:', style: TextStyle(fontSize: 14)),
                  
                  const SizedBox(height: 6),
                  
                  TextField(
                    controller: _userController,
                    style: const TextStyle(fontSize: 14),
                    decoration: _fieldDecoration('Digite seu usuário'),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  const Text('Senha:', style: TextStyle(fontSize: 14)),
                  
                  const SizedBox(height: 6),
                  
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    style: const TextStyle(fontSize: 14),
                    decoration: _fieldDecoration('Digite sua senha'),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  const Text('Confirmar senha:', style: TextStyle(fontSize: 14)),

                  
                  const SizedBox(height: 6),
                  
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    onSubmitted: (_) => _register(),
                    style: const TextStyle(fontSize: 14),
                    decoration: _fieldDecoration('Confirme sua senha'),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  Center(
                    child: GestureDetector(
                      onTap: _goToLogin,
                      child: const Text(
                        'Já tem conta? Logar',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: Colors.black54),
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
