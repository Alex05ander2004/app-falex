import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../data/trabajadores_repository.dart';

/// Texto de búsqueda libre (nombre o DNI) sobre la lista de trabajadores.
final trabajadoresBusquedaProvider = StateProvider<String>((ref) => '');

/// `null` = todos, `true` = solo activos, `false` = solo inactivos.
final trabajadoresSoloActivosProvider = StateProvider<bool?>((ref) => true);

final _trabajadoresStreamProvider =
    StreamProvider.autoDispose<List<Trabajador>>((ref) {
  final soloActivos = ref.watch(trabajadoresSoloActivosProvider);
  return ref.watch(trabajadoresRepositoryProvider).watchAll(
        soloActivos: soloActivos,
      );
});

/// Lista ya filtrada por el texto de búsqueda — lista para pintar.
final trabajadoresListadoProvider =
    Provider.autoDispose<AsyncValue<List<Trabajador>>>((ref) {
  final busqueda = ref.watch(trabajadoresBusquedaProvider).trim().toLowerCase();
  final asyncTrabajadores = ref.watch(_trabajadoresStreamProvider);

  return asyncTrabajadores.whenData((trabajadores) {
    if (busqueda.isEmpty) return trabajadores;
    return trabajadores
        .where((t) =>
            t.nombre.toLowerCase().contains(busqueda) ||
            t.dni.contains(busqueda))
        .toList();
  });
});
