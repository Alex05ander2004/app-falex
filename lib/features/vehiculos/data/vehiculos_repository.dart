import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqlite3/sqlite3.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/database/enums.dart';
import '../../../core/errors/app_exceptions.dart';

final vehiculosRepositoryProvider = Provider<VehiculosRepository>(
  (ref) => VehiculosRepository(ref.watch(appDatabaseProvider)),
);

/// Única puerta de entrada a la tabla `vehiculos` — ver Ruta Falex,
/// sección 05, Arquitectura.
class VehiculosRepository {
  VehiculosRepository(this._db);
  final AppDatabase _db;

  Stream<List<Vehiculo>> watchAll({VehiculoEstado? filtro}) {
    final query = _db.select(_db.vehiculos)
      ..orderBy([(v) => OrderingTerm(expression: v.placa)]);
    if (filtro != null) {
      query.where((v) => v.estado.equalsValue(filtro));
    }
    return query.watch();
  }

  Future<int> crear(VehiculosCompanion data) async {
    try {
      return await _db.into(_db.vehiculos).insert(data);
    } on SqliteException catch (e) {
      throw _traducirError(e);
    }
  }

  Future<void> actualizar(int id, VehiculosCompanion data) async {
    try {
      await (_db.update(_db.vehiculos)..where((v) => v.id.equals(id)))
          .write(data.copyWith(updatedAt: Value(DateTime.now())));
    } on SqliteException catch (e) {
      throw _traducirError(e);
    }
  }

  /// Cambia el estado operativo. Si se saca de `activo` mientras hay un
  /// viaje en curso con este vehículo, se bloquea — no puede estar
  /// "en mantenimiento" y "en tránsito" a la vez.
  Future<void> cambiarEstado(int id, VehiculoEstado estado) async {
    if (estado != VehiculoEstado.activo) {
      final viajesDelVehiculo = await (_db.select(_db.viajes)
            ..where((v) => v.vehiculoId.equals(id)))
          .get();
      final enCurso =
          viajesDelVehiculo.where((v) => v.estado == ViajeEstado.enCurso);
      if (enCurso.isNotEmpty) {
        throw const ValidacionNegocioException(
          'Este vehículo tiene un viaje en curso. Espera a que finalice '
          'antes de cambiar su estado.',
        );
      }
    }
    await (_db.update(_db.vehiculos)..where((v) => v.id.equals(id))).write(
      VehiculosCompanion(
        estado: Value(estado),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Exception _traducirError(SqliteException e) {
    if (e.message.contains('UNIQUE') && e.message.contains('placa')) {
      return const RegistroDuplicadoException(
        'Ya existe un vehículo con esa placa.',
      );
    }
    return e;
  }
}
