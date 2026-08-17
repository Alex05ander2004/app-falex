import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqlite3/sqlite3.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/database/enums.dart';
import '../../../core/errors/app_exceptions.dart';
import '../../../core/finance/detraccion.dart';

final ingresosRepositoryProvider = Provider<IngresosRepository>(
  (ref) => IngresosRepository(ref.watch(appDatabaseProvider)),
);

/// Fletes cobrados a KR y otros ingresos. En la Fase 3 solo se usa desde
/// el detalle de un viaje; la pantalla de ingresos generales (ligados o
/// no a un viaje) llega en la Fase 4.
class IngresosRepository {
  IngresosRepository(this._db);
  final AppDatabase _db;

  Stream<List<Ingreso>> watchPorViaje(int viajeId) {
    return (_db.select(_db.ingresos)
          ..where((i) => i.viajeId.equals(viajeId))
          ..orderBy([(i) => OrderingTerm.desc(i.fecha)]))
        .watch();
  }

  /// La detracción no la elige quien registra el ingreso — se calcula
  /// acá, siempre, para que nadie pueda registrar un flete sin ella por
  /// olvido (ver core/finance/detraccion.dart).
  Future<int> crear(IngresosCompanion data) async {
    final esFlete = data.concepto.value == IngresoConcepto.flete;
    final dataConDetraccion = data.copyWith(
      detraccion: Value(esFlete ? calcularDetraccion(data.monto.value) : 0),
    );
    try {
      return await _db.into(_db.ingresos).insert(dataConDetraccion);
    } on SqliteException catch (e) {
      throw _traducirError(e);
    }
  }

  Future<void> eliminar(int id) =>
      (_db.delete(_db.ingresos)..where((i) => i.id.equals(id))).go();

  Exception _traducirError(SqliteException e) {
    if (e.message.contains('CHECK')) {
      return const ValidacionNegocioException('El monto debe ser mayor a 0.');
    }
    return e;
  }
}
