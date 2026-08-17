import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../egresos/data/egresos_repository.dart';
import '../../ingresos/data/ingresos_repository.dart';
import '../data/viajes_repository.dart';
import '../domain/viaje_con_detalle.dart';

final viajeProvider =
    StreamProvider.autoDispose.family<ViajeConDetalle?, int>((ref, viajeId) {
  return ref.watch(viajesRepositoryProvider).watchDetallePorId(viajeId);
});

final viajeParadasProvider =
    StreamProvider.autoDispose.family<List<ViajeParada>, int>((ref, viajeId) {
  return ref.watch(viajesRepositoryProvider).watchParadas(viajeId);
});

final viajeIngresosProvider =
    StreamProvider.autoDispose.family<List<Ingreso>, int>((ref, viajeId) {
  return ref.watch(ingresosRepositoryProvider).watchPorViaje(viajeId);
});

final viajeEgresosProvider =
    StreamProvider.autoDispose.family<List<Egreso>, int>((ref, viajeId) {
  return ref.watch(egresosRepositoryProvider).watchPorViaje(viajeId);
});

/// Ingresos netos (ya con la detracción de cada flete descontada) menos
/// egresos de este viaje. `null` mientras cualquiera de los dos todavía
/// está cargando.
final viajeBalanceProvider =
    Provider.autoDispose.family<double?, int>((ref, viajeId) {
  final ingresos = ref.watch(viajeIngresosProvider(viajeId)).valueOrNull;
  final egresos = ref.watch(viajeEgresosProvider(viajeId)).valueOrNull;
  if (ingresos == null || egresos == null) return null;
  final totalIngresosNetos =
      ingresos.fold<double>(0, (sum, i) => sum + (i.monto - i.detraccion));
  final totalEgresos = egresos.fold<double>(0, (sum, e) => sum + e.monto);
  return totalIngresosNetos - totalEgresos;
});
