import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../egresos/presentation/egresos_list_screen.dart';
import '../../impuestos/presentation/impuestos_list_screen.dart';
import '../../ingresos/presentation/ingresos_list_screen.dart';
import '../application/balance_general_provider.dart';
import 'tendencia_screen.dart';
import 'widgets/finanzas_filtro_bar.dart';

/// Ingresos, egresos e impuestos — filtrables por mes, trabajador o
/// vehículo (Ruta Falex, Fase 6).
class FinanzasScreen extends ConsumerWidget {
  const FinanzasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balance = ref.watch(balanceGeneralProvider);
    final igvPorPagar = ref.watch(igvPorPagarProvider);
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Finanzas'),
          actions: [
            IconButton(
              icon: const Icon(Icons.bar_chart),
              tooltip: 'Tendencia mensual',
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const TendenciaScreen()),
              ),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Ingresos'),
              Tab(text: 'Egresos'),
              Tab(text: 'Impuestos'),
            ],
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 8),
            const FinanzasFiltroBar(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: _TarjetaResumen(
                        titulo: 'Balance',
                        valor: balance,
                        colorNegativo: theme.colorScheme.error,
                        colorPositivo: theme.colorScheme.tertiary,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _TarjetaResumen(
                        titulo: 'IGV por pagar',
                        valor: igvPorPagar,
                        // Acá "positivo" (se debe) se pinta neutro, no en
                        // verde como una ganancia — no es plata a favor.
                        colorNegativo: theme.colorScheme.tertiary,
                        colorPositivo: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Text(
                'Esto es para llevar el control, no representa una cuenta '
                'bancaria real: los gastos no se descuentan de ningún saldo '
                'automáticamente.',
                style: theme.textTheme.bodySmall,
              ),
            ),
            const SizedBox(height: 8),
            const Expanded(
              child: TabBarView(
                children: [
                  IngresosListScreen(),
                  EgresosListScreen(),
                  ImpuestosListScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TarjetaResumen extends StatelessWidget {
  const _TarjetaResumen({
    required this.titulo,
    required this.valor,
    required this.colorNegativo,
    required this.colorPositivo,
  });

  final String titulo;
  final double? valor;
  final Color colorNegativo;
  final Color colorPositivo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(titulo, style: theme.textTheme.labelMedium),
            const SizedBox(height: 4),
            Text(
              valor == null ? '…' : 'S/ ${valor!.toStringAsFixed(2)}',
              style: theme.textTheme.titleLarge?.copyWith(
                    color: (valor ?? 0) < 0 ? colorNegativo : colorPositivo,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
