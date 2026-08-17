import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqlite3/sqlite3.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/database/enums.dart';
import '../../../core/errors/app_exceptions.dart';

final impuestosRepositoryProvider = Provider<ImpuestosRepository>(
  (ref) => ImpuestosRepository(ref.watch(appDatabaseProvider)),
);

/// Obligaciones tributarias por periodo — Ruta Falex, Fase 5.
class ImpuestosRepository {
  ImpuestosRepository(this._db);
  final AppDatabase _db;

  Stream<List<Impuesto>> watchAll() {
    return (_db.select(_db.impuestos)
          ..orderBy([(i) => OrderingTerm(expression: i.fechaVencimiento)]))
        .watch();
  }

  Future<int> crear(ImpuestosCompanion data) async {
    try {
      return await _db.into(_db.impuestos).insert(data);
    } on SqliteException catch (e) {
      throw _traducirError(e);
    }
  }

  Future<void> actualizar(int id, ImpuestosCompanion data) async {
    try {
      await (_db.update(_db.impuestos)..where((i) => i.id.equals(id)))
          .write(data.copyWith(updatedAt: Value(DateTime.now())));
    } on SqliteException catch (e) {
      throw _traducirError(e);
    }
  }

  Future<void> marcarComoPagado(
    int id, {
    required DateTime fechaPago,
    String? comprobantePath,
  }) {
    return (_db.update(_db.impuestos)..where((i) => i.id.equals(id))).write(
      ImpuestosCompanion(
        estado: const Value(ImpuestoEstado.pagado),
        fechaPago: Value(fechaPago),
        comprobantePath: Value(comprobantePath),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> eliminar(int id) =>
      (_db.delete(_db.impuestos)..where((i) => i.id.equals(id))).go();

  Exception _traducirError(SqliteException e) {
    if (e.message.contains('CHECK') && e.message.contains('monto')) {
      return const ValidacionNegocioException('El monto debe ser mayor a 0.');
    }
    if (e.message.contains('CHECK') && e.message.contains('fecha_vencimiento')) {
      return const ValidacionNegocioException(
        'La fecha de vencimiento debe ser posterior a hoy.',
      );
    }
    return e;
  }
}
