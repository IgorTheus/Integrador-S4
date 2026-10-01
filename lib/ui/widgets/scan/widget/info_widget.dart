import 'package:flutter/material.dart';

/// Tela inicial do QRCode: texto de instrução no topo, resultado do
/// último scan (se houver) no meio, e botão para ligar a câmera embaixo.
class InfoWidget extends StatelessWidget {
  const InfoWidget({
    super.key,
    required this.onStart,
    this.scannedValue,
  });

  final VoidCallback onStart;

  /// Valor lido do último QR Code escaneado, se houver.
  final String? scannedValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 48, 32, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Escaneie o QR Code da sua máquina e obtenha informações sobre ela!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, height: 1.4),
          ),
          if (scannedValue != null) ...[
            const SizedBox(height: 24),
            _ScannedResultCard(value: scannedValue!),
          ],
          const Spacer(),
          OutlinedButton(
            onPressed: onStart,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: Color(0xFFA9D3BB), width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
            ),
            child: const Text(
              'LIGAR CÂMERA',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _ScannedResultCard extends StatelessWidget {
  const _ScannedResultCard({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8F7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFA9D3BB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Último QR Code lido:',
            style: TextStyle(fontSize: 12, color: Color.fromRGBO(0, 0, 0, 0.541)),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}