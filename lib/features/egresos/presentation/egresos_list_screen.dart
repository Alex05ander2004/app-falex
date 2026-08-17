import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/enum_labels.dart';
import '../../../core/widgets/confirm_delete_dialog.dart';
import '../../../core/widgets/empty_state.dart';
import '../application/egresos_list_providers.dart';
import '../data/egresos_repository.dart';
import 'egreso_form_screen.dart';

class EgresosListScreen extends ConsumerWidget {
  const EgresosListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final egresos = ref.watch(egresosGeneralesProvider);
    final theme = Theme.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const EgresoFormScreen()),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Nuevo gasto'),
      ),
      body: egresos.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => EmptyState(
          icon: Icons.error_outline,
          title: 'No se pudo cargar la lista',
          message: '$e',
        ),
        data: (lista) {
          if (lista.isEmpty) {
            return const EmptyState(
              icon: Icons.trending_down,
              title: 'Aún no hay gastos registrados',
              message: 'Toca "Nuevo gasto" para registrar el primero.',
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
            itemCount: lista.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final e = lista[index];
              return Card(
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => EgresoFormScreen(egreso: e)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        const Icon(Icons.trending_down),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(etiquetaEgresoCategoria(e.categoria), style: theme.textTheme.titleMedium),
                              const SizedBox(height: 2),
                              Text(
                                '${e.fecha.day}/${e.fecha.month}/${e.fecha.year}'
                                '${e.viajeId != null ? ' · Ligado a un viaje' : ''}'
                                '${e.vehiculoId != null ? ' · Ligado a un vehículo' : ''}'
                                '${e.tieneFacturaConRuc ? ' · Crédito IGV S/ ${e.igvCredito.toStringAsFixed(2)}' : ''}',
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Text('S/ ${e.monto.toStringAsFixed(2)}', style: theme.textTheme.titleMedium),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () async {
                            final ok = await confirmarEliminar(
                              context,
                              'Se quitará este gasto por S/ ${e.monto.toStringAsFixed(2)}.',
                            );
                            if (ok) {
                              await ref.read(egresosRepositoryProvider).eliminar(e.id);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
