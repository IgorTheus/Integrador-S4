import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../_core/appbar.dart';
import '../../_core/navbar.dart';
import '../../../../dados/qrcode_storage.dart';

class HistoricScreen extends StatefulWidget {
  const HistoricScreen({super.key});

  @override
  State<HistoricScreen> createState() => _HistoricScreenState();
}

class _HistoricScreenState extends State<HistoricScreen> {
  final _searchController = TextEditingController();
  List<Map<String, dynamic>> _itens = [];

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  Future<void> _carregar([String termo = '']) async {
    final resultado = await QrCodeStorage.buscarPorNome(termo);
    setState(() => _itens = resultado);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showQrDialog(Map<String, dynamic> item) {
    final nome = item['nome'] as String;
    final codigo = item['codigo'] as String;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                nome,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 20),
              QrImageView(
                data: codigo,
                size: 220,
                backgroundColor: Colors.white,
              ),
              const SizedBox(height: 16),
              Text(
                codigo,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side:
                        const BorderSide(color: Color(0xFFA9D3BB), width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  child: const Text(
                    'FECHAR',
                    style: TextStyle(
                        fontWeight: FontWeight.w800, color: Colors.black87),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MainAppBar(userName: 'usuário'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: _carregar,
              decoration: InputDecoration(
                hintText: 'Buscar por nome...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: const Color(0xFFF7F8F7),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _itens.isEmpty
                  ? const Center(
                      child: Text(
                        'Histórico s/ movimentação',
                        style: TextStyle(color: Colors.black45),
                      ),
                    )
                  : ListView.separated(
                      itemCount: _itens.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final item = _itens[index];
                        final nome = item['nome'] as String;
                        final codigo = item['codigo'] as String;

                        return GestureDetector(
                          onTap: () => _showQrDialog(item),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border:
                                  Border.all(color: const Color(0xFFA9D3BB)),
                            ),
                            child: Row(
                              children: [
                                QrImageView(
                                  data: codigo,
                                  size: 56,
                                  backgroundColor: Colors.white,
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        nome,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        codigo,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.chevron_right,
                                    color: Colors.black38),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MainNavBar(currentItem: NavItem.historico),
    );
  }
}
