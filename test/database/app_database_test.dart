import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:falex/core/database/app_database.dart';
import 'package:falex/core/database/enums.dart';

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
          VehiculosCompanion.insert(placa: 'FLX-001', tipo: 'Tractocamión'),
        );

    final viajeId = await db.into(db.viajes).insert(
          ViajesCompanion.insert(
            fechaSalida: DateTime(2026, 8, 14, 8),
            origen: 'Arequipa',
            destino: 'Lima',
            trabajadorId: trabajadorId,
            vehiculoId: vehiculoId,
          ),
        );

    final viaje = await (db.select(db.viajes)
          ..where((t) => t.id.equals(viajeId)))
        .getSingle();

    expect(viaje.estado, ViajeEstado.programado);
    expect(viaje.cliente, 'KR');
  });

  test('rechaza un viaje cuya llegada es anterior a la salida', () async {
    final trabajadorId = await db.into(db.trabajadores).insert(
          TrabajadoresCompanion.insert(nombre: 'Ana Silva', dni: '87654321'),
        );
    final vehiculoId = await db.into(db.vehiculos).insert(
          VehiculosCompanion.insert(placa: 'FLX-002', tipo: 'Remolque'),
        );

    expect(
      () => db.into(db.viajes).insert(
            ViajesCompanion.insert(
              fechaSalida: DateTime(2026, 8, 14, 8),
              fechaLlegada: Value(DateTime(2026, 8, 13, 8)),
              origen: 'Arequipa',
              destino: 'Lima',
              trabajadorId: trabajadorId,
              vehiculoId: vehiculoId,
            ),
          ),
      throwsA(anything),
    );
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
