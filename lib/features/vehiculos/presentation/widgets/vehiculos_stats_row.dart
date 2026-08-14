import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/enums.dart';
import '../../application/vehiculos_list_providers.dart';

/// Fila de estadísticas rápidas — inspirada en la pantalla de Flota del
/// borrador de Stitch (Total / Activos / En mantenimiento / Doc. por vencer).
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

    return Row(
      children: [
        _StatTile(label: 'Total', value: '${vehiculos.length}'),
        _StatTile(label: 'Activos', value: '$activos'),
        _StatTile(
          label: 'Mantenimiento',
          value: '$enMantenimiento',
          color: Theme.of(context).colorScheme.error,
        ),
        _StatTile(label: 'Doc. por vencer', value: '$porVencer'),
      ],
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
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Column(
            children: [
              Text(
                value,
                style: theme.textTheme.headlineSmall?.copyWith(color: color),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                textAlign: TextAlign.center,
                style: theme.textTheme.labelMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
