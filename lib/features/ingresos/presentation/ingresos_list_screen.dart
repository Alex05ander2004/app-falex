import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/enum_labels.dart';
import '../../../core/widgets/confirm_delete_dialog.dart';
import '../../../core/widgets/empty_state.dart';
import '../application/ingresos_list_providers.dart';
import '../data/ingresos_repository.dart';
import 'ingreso_form_screen.dart';

class IngresosListScreen extends ConsumerWidget {
  const IngresosListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ingresos = ref.watch(ingresosGeneralesProvider);
    final theme = Theme.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const IngresoFormScreen()),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Nuevo ingreso'),
      ),
      body: ingresos.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => EmptyState(
          icon: Icons.error_outline,
          title: 'No se pudo cargar la lista',
          message: '$e',
        ),
        data: (lista) {
          if (lista.isEmpty) {
            return const EmptyState(
              icon: Icons.trending_up,
              title: 'Aún no hay ingresos registrados',
              message: 'Toca "Nuevo ingreso" para registrar el primero.',
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
            itemCount: lista.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final i = lista[index];
              final neto = i.monto - i.detraccion;
              return Card(
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => IngresoFormScreen(ingreso: i)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        const Icon(Icons.trending_up),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                i.destinoFlete == null
                                    ? etiquetaIngresoConcepto(i.concepto)
                                    : '${etiquetaIngresoConcepto(i.concepto)} · ${i.destinoFlete}',
                                style: theme.textTheme.titleMedium,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${i.fecha.day}/${i.fecha.month}/${i.fecha.year}'
                                '${i.viajeId != null ? ' · Ligado a un viaje' : ''}'
                                '${i.igvDebito > 0 ? ' · IGV débito S/ ${i.igvDebito.toStringAsFixed(2)}' : ''}',
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Text('S/ ${neto.toStringAsFixed(2)}', style: theme.textTheme.titleMedium),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () async {
                            final ok = await confirmarEliminar(
                              context,
                              'Se quitará este ingreso por S/ ${i.monto.toStringAsFixed(2)}.',
                            );
                            if (ok) {
                              await ref.read(ingresosRepositoryProvider).eliminar(i.id);
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
