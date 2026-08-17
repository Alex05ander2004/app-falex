import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqlite3/sqlite3.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/errors/app_exceptions.dart';
import '../../../core/finance/igv.dart';

final egresosRepositoryProvider = Provider<EgresosRepository>(
  (ref) => EgresosRepository(ref.watch(appDatabaseProvider)),
);

/// Combustible, peajes, viáticos, mantenimiento, multas y otros — ligados
/// o no a un viaje, y opcionalmente a un vehículo (Fase 4).
class EgresosRepository {
  EgresosRepository(this._db);
  final AppDatabase _db;

  Stream<List<Egreso>> watchPorViaje(int viajeId) {
    return (_db.select(_db.egresos)
          ..where((e) => e.viajeId.equals(viajeId))
          ..orderBy([(e) => OrderingTerm.desc(e.fecha)]))
        .watch();
  }

  /// Todos los egresos, ligados o no a un viaje — para la sección de
  /// Finanzas.
  Stream<List<Egreso>> watchAll() {
    return (_db.select(_db.egresos)
          ..orderBy([(e) => OrderingTerm.desc(e.fecha)]))
        .watch();
  }

  /// El crédito fiscal no lo elige quien registra el gasto — se calcula
  /// acá según [EgresosCompanion.tieneFacturaConRuc] (ver
  /// core/finance/igv.dart).
  Future<int> crear(EgresosCompanion data) async {
    try {
      return await _db.into(_db.egresos).insert(_conCalculosFiscales(data));
    } on SqliteException catch (e) {
      throw _traducirError(e);
    }
  }

  Future<void> actualizar(int id, EgresosCompanion data) async {
    try {
      await (_db.update(_db.egresos)..where((e) => e.id.equals(id))).write(
        _conCalculosFiscales(data).copyWith(updatedAt: Value(DateTime.now())),
      );
    } on SqliteException catch (e) {
      throw _traducirError(e);
    }
  }

  Future<void> eliminar(int id) =>
      (_db.delete(_db.egresos)..where((e) => e.id.equals(id))).go();

  EgresosCompanion _conCalculosFiscales(EgresosCompanion data) {
    if (!data.monto.present) return data;
    final tieneFactura = data.tieneFacturaConRuc.present
        ? data.tieneFacturaConRuc.value
        : false;
    return data.copyWith(
      igvCredito: Value(tieneFactura ? calcularIgv(data.monto.value) : 0),
    );
  }

  Exception _traducirError(SqliteException e) {
    if (e.message.contains('CHECK')) {
      return const ValidacionNegocioException('El monto debe ser mayor a 0.');
    }
    return e;
  }
}
