import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqlite3/sqlite3.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/database/enums.dart';
import '../../../core/errors/app_exceptions.dart';
import '../../../core/finance/detraccion.dart';
import '../../../core/finance/igv.dart';

final ingresosRepositoryProvider = Provider<IngresosRepository>(
  (ref) => IngresosRepository(ref.watch(appDatabaseProvider)),
);

/// Fletes cobrados a KR y otros ingresos — ligados o no a un viaje
/// puntual (Fase 4).
class IngresosRepository {
  IngresosRepository(this._db);
  final AppDatabase _db;

  Stream<List<Ingreso>> watchPorViaje(int viajeId) {
    return (_db.select(_db.ingresos)
          ..where((i) => i.viajeId.equals(viajeId))
          ..orderBy([(i) => OrderingTerm.desc(i.fecha)]))
        .watch();
  }

  /// Todos los ingresos, ligados o no a un viaje — para la sección de
  /// Finanzas.
  Stream<List<Ingreso>> watchAll() {
    return (_db.select(_db.ingresos)
          ..orderBy([(i) => OrderingTerm.desc(i.fecha)]))
        .watch();
  }

  /// La detracción y el IGV de débito no los elige quien registra el
  /// ingreso — se calculan acá, siempre, para que nadie olvide
  /// registrar un flete sin ellos (ver core/finance/detraccion.dart y
  /// core/finance/igv.dart).
  Future<int> crear(IngresosCompanion data) async {
    try {
      return await _db.into(_db.ingresos).insert(_conCalculosFiscales(data));
    } on SqliteException catch (e) {
      throw _traducirError(e);
    }
  }

  Future<void> actualizar(int id, IngresosCompanion data) async {
    try {
      await (_db.update(_db.ingresos)..where((i) => i.id.equals(id))).write(
        _conCalculosFiscales(data).copyWith(updatedAt: Value(DateTime.now())),
      );
    } on SqliteException catch (e) {
      throw _traducirError(e);
    }
  }

  Future<void> eliminar(int id) =>
      (_db.delete(_db.ingresos)..where((i) => i.id.equals(id))).go();

  IngresosCompanion _conCalculosFiscales(IngresosCompanion data) {
    if (!data.concepto.present || !data.monto.present) return data;
    final esFlete = data.concepto.value == IngresoConcepto.flete;
    return data.copyWith(
      detraccion: Value(esFlete ? calcularDetraccion(data.monto.value) : 0),
      igvDebito: Value(esFlete ? calcularIgv(data.monto.value) : 0),
    );
  }

  Exception _traducirError(SqliteException e) {
    if (e.message.contains('CHECK')) {
      return const ValidacionNegocioException('El monto debe ser mayor a 0.');
    }
    return e;
  }
}
