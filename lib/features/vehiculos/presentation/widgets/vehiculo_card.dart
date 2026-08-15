import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/enums.dart';
import '../../../../core/widgets/status_chip.dart';
import 'vehiculo_display.dart';

class VehiculoCard extends StatelessWidget {
  const VehiculoCard({super.key, required this.vehiculo, required this.onTap});

  final Vehiculo vehiculo;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    vehiculo.tipo == VehiculoTipo.trailer
                        ? Icons.rv_hookup_outlined
                        : Icons.local_shipping_outlined,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  if (vehiculo.color != null)
                    Positioned(
                      right: -2,
                      bottom: -2,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: pinturaColorVehiculo(vehiculo.color!),
                          border: Border.all(color: theme.colorScheme.surface, width: 1.5),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(vehiculo.placa, style: theme.textTheme.titleMedium),
                    const SizedBox(height: 2),
                    Text(
                      etiquetaTipoVehiculo(vehiculo.tipo),
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              _EstadoChip(estado: vehiculo.estado),
            ],
          ),
        ),
      ),
    );
  }
}

class _EstadoChip extends StatelessWidget {
  const _EstadoChip({required this.estado});
  final VehiculoEstado estado;

  @override
  Widget build(BuildContext context) {
    final (label, tone) = switch (estado) {
      VehiculoEstado.activo => ('Activo', StatusTone.success),
      VehiculoEstado.mantenimiento => ('Mantenimiento', StatusTone.warning),
      VehiculoEstado.inactivo => ('Inactivo', StatusTone.neutral),
    };
    return StatusChip(label: label, tone: tone);
  }
}
