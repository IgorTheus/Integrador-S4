import 'package:flutter/material.dart';
import '../../_core/appbar.dart';
import '../../_core/navbar.dart';
import 'widget/camera_widget.dart';
import 'widget/info_widget.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  bool _cameraActive = false;
  String? _scannedValue;

  void _startCamera() => setState(() => _cameraActive = true);

  void _onDetected(String value) {
    setState(() {
      _cameraActive = false;
      _scannedValue = value;
    });
    // TODO: usar o valor para buscar informações do ativo, se necessário
    debugPrint('QR Code lido: $value');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MainAppBar(userName: 'usuário'),
      body: _cameraActive
          ? CameraWidget(onDetected: _onDetected)
          : InfoWidget(
              onStart: _startCamera,
              scannedValue: _scannedValue,
            ),
      bottomNavigationBar: const MainNavBar(currentItem: NavItem.qrcode),
    );
  }
}
