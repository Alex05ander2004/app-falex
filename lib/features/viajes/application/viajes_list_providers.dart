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
