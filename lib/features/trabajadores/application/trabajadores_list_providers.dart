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

/// Trabajadores activos, sin depender del filtro mutable de la pantalla
/// de lista — para selectores como el de la Fase 3 (asignar un viaje).
final trabajadoresActivosProvider =
    StreamProvider.autoDispose<List<Trabajador>>((ref) {
  return ref.watch(trabajadoresRepositoryProvider).watchAll(soloActivos: true);
});

/// Todos los trabajadores, activos e inactivos — para filtros históricos
/// como el de Finanzas (Fase 6), donde un trabajador ya dado de baja
/// puede seguir teniendo movimientos en su historial.
final trabajadoresTodosProvider = StreamProvider.autoDispose<List<Trabajador>>((ref) {
  return ref.watch(trabajadoresRepositoryProvider).watchAll();
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
