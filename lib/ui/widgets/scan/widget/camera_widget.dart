import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// Câmera ativa para leitura do QR Code, embutida dentro do scan_screen
/// (sem Scaffold/AppBar próprios).
class CameraWidget extends StatefulWidget {
  const CameraWidget({super.key, required this.onDetected});

  /// Chamado com o valor lido assim que um QR Code é reconhecido.
  final ValueChanged<String> onDetected;

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  bool _handled = false;
  bool _torchOn = false;

  final MobileScannerController _controller = MobileScannerController(
    detectionTimeoutMs: 600,
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_handled) return;

    final barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    final raw = barcodes.first.rawValue;
    if (raw == null || raw.isEmpty) return;

    _handled = true;
    widget.onDetected(raw);
  }

  void _toggleTorch() {
    _controller.toggleTorch();
    setState(() => _torchOn = !_torchOn);
  }

  void _pickFromGallery() {
    // TODO: usar image_picker + _controller.analyzeImage para ler QR de uma imagem salva
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        MobileScanner(
          controller: _controller,
          onDetect: _onDetect,
        ),

        // Banner superior com instrução
        Positioned(
          top: 16,
          left: 24,
          right: 24,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFDCEEE2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Aponte a câmera para escanear o QrCode',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ),

        // Moldura de leitura (cantos)
        const Center(
          child: SizedBox(width: 220, height: 220, child: _ScanFrame()),
        ),

        // Controles inferiores: flash e galeria
        Positioned(
          bottom: 24,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _RoundIconButton(
                icon: _torchOn ? Icons.flash_on : Icons.flash_off,
                onTap: _toggleTorch,
              ),
              const SizedBox(width: 24),
              _RoundIconButton(
                icon: Icons.image_outlined,
                onTap: _pickFromGallery,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.85),
        ),
        child: Icon(icon, color: Colors.black87),
      ),
    );
  }
}

/// Moldura com cantos destacados, parecida com a do mockup.
class _ScanFrame extends StatelessWidget {
  const _ScanFrame();

  @override
  Widget build(BuildContext context) => CustomPaint(painter: _ScanFramePainter());
}

class _ScanFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const double corner = 28;

    canvas.drawLine(const Offset(0, 0), const Offset(corner, 0), paint);
    canvas.drawLine(const Offset(0, 0), const Offset(0, corner), paint);

    canvas.drawLine(Offset(size.width, 0), Offset(size.width - corner, 0), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, corner), paint);

    canvas.drawLine(Offset(0, size.height), Offset(corner, size.height), paint);
    canvas.drawLine(Offset(0, size.height), Offset(0, size.height - corner), paint);

    canvas.drawLine(Offset(size.width, size.height), Offset(size.width - corner, size.height), paint);
    canvas.drawLine(Offset(size.width, size.height), Offset(size.width, size.height - corner), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}