import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../_core/appbar.dart';
import '../../_core/navbar.dart';

/// Um item de status (nome + valor + cor), usado para alimentar tanto a
/// barra empilhada quanto o gráfico de barras — assim os dois exibem
/// exatamente os mesmos nomes, valores e cores.
class _StatusItem {
  const _StatusItem(
      {required this.label, required this.valor, required this.cor});

  final String label;
  final int valor;
  final Color cor;
}

enum _Ordenacao { padrao, maiorParaMenor, menorParaMaior }

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  static const Color _borderColor = Color(0xFFA9D3BB);

  DateTime? _dataDe;
  DateTime? _dataAte;

  _Ordenacao _ordenacao = _Ordenacao.padrao;

  // TODO: substituir pelos dados reais (API / armazenamento local).
  // Os mesmos 4 status alimentam a barra de cima e o gráfico de baixo,
  // para manter nomes, valores e cores sempre iguais nos dois.
  final List<_StatusItem> _status = const [
    _StatusItem(label: 'Indisponível', valor: 3, cor: Color(0xFFD9534F)),
    _StatusItem(label: 'Manutenção', valor: 5, cor: Color(0xFF4A7FD9)),
    _StatusItem(label: 'Disponível', valor: 2, cor: Color(0xFF8BC48A)),
    _StatusItem(label: 'Pendente', valor: 4, cor: Color(0xFFE0A030)),
  ];

  Future<void> _pickDate({required bool isInicio}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked == null) return;
    setState(() {
      if (isInicio) {
        _dataDe = picked;
      } else {
        _dataAte = picked;
      }
    });
    // TODO: recarregar os dados do período selecionado (_dataDe / _dataAte)
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'DD/MM/AAAA';
    final d = date.day.toString().padLeft(2, '0');
    final m = date.month.toString().padLeft(2, '0');
    final y = date.year.toString();
    return '$d/$m/$y';
  }

  List<_StatusItem> get _statusOrdenado {
    final lista = List<_StatusItem>.from(_status);
    switch (_ordenacao) {
      case _Ordenacao.maiorParaMenor:
        lista.sort((a, b) => b.valor.compareTo(a.valor));
        break;
      case _Ordenacao.menorParaMaior:
        lista.sort((a, b) => a.valor.compareTo(b.valor));
        break;
      case _Ordenacao.padrao:
        break;
    }
    return lista;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MainAppBar(userName: 'usuário'),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: Text(
                  'DASHBOARD',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'STATUS DE ATIVOS',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _DateField(
                      label: 'De:',
                      value: _formatDate(_dataDe),
                      onTap: () => _pickDate(isInicio: true),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _DateField(
                      label: 'Até:',
                      value: _formatDate(_dataAte),
                      onTap: () => _pickDate(isInicio: false),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _StatusAtivosBar(itens: _status),
              const SizedBox(height: 16),
              _StatusAtivosLegenda(itens: _status),
              const SizedBox(height: 32),
              const Text(
                'STATUS DE ATIVOS (POR QUANTIDADE)',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 12),
              _OrdenacaoFiltro(
                selecionado: _ordenacao,
                onChanged: (valor) => setState(() => _ordenacao = valor),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.fromLTRB(8, 20, 16, 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _borderColor, width: 1.5),
                ),
                height: 220,
                child: _StatusChart(itens: _statusOrdenado),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const MainNavBar(currentItem: NavItem.dashboard),
    );
  }
}

/// Campo de data somente-leitura (abre o DatePicker ao tocar),
/// no mesmo estilo visual dos inputs já usados no app.
class _DateField extends StatelessWidget {
  const _DateField({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F8F7),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFFE0E0E0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(value, style: const TextStyle(fontSize: 13)),
                const Icon(Icons.calendar_today,
                    size: 16, color: Colors.black45),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Barra horizontal única, dividida proporcionalmente entre os status,
/// com o número de ativos centralizado em cada segmento.
class _StatusAtivosBar extends StatelessWidget {
  const _StatusAtivosBar({required this.itens});

  final List<_StatusItem> itens;

  @override
  Widget build(BuildContext context) {
    final total = itens.fold<int>(0, (soma, item) => soma + item.valor);
    if (total == 0) {
      return Container(
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0xFFF0F0F0),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: const Text('Sem dados no período',
            style: TextStyle(fontSize: 12, color: Colors.black45)),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        height: 44,
        child: Row(
          children: [
            for (final item in itens)
              if (item.valor > 0) _segmento(item, total),
          ],
        ),
      ),
    );
  }

  Widget _segmento(_StatusItem item, int total) {
    return Expanded(
      flex: item.valor,
      child: Container(
        color: item.cor,
        alignment: Alignment.center,
        child: Text(
          '${item.valor}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

class _StatusAtivosLegenda extends StatelessWidget {
  const _StatusAtivosLegenda({required this.itens});

  final List<_StatusItem> itens;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < itens.length; i++) ...[
          if (i > 0) const SizedBox(height: 8),
          _item(itens[i]),
        ],
      ],
    );
  }

  Widget _item(_StatusItem item) {
    return Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
              color: item.cor, borderRadius: BorderRadius.circular(4)),
        ),
        const SizedBox(width: 10),
        Text(item.label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}

/// Fileira de chips para escolher a ordenação do gráfico de barras abaixo.
class _OrdenacaoFiltro extends StatelessWidget {
  const _OrdenacaoFiltro({required this.selecionado, required this.onChanged});

  final _Ordenacao selecionado;
  final ValueChanged<_Ordenacao> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _chip(
          label: 'Padrão',
          icon: Icons.sort,
          valor: _Ordenacao.padrao,
        ),
        _chip(
          label: 'Maior p/ menor',
          icon: Icons.arrow_downward,
          valor: _Ordenacao.maiorParaMenor,
        ),
        _chip(
          label: 'Menor p/ maior',
          icon: Icons.arrow_upward,
          valor: _Ordenacao.menorParaMaior,
        ),
      ],
    );
  }

  Widget _chip({
    required String label,
    required IconData icon,
    required _Ordenacao valor,
  }) {
    final bool ativo = selecionado == valor;
    return GestureDetector(
      onTap: () => onChanged(valor),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: ativo ? const Color(0xFF4A7FD9) : const Color(0xFFF7F8F7),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: ativo ? const Color(0xFF4A7FD9) : const Color(0xFFE0E0E0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: ativo ? Colors.white : Colors.black54),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: ativo ? Colors.white : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Gráfico de barras com os mesmos status (nome, valor e cor) exibidos
/// na barra de cima, usando fl_chart. A ordem dos itens já vem definida
/// pelo filtro escolhido (_Ordenacao).
class _StatusChart extends StatelessWidget {
  const _StatusChart({required this.itens});

  final List<_StatusItem> itens;

  @override
  Widget build(BuildContext context) {
    if (itens.isEmpty) {
      return const Center(
        child: Text('Sem dados no período',
            style: TextStyle(fontSize: 12, color: Colors.black45)),
      );
    }

    final maxValor = itens.map((e) => e.valor).reduce((a, b) => a > b ? a : b);
    final maxY = (maxValor * 1.3).clamp(1, double.infinity).toDouble();

    return BarChart(
      BarChartData(
        maxY: maxY,
        alignment: BarChartAlignment.spaceAround,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= itens.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    itens[index].label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 10, color: Colors.black54),
                  ),
                );
              },
            ),
          ),
        ),
        // Tooltip sempre visível (sem precisar tocar), mostrando o valor
        // exato de cada barra acima dela.
        barTouchData: BarTouchData(
          enabled: false,
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (group) => Colors.transparent,
            tooltipPadding: EdgeInsets.zero,
            tooltipMargin: 6,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                rod.toY.round().toString(),
                const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              );
            },
          ),
        ),
        barGroups: List.generate(itens.length, (index) {
          final item = itens[index];
          return BarChartGroupData(
            x: index,
            showingTooltipIndicators: const [0],
            barRods: [
              BarChartRodData(
                toY: item.valor.toDouble(),
                color: item.cor,
                width: 36,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          );
        }),
      ),
    );
  }
}
