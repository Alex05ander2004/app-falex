import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/enums.dart';
import '../data/viajes_repository.dart';
import '../domain/viaje_con_detalle.dart';

/// `null` = todos los estados.
final viajesFiltroEstadoProvider = StateProvider<ViajeEstado?>((ref) => null);

final viajesListadoProvider =
    StreamProvider.autoDispose<List<ViajeConDetalle>>((ref) {
  final filtro = ref.watch(viajesFiltroEstadoProvider);
  return ref
      .watch(viajesRepositoryProvider)
      .watchAllConDetalle(filtroEstado: filtro);
});

/// Todos los viajes, sin depender del filtro mutable de la pantalla de
/// lista — para selectores como el de vincular un ingreso/egreso general
/// a un viaje (Fase 4).
final viajesTodosProvider = StreamProvider.autoDispose<List<ViajeConDetalle>>((ref) {
  return ref.watch(viajesRepositoryProvider).watchAllConDetalle();
});
