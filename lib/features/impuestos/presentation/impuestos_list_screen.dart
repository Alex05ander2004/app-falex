import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/enum_labels.dart';
import '../../../core/database/enums.dart';
import '../../../core/widgets/confirm_delete_dialog.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/status_chip.dart';
import '../application/impuestos_list_providers.dart';
import '../data/impuestos_repository.dart';
import 'impuesto_form_screen.dart';

class ImpuestosListScreen extends ConsumerWidget {
  const ImpuestosListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final impuestos = ref.watch(impuestosProvider);
    final theme = Theme.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const ImpuestoFormScreen()),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Nuevo impuesto'),
      ),
      body: impuestos.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => EmptyState(
          icon: Icons.error_outline,
          title: 'No se pudo cargar la lista',
          message: '$e',
        ),
        data: (lista) {
          if (lista.isEmpty) {
            return const EmptyState(
              icon: Icons.receipt_long_outlined,
              title: 'Aún no hay impuestos registrados',
              message: 'Toca "Nuevo impuesto" para registrar el primero.',
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
            itemCount: lista.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final i = lista[index];
              final vencido = i.estado == ImpuestoEstado.pendiente &&
                  i.fechaVencimiento.isBefore(DateTime.now());
              return Card(
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => ImpuestoFormScreen(impuesto: i)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        const Icon(Icons.receipt_long_outlined),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${etiquetaImpuestoTipo(i.tipo)} · ${i.periodo}',
                                style: theme.textTheme.titleMedium,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Vence ${i.fechaVencimiento.day}/${i.fechaVencimiento.month}/${i.fechaVencimiento.year}'
                                ' · S/ ${i.monto.toStringAsFixed(2)}',
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        StatusChip(
                          label: vencido ? 'Vencido' : etiquetaImpuestoEstado(i.estado),
                          tone: i.estado == ImpuestoEstado.pagado
                              ? StatusTone.success
                              : (vencido ? StatusTone.error : StatusTone.warning),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () async {
                            final ok = await confirmarEliminar(
                              context,
                              'Se quitará este impuesto (${etiquetaImpuestoTipo(i.tipo)} · ${i.periodo}).',
                            );
                            if (ok) {
                              await ref.read(impuestosRepositoryProvider).eliminar(i.id);
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
