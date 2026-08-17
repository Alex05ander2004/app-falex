import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/enum_labels.dart';
import '../../../core/database/enums.dart';
import '../../../core/widgets/empty_state.dart';
import '../application/viajes_list_providers.dart';
import '../data/viajes_repository.dart';
import 'viaje_detalle_screen.dart';
import 'viaje_form_screen.dart';
import 'widgets/viaje_card.dart';

class ViajesListScreen extends ConsumerWidget {
  const ViajesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listado = ref.watch(viajesListadoProvider);
    final filtro = ref.watch(viajesFiltroEstadoProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Viajes')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const ViajeFormScreen()),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Nuevo viaje'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              children: [
                _FiltroChip(
                  label: 'Todos',
                  selected: filtro == null,
                  onTap: () =>
                      ref.read(viajesFiltroEstadoProvider.notifier).state = null,
                ),
                for (final estado in ViajeEstado.values) ...[
                  const SizedBox(width: 8),
                  _FiltroChip(
                    label: etiquetaViajeEstado(estado),
                    selected: filtro == estado,
                    onTap: () => ref
                        .read(viajesFiltroEstadoProvider.notifier)
                        .state = estado,
                  ),
                ],
              ],
            ),
          ),
          Expanded(
            child: listado.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => EmptyState(
                icon: Icons.error_outline,
                title: 'No se pudo cargar la lista',
                message: '$error',
              ),
              data: (viajes) {
                if (viajes.isEmpty) {
                  return const EmptyState(
                    icon: Icons.local_shipping_outlined,
                    title: 'Aún no hay viajes aquí',
                    message: 'Toca "Nuevo viaje" para registrar el primero.',
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 96),
                  itemCount: viajes.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final item = viajes[index];
                    return ViajeCard(
                      item: item,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              ViajeDetalleScreen(viajeId: item.viaje.id),
                        ),
                      ),
                      onMarcarTerminado: puedeMarcarseTerminado(item.viaje.estado)
                          ? () => _marcarTerminado(context, ref, item.viaje)
                          : null,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Un viaje se marca como terminado a mano — nada lo detecta solo. Pide
/// la fecha de llegada porque queda registrada en el viaje.
Future<void> _marcarTerminado(
  BuildContext context,
  WidgetRef ref,
  Viaje viaje,
) async {
  final fechaLlegada = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: viaje.fechaSalida,
    lastDate: DateTime(2100),
  );
  if (fechaLlegada == null) return;
  await ref
      .read(viajesRepositoryProvider)
      .cambiarEstado(viaje.id, ViajeEstado.finalizado, fechaLlegada: fechaLlegada);
}

class _FiltroChip extends StatelessWidget {
  const _FiltroChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
    );
  }
}
