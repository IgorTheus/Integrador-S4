import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Persistência simples dos QR Codes cadastrados, usando
/// SharedPreferences + JSON (sem model, sem banco de dados).
class QrCodeStorage {
  static const _storageKey = 'qrcodes_cadastrados';

  /// Salva um novo QR Code cadastrado (nome + código lido).
  static Future<void> salvar({
    required String nome,
    required String codigo,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final lista = await _carregarLista(prefs);

    lista.add({
      'nome': nome,
      'codigo': codigo,
      'data': DateTime.now().toIso8601String(),
    });

    await prefs.setString(_storageKey, jsonEncode(lista));
  }

  /// Retorna todos os QR Codes cadastrados, mais recentes primeiro.
  static Future<List<Map<String, dynamic>>> listarTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final lista = await _carregarLista(prefs);
    return lista.reversed.toList();
  }

  /// Retorna os QR Codes cujo nome contém [termo] (case-insensitive).
  /// Se [termo] estiver vazio, retorna todos.
  static Future<List<Map<String, dynamic>>> buscarPorNome(String termo) async {
    final todos = await listarTodos();
    if (termo.trim().isEmpty) return todos;

    final termoLower = termo.toLowerCase();
    return todos
        .where((item) =>
            (item['nome'] as String).toLowerCase().contains(termoLower))
        .toList();
  }

  static Future<List<Map<String, dynamic>>> _carregarLista(
      SharedPreferences prefs) async {
    final raw = prefs.getString(_storageKey);
    if (raw == null) return [];
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded.cast<Map<String, dynamic>>();
  }
}