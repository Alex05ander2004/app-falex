import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../egresos/presentation/egresos_list_screen.dart';
import '../../ingresos/presentation/ingresos_list_screen.dart';
import '../application/balance_general_provider.dart';

/// Ingresos y egresos generales (no ligados a un viaje puntual) — Ruta
/// Falex, Fase 4. El dashboard con filtros por mes/trabajador/viaje
/// llega en la Fase 6; esto es la base sobre la que se construye.
class FinanzasScreen extends ConsumerWidget {
  const FinanzasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balance = ref.watch(balanceGeneralProvider);
    final igvPorPagar = ref.watch(igvPorPagarProvider);
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Finanzas'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Ingresos'),
              Tab(text: 'Egresos'),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: _TarjetaResumen(
                        titulo: 'Balance general',
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
            const Expanded(
              child: TabBarView(
                children: [
                  IngresosListScreen(),
                  EgresosListScreen(),
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
