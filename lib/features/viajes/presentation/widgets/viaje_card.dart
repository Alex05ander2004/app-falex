import 'package:flutter/material.dart';

import '../../../../core/database/enum_labels.dart';
import '../../../../core/database/enums.dart';
import '../../domain/viaje_con_detalle.dart';
import 'viaje_estado_chip.dart';

class ViajeCard extends StatelessWidget {
  const ViajeCard({
    super.key,
    required this.item,
    required this.onTap,
    this.onMarcarTerminado,
  });

  final ViajeConDetalle item;
  final VoidCallback onTap;

  /// Si es nulo, no se muestra el botón — el viaje ya está finalizado o
  /// cancelado.
  final VoidCallback? onMarcarTerminado;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final viaje = item.viaje;
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${viaje.origen} → ${etiquetaDestinoPrincipal(viaje.destinoPrincipal)}',
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  ViajeEstadoChip(estado: viaje.estado),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                '${item.trabajador.nombre} · ${item.vehiculo.placa}',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 2),
              Text(
                _formatearFecha(viaje.fechaSalida),
                style: theme.textTheme.bodySmall,
              ),
              if (onMarcarTerminado != null) ...[
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: OutlinedButton.icon(
                    onPressed: onMarcarTerminado,
                    icon: const Icon(Icons.check_circle_outline, size: 18),
                    label: const Text('Marcar como terminado'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _formatearFecha(DateTime fecha) =>
      '${fecha.day}/${fecha.month}/${fecha.year}';
}

/// Solo tiene sentido finalizar un viaje que sigue abierto.
bool puedeMarcarseTerminado(ViajeEstado estado) =>
    estado == ViajeEstado.programado || estado == ViajeEstado.enCurso;
