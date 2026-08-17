import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqlite3/sqlite3.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/errors/app_exceptions.dart';

final egresosRepositoryProvider = Provider<EgresosRepository>(
  (ref) => EgresosRepository(ref.watch(appDatabaseProvider)),
);

/// Combustible, peajes, viáticos, mantenimiento, multas y otros. En la
/// Fase 3 solo se usa desde el detalle de un viaje ("registro rápido de
/// gasto"); la pantalla de egresos generales llega en la Fase 4.
class EgresosRepository {
  EgresosRepository(this._db);
  final AppDatabase _db;

  Stream<List<Egreso>> watchPorViaje(int viajeId) {
    return (_db.select(_db.egresos)
          ..where((e) => e.viajeId.equals(viajeId))
          ..orderBy([(e) => OrderingTerm.desc(e.fecha)]))
        .watch();
  }

  Future<int> crear(EgresosCompanion data) async {
    try {
      return await _db.into(_db.egresos).insert(data);
    } on SqliteException catch (e) {
      throw _traducirError(e);
    }
  }

  Future<void> eliminar(int id) =>
      (_db.delete(_db.egresos)..where((e) => e.id.equals(id))).go();

  Exception _traducirError(SqliteException e) {
    if (e.message.contains('CHECK')) {
      return const ValidacionNegocioException('El monto debe ser mayor a 0.');
    }
    return e;
  }
}
