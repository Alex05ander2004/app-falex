import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/empty_state.dart';
import '../application/vehiculos_list_providers.dart';
import 'vehiculo_form_screen.dart';
import 'widgets/vehiculo_card.dart';
import 'widgets/vehiculos_stats_row.dart';

class VehiculosListScreen extends ConsumerWidget {
  const VehiculosListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listado = ref.watch(vehiculosListadoProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Flota')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const VehiculoFormScreen()),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Añadir vehículo'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: VehiculosStatsRow(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Buscar por placa o tipo…',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) =>
                  ref.read(vehiculosBusquedaProvider.notifier).state = value,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: listado.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => EmptyState(
                icon: Icons.error_outline,
                title: 'No se pudo cargar la flota',
                message: '$error',
              ),
              data: (vehiculos) {
                if (vehiculos.isEmpty) {
                  return const EmptyState(
                    icon: Icons.local_shipping_outlined,
                    title: 'Aún no hay vehículos aquí',
                    message:
                        'Toca "Añadir vehículo" para registrar el primer tracto o remolque.',
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 96),
                  itemCount: vehiculos.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final vehiculo = vehiculos[index];
                    return VehiculoCard(
                      vehiculo: vehiculo,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => VehiculoFormScreen(vehiculo: vehiculo),
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
