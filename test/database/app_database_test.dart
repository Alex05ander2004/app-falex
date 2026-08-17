import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:falex/core/database/app_database.dart';
import 'package:falex/core/database/enums.dart';
import 'package:falex/core/errors/app_exceptions.dart';
import 'package:falex/features/egresos/data/egresos_repository.dart';
import 'package:falex/features/impuestos/data/impuestos_repository.dart';
import 'package:falex/features/ingresos/data/ingresos_repository.dart';
import 'package:falex/features/trabajadores/data/trabajadores_repository.dart';
import 'package:falex/features/vehiculos/data/vehiculos_repository.dart';
import 'package:falex/features/viajes/data/viajes_repository.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() => db.close());

  test('crea un viaje ligado a un trabajador activo y un vehículo activo',
      () async {
    final trabajadorId = await db.into(db.trabajadores).insert(
          TrabajadoresCompanion.insert(
            nombre: 'Carlos Ruiz',
            dni: '12345678',
          ),
        );

    final vehiculoId = await db.into(db.vehiculos).insert(
          VehiculosCompanion.insert(placa: 'FLX001', tipo: VehiculoTipo.trailer),
        );

    final viajeId = await db.into(db.viajes).insert(
          ViajesCompanion.insert(
            fechaSalida: DateTime(2026, 8, 14, 8),
            destinoPrincipal: DestinoPrincipal.tacna,
            trabajadorId: trabajadorId,
            vehiculoId: vehiculoId,
          ),
        );

    final viaje = await (db.select(db.viajes)
          ..where((t) => t.id.equals(viajeId)))
        .getSingle();

    expect(viaje.estado, ViajeEstado.programado);
    expect(viaje.cliente, 'KR');
    expect(viaje.origen, 'Arequipa');
  });

  test('rechaza un viaje cuya llegada es anterior a la salida', () async {
    final trabajadorId = await db.into(db.trabajadores).insert(
          TrabajadoresCompanion.insert(nombre: 'Ana Silva', dni: '87654321'),
        );
    final vehiculoId = await db.into(db.vehiculos).insert(
          VehiculosCompanion.insert(placa: 'FLX002', tipo: VehiculoTipo.semitrailer),
        );

    expect(
      () => db.into(db.viajes).insert(
            ViajesCompanion.insert(
              fechaSalida: DateTime(2026, 8, 14, 8),
              fechaLlegada: Value(DateTime(2026, 8, 13, 8)),
              destinoPrincipal: DestinoPrincipal.tacna,
              trabajadorId: trabajadorId,
              vehiculoId: vehiculoId,
            ),
          ),
      throwsA(anything),
    );
  });

  test('rechaza una parada extra con fecha anterior a la salida del viaje',
      () async {
    final trabajadorId = await db.into(db.trabajadores).insert(
          TrabajadoresCompanion.insert(nombre: 'Luis Paco', dni: '11223344'),
        );
    final vehiculoId = await db.into(db.vehiculos).insert(
          VehiculosCompanion.insert(placa: 'FLX003', tipo: VehiculoTipo.trailer),
        );
    final viajeId = await db.into(db.viajes).insert(
          ViajesCompanion.insert(
            fechaSalida: DateTime(2026, 8, 14, 8),
            destinoPrincipal: DestinoPrincipal.tacna,
            trabajadorId: trabajadorId,
            vehiculoId: vehiculoId,
          ),
        );

    final repo = ViajesRepository(db);
    expect(
      () => repo.agregarParada(
        viajeId: viajeId,
        provincia: 'Puno',
        fechaSalida: DateTime(2026, 8, 13),
      ),
      throwsA(isA<ValidacionNegocioException>()),
    );
  });

  test('rechaza asignar un trabajador que ya tiene otro viaje en curso',
      () async {
    final trabajadorId = await db.into(db.trabajadores).insert(
          TrabajadoresCompanion.insert(nombre: 'Jorge Ticona', dni: '55667788'),
        );
    final vehiculo1 = await db.into(db.vehiculos).insert(
          VehiculosCompanion.insert(placa: 'FLX004', tipo: VehiculoTipo.trailer),
        );
    final vehiculo2 = await db.into(db.vehiculos).insert(
          VehiculosCompanion.insert(placa: 'FLX005', tipo: VehiculoTipo.trailer),
        );

    final repo = ViajesRepository(db);
    await repo.crear(
      ViajesCompanion.insert(
        fechaSalida: DateTime(2026, 8, 14, 8),
        destinoPrincipal: DestinoPrincipal.tacna,
        trabajadorId: trabajadorId,
        vehiculoId: vehiculo1,
      ),
    );

    expect(
      () => repo.crear(
        ViajesCompanion.insert(
          fechaSalida: DateTime(2026, 8, 15, 8),
          destinoPrincipal: DestinoPrincipal.moquegua,
          trabajadorId: trabajadorId,
          vehiculoId: vehiculo2,
        ),
      ),
      throwsA(isA<ValidacionNegocioException>()),
    );
  });

  test('eliminar un viaje también borra sus ingresos, egresos y paradas',
      () async {
    final trabajadorId = await db.into(db.trabajadores).insert(
          TrabajadoresCompanion.insert(nombre: 'Rosa Mamani', dni: '99887766'),
        );
    final vehiculoId = await db.into(db.vehiculos).insert(
          VehiculosCompanion.insert(placa: 'FLX006', tipo: VehiculoTipo.trailer),
        );
    final repo = ViajesRepository(db);
    final viajeId = await repo.crear(
      ViajesCompanion.insert(
        fechaSalida: DateTime(2026, 8, 14, 8),
        destinoPrincipal: DestinoPrincipal.tacna,
        trabajadorId: trabajadorId,
        vehiculoId: vehiculoId,
      ),
    );
    await db.into(db.ingresos).insert(
          IngresosCompanion.insert(
            monto: 500,
            fecha: DateTime(2026, 8, 14),
            concepto: IngresoConcepto.flete,
            viajeId: Value(viajeId),
          ),
        );

    await repo.eliminar(viajeId);

    final viajeRestante = await (db.select(db.viajes)
          ..where((v) => v.id.equals(viajeId)))
        .getSingleOrNull();
    final ingresosRestantes = await (db.select(db.ingresos)
          ..where((i) => i.viajeId.equals(viajeId)))
        .get();

    expect(viajeRestante, isNull);
    expect(ingresosRestantes, isEmpty);
  });

  test('elimina un trabajador que nunca tuvo un viaje', () async {
    final trabajadoresRepo = TrabajadoresRepository(db);
    final trabajadorId = await db.into(db.trabajadores).insert(
          TrabajadoresCompanion.insert(nombre: 'Sin Viajes', dni: '10101010'),
        );

    await trabajadoresRepo.eliminar(trabajadorId);

    final restante = await (db.select(db.trabajadores)
          ..where((t) => t.id.equals(trabajadorId)))
        .getSingleOrNull();
    expect(restante, isNull);
  });

  test('rechaza eliminar un trabajador con viajes en su historial', () async {
    final trabajadorId = await db.into(db.trabajadores).insert(
          TrabajadoresCompanion.insert(nombre: 'Con Viajes', dni: '20202020'),
        );
    final vehiculoId = await db.into(db.vehiculos).insert(
          VehiculosCompanion.insert(placa: 'FLX007', tipo: VehiculoTipo.trailer),
        );
    final viajesRepo = ViajesRepository(db);
    await viajesRepo.crear(
      ViajesCompanion.insert(
        fechaSalida: DateTime(2026, 8, 14, 8),
        destinoPrincipal: DestinoPrincipal.tacna,
        trabajadorId: trabajadorId,
        vehiculoId: vehiculoId,
      ),
    );

    final trabajadoresRepo = TrabajadoresRepository(db);
    expect(
      () => trabajadoresRepo.eliminar(trabajadorId),
      throwsA(isA<ValidacionNegocioException>()),
    );
  });

  test('rechaza eliminar un vehículo con viajes en su historial', () async {
    final trabajadorId = await db.into(db.trabajadores).insert(
          TrabajadoresCompanion.insert(nombre: 'Chofer X', dni: '30303030'),
        );
    final vehiculoId = await db.into(db.vehiculos).insert(
          VehiculosCompanion.insert(placa: 'FLX008', tipo: VehiculoTipo.trailer),
        );
    final viajesRepo = ViajesRepository(db);
    await viajesRepo.crear(
      ViajesCompanion.insert(
        fechaSalida: DateTime(2026, 8, 14, 8),
        destinoPrincipal: DestinoPrincipal.tacna,
        trabajadorId: trabajadorId,
        vehiculoId: vehiculoId,
      ),
    );

    final vehiculosRepo = VehiculosRepository(db);
    expect(
      () => vehiculosRepo.eliminar(vehiculoId),
      throwsA(isA<ValidacionNegocioException>()),
    );
  });

  test('calcula la detracción del 4% al registrar un flete', () async {
    final repo = IngresosRepository(db);
    final ingresoId = await repo.crear(
      IngresosCompanion.insert(
        monto: 1000,
        fecha: DateTime(2026, 8, 14),
        concepto: IngresoConcepto.flete,
        numeroFactura: const Value('F001-123'),
      ),
    );

    final ingreso = await (db.select(db.ingresos)
          ..where((i) => i.id.equals(ingresoId)))
        .getSingle();

    expect(ingreso.detraccion, 40);
    expect(ingreso.monto - ingreso.detraccion, 960);
  });

  test('no aplica detracción a un ingreso que no es flete', () async {
    final repo = IngresosRepository(db);
    final ingresoId = await repo.crear(
      IngresosCompanion.insert(
        monto: 300,
        fecha: DateTime(2026, 8, 14),
        concepto: IngresoConcepto.otro,
      ),
    );

    final ingreso = await (db.select(db.ingresos)
          ..where((i) => i.id.equals(ingresoId)))
        .getSingle();

    expect(ingreso.detraccion, 0);
  });

  test('calcula el IGV débito del 18% en un flete', () async {
    final repo = IngresosRepository(db);
    final ingresoId = await repo.crear(
      IngresosCompanion.insert(
        monto: 2000,
        fecha: DateTime(2026, 8, 14),
        concepto: IngresoConcepto.flete,
      ),
    );

    final ingreso = await (db.select(db.ingresos)
          ..where((i) => i.id.equals(ingresoId)))
        .getSingle();

    expect(ingreso.igvDebito, 360);
  });

  test('calcula el credito fiscal de IGV solo si el gasto tiene factura con RUC',
      () async {
    final repo = EgresosRepository(db);

    final conFacturaId = await repo.crear(
      EgresosCompanion.insert(
        monto: 500,
        fecha: DateTime(2026, 8, 14),
        categoria: EgresoCategoria.mantenimiento,
        tieneFacturaConRuc: const Value(true),
      ),
    );
    final sinFacturaId = await repo.crear(
      EgresosCompanion.insert(
        monto: 100,
        fecha: DateTime(2026, 8, 14),
        categoria: EgresoCategoria.viaticos,
      ),
    );

    final conFactura = await (db.select(db.egresos)
          ..where((e) => e.id.equals(conFacturaId)))
        .getSingle();
    final sinFactura = await (db.select(db.egresos)
          ..where((e) => e.id.equals(sinFacturaId)))
        .getSingle();

    expect(conFactura.igvCredito, 90);
    expect(sinFactura.igvCredito, 0);
  });

  test('crea un impuesto pendiente y lo marca como pagado', () async {
    final repo = ImpuestosRepository(db);
    final id = await repo.crear(
      ImpuestosCompanion.insert(
        tipo: ImpuestoTipo.igv,
        periodo: '2026-08',
        monto: 360,
        fechaVencimiento: DateTime.now().add(const Duration(days: 10)),
      ),
    );

    var impuesto =
        await (db.select(db.impuestos)..where((i) => i.id.equals(id))).getSingle();
    expect(impuesto.estado, ImpuestoEstado.pendiente);
    expect(impuesto.fechaPago, isNull);

    final fechaPago = DateTime.now();
    await repo.marcarComoPagado(id, fechaPago: fechaPago);

    impuesto =
        await (db.select(db.impuestos)..where((i) => i.id.equals(id))).getSingle();
    expect(impuesto.estado, ImpuestoEstado.pagado);
    expect(impuesto.fechaPago, isNotNull);
  });

  test('rechaza un egreso con monto <= 0', () async {
    expect(
      () => db.into(db.egresos).insert(
            EgresosCompanion.insert(
              monto: 0,
              fecha: DateTime(2026, 8, 14),
              categoria: EgresoCategoria.combustible,
            ),
          ),
      throwsA(anything),
    );
  });
}
