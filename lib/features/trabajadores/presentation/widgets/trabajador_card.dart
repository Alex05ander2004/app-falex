import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/widgets/status_chip.dart';

class TrabajadorCard extends StatelessWidget {
  const TrabajadorCard({
    super.key,
    required this.trabajador,
    required this.onTap,
  });

  final Trabajador trabajador;
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
              CircleAvatar(
                backgroundColor: theme.colorScheme.secondaryContainer,
                child: Text(
                  trabajador.nombre.isNotEmpty
                      ? trabajador.nombre[0].toUpperCase()
                      : '?',
                  style: TextStyle(color: theme.colorScheme.onSecondaryContainer),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(trabajador.nombre, style: theme.textTheme.titleMedium),
                    const SizedBox(height: 2),
                    Text(
                      '${trabajador.cargo} · DNI ${trabajador.dni}',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              StatusChip(
                label: trabajador.activo ? 'Activo' : 'Inactivo',
                tone: trabajador.activo ? StatusTone.success : StatusTone.neutral,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
