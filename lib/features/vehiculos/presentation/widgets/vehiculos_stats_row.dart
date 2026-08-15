import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/enums.dart';
import '../../application/vehiculos_list_providers.dart';

/// Estadísticas rápidas — inspirado en la pantalla de Flota del borrador
/// de Stitch (Total / Activos / En mantenimiento / Doc. por vencer).
///
/// En grilla 2x2 en vez de una sola fila de 4: con 4 tarjetas angostas
/// una etiqueta como "Mantenimiento" no cabía y Flutter la partía a la
/// mitad de la palabra ("Mantenimi" / "ento"); con el doble de ancho por
/// tarjeta entra completa.
class VehiculosStatsRow extends ConsumerWidget {
  const VehiculosStatsRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehiculos = ref.watch(vehiculosListadoProvider).valueOrNull ?? [];
    final porVencer = ref.watch(vehiculosDocumentosPorVencerProvider).valueOrNull ?? 0;
    final activos =
        vehiculos.where((v) => v.estado == VehiculoEstado.activo).length;
    final enMantenimiento =
        vehiculos.where((v) => v.estado == VehiculoEstado.mantenimiento).length;

    return Column(
      children: [
        _StatRow(children: [
          _StatTile(label: 'Total', value: '${vehiculos.length}'),
          _StatTile(label: 'Activos', value: '$activos'),
        ]),
        const SizedBox(height: 10),
        _StatRow(children: [
          _StatTile(
            label: 'Mantenimiento',
            value: '$enMantenimiento',
            color: Theme.of(context).colorScheme.error,
          ),
          _StatTile(label: 'Doc. por vencer', value: '$porVencer'),
        ]),
      ],
    );
  }
}

/// Fila de tarjetas de igual alto, separadas por un gap fijo.
class _StatRow extends StatelessWidget {
  const _StatRow({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0) const SizedBox(width: 10),
            Expanded(child: children[i]),
          ],
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value, this.color});

  final String label;
  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: theme.textTheme.headlineSmall?.copyWith(color: color),
            ),
            const SizedBox(height: 2),
            Text(label, style: theme.textTheme.labelMedium),
          ],
        ),
      ),
    );
  }
}
