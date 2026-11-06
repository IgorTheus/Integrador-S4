import "package:flutter/material.dart";
import 'package:integrador_s4/src/ui/_core/appbar.dart';
import "package:integrador_s4/src/ui/_core/navbar.dart";

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const Color _green = Color.fromRGBO(16, 153, 60, 1);
  static const Color _lightGreen = Color.fromRGBO(159, 236, 187, 1);

  void _recuperarSenha(BuildContext context) {
    // TODO: navegar para o fluxo de recuperação de senha
  }

  void _deslogar(BuildContext context) {
    // TODO: limpar sessão/dados salvos e voltar para a tela de Login
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MainAppBar(userName: 'usuário', showBackButton: true),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Bloco título + linha + avatar, centralizado de forma
              // explícita (independente da largura dos outros elementos
              // da tela, como o card ou os botões).
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "MEU PERFIL",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 60,
                      height: 3,
                      decoration: const BoxDecoration(color: _green),
                    ),
                    const SizedBox(height: 34),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 3),
                      ),
                      child: const Icon(Icons.person, size: 120),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 34),

              // Card com Nome e Email
              Container(
                width: double.infinity,
                constraints: const BoxConstraints(maxWidth: 320),
                decoration: BoxDecoration(
                  border: Border.all(color: _lightGreen, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ProfileInfoRow(
                      icon: Icons.person,
                      label: 'NOME',
                      value: 'Admin',
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Divider(height: 1, color: Color(0xFFE0E0E0)),
                    ),
                    _ProfileInfoRow(
                      icon: Icons.email_outlined,
                      label: 'EMAIL',
                      value: 'admin@gmail.com',
                      underlineValue: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              _ProfileActionButton(
                icon: Icons.lock_outline,
                label: 'RECUPERAR SENHA',
                borderColor: _lightGreen,
                onTap: () => _recuperarSenha(context),
              ),
              const SizedBox(height: 16),
              _ProfileActionButton(
                icon: Icons.logout,
                label: 'DESLOGAR',
                borderColor: _lightGreen,
                onTap: () => _deslogar(context),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const MainNavBar(currentItem: NavItem.home),
    );
  }
}

/// Linha "ícone + rótulo + valor" usada dentro do card de Nome/Email.
class _ProfileInfoRow extends StatelessWidget {
  const _ProfileInfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.underlineValue = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool underlineValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 40, color: Colors.black87),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 11, color: Colors.black54),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  decoration: underlineValue ? TextDecoration.underline : null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Botão de ação (RECUPERAR SENHA / DESLOGAR): contorno arredondado,
/// ícone à esquerda, label e seta ">" à direita.
class _ProfileActionButton extends StatelessWidget {
  const _ProfileActionButton({
    required this.icon,
    required this.label,
    required this.borderColor,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color borderColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 320),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Row(
            children: [
              Icon(icon, size: 22, color: Colors.black87),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.black54),
            ],
          ),
        ),
      ),
    );
  }
}
