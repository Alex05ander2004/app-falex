import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/empty_state.dart';
import '../application/trabajadores_list_providers.dart';
import 'trabajador_form_screen.dart';
import 'widgets/trabajador_card.dart';

class TrabajadoresListScreen extends ConsumerWidget {
  const TrabajadoresListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listado = ref.watch(trabajadoresListadoProvider);
    final soloActivos = ref.watch(trabajadoresSoloActivosProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Trabajadores')),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'fab_trabajadores',
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const TrabajadorFormScreen()),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Nuevo trabajador'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Buscar por nombre o DNI…',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) =>
                  ref.read(trabajadoresBusquedaProvider.notifier).state = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                _FiltroChip(
                  label: 'Activos',
                  selected: soloActivos == true,
                  onTap: () => ref
                      .read(trabajadoresSoloActivosProvider.notifier)
                      .state = true,
                ),
                const SizedBox(width: 8),
                _FiltroChip(
                  label: 'Inactivos',
                  selected: soloActivos == false,
                  onTap: () => ref
                      .read(trabajadoresSoloActivosProvider.notifier)
                      .state = false,
                ),
                const SizedBox(width: 8),
                _FiltroChip(
                  label: 'Todos',
                  selected: soloActivos == null,
                  onTap: () => ref
                      .read(trabajadoresSoloActivosProvider.notifier)
                      .state = null,
                ),
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
              data: (trabajadores) {
                if (trabajadores.isEmpty) {
                  return const EmptyState(
                    icon: Icons.people_outline,
                    title: 'Aún no hay trabajadores aquí',
                    message:
                        'Toca "Nuevo trabajador" para registrar al primer chofer.',
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 96),
                  itemCount: trabajadores.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final trabajador = trabajadores[index];
                    return TrabajadorCard(
                      trabajador: trabajador,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              TrabajadorFormScreen(trabajador: trabajador),
                        ),
                      ),
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
