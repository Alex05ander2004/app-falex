import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';

class FalexApp extends StatelessWidget {
  const FalexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Falex',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const _FalexHome(),
    );
  }
}

/// Placeholder de arranque — se reemplaza por la navegación real
/// (Dashboard / Viajes / Flota / Trabajadores) en la Fase 3+.
class _FalexHome extends StatelessWidget {
  const _FalexHome();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Falex')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Ruta Falex', style: theme.textTheme.headlineLarge),
              const SizedBox(height: 8),
              Text(
                'Proyecto base listo. El theme, la estructura por feature y '
                'las fuentes ya están en su lugar — falta el modelo de '
                'datos (Fase 1).',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
