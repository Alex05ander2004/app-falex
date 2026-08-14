import 'package:flutter/material.dart';

/// Placeholder para pestañas cuyo módulo todavía no se construye
/// (Finanzas y Viajes llegan en las Fases 3 y 6 del plan).
class ComingSoonTab extends StatelessWidget {
  const ComingSoonTab({super.key, required this.titulo, required this.fase});

  final String titulo;
  final String fase;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.hourglass_empty, size: 36, color: theme.colorScheme.outline),
              const SizedBox(height: 12),
              Text('Todavía no está construido', style: theme.textTheme.titleMedium),
              const SizedBox(height: 6),
              Text(
                'Este módulo llega en la $fase — ver Ruta Falex.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
