import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/enum_labels.dart';
import '../../../core/database/enums.dart';
import '../data/vehiculos_repository.dart';

final vehiculosBusquedaProvider = StateProvider<String>((ref) => '');

/// `null` = todos los estados.
final vehiculosFiltroEstadoProvider =
    StateProvider<VehiculoEstado?>((ref) => null);

final _vehiculosStreamProvider =
    StreamProvider.autoDispose<List<Vehiculo>>((ref) {
  final filtro = ref.watch(vehiculosFiltroEstadoProvider);
  return ref.watch(vehiculosRepositoryProvider).watchAll(filtro: filtro);
});

final vehiculosListadoProvider =
    Provider.autoDispose<AsyncValue<List<Vehiculo>>>((ref) {
  final busqueda = ref.watch(vehiculosBusquedaProvider).trim().toLowerCase();
  final asyncVehiculos = ref.watch(_vehiculosStreamProvider);

  return asyncVehiculos.whenData((vehiculos) {
    if (busqueda.isEmpty) return vehiculos;
    return vehiculos
        .where((v) =>
            v.placa.toLowerCase().contains(busqueda) ||
            etiquetaTipoVehiculo(v.tipo).toLowerCase().contains(busqueda))
        .toList();
  });
});

/// Vehículos con SOAT o revisión técnica vencidos o por vencer en los
/// próximos 30 días — alimenta el aviso en la lista (ver design/stitch:
/// "Doc. por Vencer").
final vehiculosDocumentosPorVencerProvider =
    Provider.autoDispose<AsyncValue<int>>((ref) {
  final limite = DateTime.now().add(const Duration(days: 30));
  return ref.watch(_vehiculosStreamProvider).whenData((vehiculos) {
    return vehiculos.where((v) {
      final soat = v.soatVencimiento;
      final revision = v.revisionTecnicaVencimiento;
      return (soat != null && soat.isBefore(limite)) ||
          (revision != null && revision.isBefore(limite));
    }).length;
  });
});
