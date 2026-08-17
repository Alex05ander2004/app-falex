import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqlite3/sqlite3.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/database/enums.dart';
import '../../../core/errors/app_exceptions.dart';

final trabajadoresRepositoryProvider = Provider<TrabajadoresRepository>(
  (ref) => TrabajadoresRepository(ref.watch(appDatabaseProvider)),
);

/// Única puerta de entrada a la tabla `trabajadores` — la UI nunca
/// consulta Drift directamente (ver Ruta Falex, sección 05, Arquitectura).
class TrabajadoresRepository {
  TrabajadoresRepository(this._db);
  final AppDatabase _db;

  Stream<List<Trabajador>> watchAll({bool? soloActivos}) {
    final query = _db.select(_db.trabajadores)
      ..orderBy([(t) => OrderingTerm(expression: t.nombre)]);
    if (soloActivos != null) {
      query.where((t) => t.activo.equals(soloActivos));
    }
    return query.watch();
  }

  Future<int> crear(TrabajadoresCompanion data) async {
    try {
      return await _db.into(_db.trabajadores).insert(data);
    } on SqliteException catch (e) {
      throw _traducirError(e);
    }
  }

  Future<void> actualizar(int id, TrabajadoresCompanion data) async {
    try {
      await (_db.update(_db.trabajadores)..where((t) => t.id.equals(id)))
          .write(data.copyWith(updatedAt: Value(DateTime.now())));
    } on SqliteException catch (e) {
      throw _traducirError(e);
    }
  }

  /// Da de alta o de baja a un trabajador. Antes de dar de baja, verifica
  /// que no tenga viajes programados o en curso — regla de negocio, no
  /// una restricción de la base de datos.
  Future<void> cambiarActivo(int id, bool activo) async {
    if (!activo) {
      final viajesDelTrabajador = await (_db.select(_db.viajes)
            ..where((v) => v.trabajadorId.equals(id)))
          .get();
      final activos = viajesDelTrabajador.where(
        (v) =>
            v.estado == ViajeEstado.programado ||
            v.estado == ViajeEstado.enCurso,
      );
      if (activos.isNotEmpty) {
        throw ValidacionNegocioException(
          'Este trabajador tiene ${activos.length} viaje(s) programado(s) o '
          'en curso. Finalízalos o reasígnalos antes de darlo de baja.',
        );
      }
    }
    await (_db.update(_db.trabajadores)..where((t) => t.id.equals(id))).write(
      TrabajadoresCompanion(
        activo: Value(activo),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Borra el registro por completo — solo si nunca tuvo un viaje, para
  /// no perder historial real. Si ya tiene viajes, solo cabe la baja
  /// lógica de [cambiarActivo].
  Future<void> eliminar(int id) async {
    final viajesDelTrabajador = await (_db.select(_db.viajes)
          ..where((v) => v.trabajadorId.equals(id)))
        .get();
    if (viajesDelTrabajador.isNotEmpty) {
      throw ValidacionNegocioException(
        'Este trabajador tiene ${viajesDelTrabajador.length} viaje(s) en su '
        'historial — no se puede eliminar, solo dar de baja.',
      );
    }
    await (_db.delete(_db.trabajadores)..where((t) => t.id.equals(id))).go();
  }

  Exception _traducirError(SqliteException e) {
    if (e.message.contains('UNIQUE') && e.message.contains('dni')) {
      return const RegistroDuplicadoException(
        'Ya existe un trabajador con ese DNI.',
      );
    }
    return e;
  }
}
