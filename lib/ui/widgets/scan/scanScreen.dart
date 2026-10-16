import 'package:flutter/material.dart';
import '../../_core/appbar.dart';
import '../../_core/navbar.dart';
import '../../../data/qrcode_storage.dart';
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

  Future<void> _onDetected(String value) async {
    setState(() {
      _cameraActive = false;
      _scannedValue = value;
    });

    final nome = await _askName();
    if (nome == null || nome.trim().isEmpty) return;

    await QrCodeStorage.salvar(nome: nome.trim(), codigo: value);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('"$nome" salvo com sucesso!')),
      );
    }
  }

  Future<String?> _askName() {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nomear QR Code'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Ex: Máquina 01'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
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
