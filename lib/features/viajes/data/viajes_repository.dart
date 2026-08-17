import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/database/enums.dart';
import '../../../core/errors/app_exceptions.dart';
import '../domain/viaje_con_detalle.dart';

final viajesRepositoryProvider = Provider<ViajesRepository>(
  (ref) => ViajesRepository(ref.watch(appDatabaseProvider)),
);

/// Entidad bisagra del modelo — ver Ruta Falex, sección 04. Única puerta
/// de entrada a `viajes` y `viaje_paradas`.
class ViajesRepository {
  ViajesRepository(this._db);
  final AppDatabase _db;

  Stream<List<Viaje>> watchAll({
    ViajeEstado? filtroEstado,
    int? trabajadorId,
    int? vehiculoId,
  }) {
    final query = _db.select(_db.viajes)
      ..orderBy([(v) => OrderingTerm.desc(v.fechaSalida)]);
    if (filtroEstado != null) {
      query.where((v) => v.estado.equalsValue(filtroEstado));
    }
    if (trabajadorId != null) {
      query.where((v) => v.trabajadorId.equals(trabajadorId));
    }
    if (vehiculoId != null) {
      query.where((v) => v.vehiculoId.equals(vehiculoId));
    }
    return query.watch();
  }

  Stream<Viaje?> watchPorId(int id) {
    return (_db.select(_db.viajes)..where((v) => v.id.equals(id)))
        .watchSingleOrNull();
  }

  /// Igual que [watchAll] pero con el trabajador y vehículo ya resueltos
  /// — evita que la lista tenga que ir a buscarlos fila por fila.
  Stream<List<ViajeConDetalle>> watchAllConDetalle({
    ViajeEstado? filtroEstado,
    int? trabajadorId,
    int? vehiculoId,
  }) {
    final query = _consultaConDetalle()
      ..orderBy([OrderingTerm.desc(_db.viajes.fechaSalida)]);
    if (filtroEstado != null) {
      query.where(_db.viajes.estado.equalsValue(filtroEstado));
    }
    if (trabajadorId != null) {
      query.where(_db.viajes.trabajadorId.equals(trabajadorId));
    }
    if (vehiculoId != null) {
      query.where(_db.viajes.vehiculoId.equals(vehiculoId));
    }
    return query.watch().map((rows) => rows.map(_leerFila).toList());
  }

  Stream<ViajeConDetalle?> watchDetallePorId(int id) {
    final query = _consultaConDetalle()..where(_db.viajes.id.equals(id));
    return query
        .watchSingleOrNull()
        .map((row) => row == null ? null : _leerFila(row));
  }

  JoinedSelectStatement<HasResultSet, dynamic> _consultaConDetalle() {
    return _db.select(_db.viajes).join([
      innerJoin(
        _db.trabajadores,
        _db.trabajadores.id.equalsExp(_db.viajes.trabajadorId),
      ),
      innerJoin(
        _db.vehiculos,
        _db.vehiculos.id.equalsExp(_db.viajes.vehiculoId),
      ),
    ]);
  }

  ViajeConDetalle _leerFila(TypedResult row) => ViajeConDetalle(
        viaje: row.readTable(_db.viajes),
        trabajador: row.readTable(_db.trabajadores),
        vehiculo: row.readTable(_db.vehiculos),
      );

  Future<int> crear(ViajesCompanion data) async {
    await _validarAsignaciones(
      trabajadorId: data.trabajadorId.value,
      vehiculoId: data.vehiculoId.value,
      viajeIdExcluir: null,
    );
    return _db.into(_db.viajes).insert(data);
  }

  Future<void> actualizar(int id, ViajesCompanion data) async {
    if (data.trabajadorId.present || data.vehiculoId.present) {
      await _validarAsignaciones(
        trabajadorId: data.trabajadorId.present ? data.trabajadorId.value : null,
        vehiculoId: data.vehiculoId.present ? data.vehiculoId.value : null,
        viajeIdExcluir: id,
      );
    }
    await (_db.update(_db.viajes)..where((v) => v.id.equals(id)))
        .write(data.copyWith(updatedAt: Value(DateTime.now())));
  }

  /// Borra el viaje junto con sus paradas, ingresos y egresos — no queda
  /// nada huérfano apuntando a un viaje que ya no existe.
  Future<void> eliminar(int id) async {
    await _db.transaction(() async {
      await (_db.delete(_db.viajeParadas)..where((p) => p.viajeId.equals(id))).go();
      await (_db.delete(_db.ingresos)..where((i) => i.viajeId.equals(id))).go();
      await (_db.delete(_db.egresos)..where((e) => e.viajeId.equals(id))).go();
      await (_db.delete(_db.viajes)..where((v) => v.id.equals(id))).go();
    });
  }

  /// Cuenta cuántos ingresos, egresos y paradas se perderían si se borra
  /// este viaje — para poder avisarle al usuario antes de confirmar.
  Future<({int ingresos, int egresos, int paradas})> contarDependientes(
    int viajeId,
  ) async {
    final ingresos = await (_db.select(_db.ingresos)
          ..where((i) => i.viajeId.equals(viajeId)))
        .get();
    final egresos = await (_db.select(_db.egresos)
          ..where((e) => e.viajeId.equals(viajeId)))
        .get();
    final paradas = await (_db.select(_db.viajeParadas)
          ..where((p) => p.viajeId.equals(viajeId)))
        .get();
    return (ingresos: ingresos.length, egresos: egresos.length, paradas: paradas.length);
  }

  /// Cambia el estado del viaje. Al finalizar, exige la fecha de llegada.
  Future<void> cambiarEstado(
    int id,
    ViajeEstado estado, {
    DateTime? fechaLlegada,
  }) async {
    await (_db.update(_db.viajes)..where((v) => v.id.equals(id))).write(
      ViajesCompanion(
        estado: Value(estado),
        fechaLlegada: estado == ViajeEstado.finalizado
            ? Value(fechaLlegada ?? DateTime.now())
            : const Value.absent(),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> _validarAsignaciones({
    int? trabajadorId,
    int? vehiculoId,
    required int? viajeIdExcluir,
  }) async {
    if (trabajadorId != null) {
      final trabajador = await (_db.select(_db.trabajadores)
            ..where((t) => t.id.equals(trabajadorId)))
          .getSingle();
      if (!trabajador.activo) {
        throw const ValidacionNegocioException(
          'Este trabajador está de baja — no se le puede asignar un viaje.',
        );
      }
      final otroViajeDelTrabajador = await _buscarViajeActivo(
        trabajadorId: trabajadorId,
        viajeIdExcluir: viajeIdExcluir,
      );
      if (otroViajeDelTrabajador != null) {
        throw ValidacionNegocioException(
          '${trabajador.nombre} ya está asignado a otro viaje programado o '
          'en curso (#${otroViajeDelTrabajador.id}). Finalízalo o cancélalo '
          'antes de asignarle uno nuevo.',
        );
      }
    }
    if (vehiculoId != null) {
      final vehiculo = await (_db.select(_db.vehiculos)
            ..where((v) => v.id.equals(vehiculoId)))
          .getSingle();
      if (vehiculo.estado != VehiculoEstado.activo) {
        throw const ValidacionNegocioException(
          'Este vehículo no está activo — no se le puede asignar un viaje.',
        );
      }
      final otroViajeDelVehiculo = await _buscarViajeActivo(
        vehiculoId: vehiculoId,
        viajeIdExcluir: viajeIdExcluir,
      );
      if (otroViajeDelVehiculo != null) {
        throw ValidacionNegocioException(
          'La unidad ${vehiculo.placa} ya está asignada a otro viaje '
          'programado o en curso (#${otroViajeDelVehiculo.id}).',
        );
      }
    }
  }

  /// Un viaje "programado" o "en curso" con el mismo trabajador o vehículo
  /// — eso es un choque de agenda, no algo que la base deba permitir en
  /// silencio.
  Future<Viaje?> _buscarViajeActivo({
    int? trabajadorId,
    int? vehiculoId,
    required int? viajeIdExcluir,
  }) async {
    final query = _db.select(_db.viajes)
      ..where((v) =>
          (v.estado.equalsValue(ViajeEstado.programado) |
              v.estado.equalsValue(ViajeEstado.enCurso)));
    if (trabajadorId != null) {
      query.where((v) => v.trabajadorId.equals(trabajadorId));
    }
    if (vehiculoId != null) {
      query.where((v) => v.vehiculoId.equals(vehiculoId));
    }
    final coincidencias = await query.get();
    final choque = coincidencias.where((v) => v.id != viajeIdExcluir);
    return choque.isEmpty ? null : choque.first;
  }

  // ---------- Paradas extra ----------

  Stream<List<ViajeParada>> watchParadas(int viajeId) {
    return (_db.select(_db.viajeParadas)
          ..where((p) => p.viajeId.equals(viajeId))
          ..orderBy([(p) => OrderingTerm(expression: p.fechaSalida)]))
        .watch();
  }

  /// Agrega una provincia extra a la que se extendió el viaje. No puede
  /// partir antes de que el viaje siquiera haya salido de Arequipa.
  Future<void> agregarParada({
    required int viajeId,
    required String provincia,
    required DateTime fechaSalida,
  }) async {
    final viaje = await (_db.select(_db.viajes)
          ..where((v) => v.id.equals(viajeId)))
        .getSingle();
    if (fechaSalida.isBefore(viaje.fechaSalida)) {
      throw const ValidacionNegocioException(
        'La fecha de salida a la provincia extra no puede ser anterior a '
        'la salida del viaje.',
      );
    }
    await _db.into(_db.viajeParadas).insert(
          ViajeParadasCompanion.insert(
            viajeId: viajeId,
            provincia: provincia,
            fechaSalida: fechaSalida,
          ),
        );
  }

  Future<void> eliminarParada(int id) =>
      (_db.delete(_db.viajeParadas)..where((p) => p.id.equals(id))).go();
}
