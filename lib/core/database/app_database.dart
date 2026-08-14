import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'enums.dart';
import 'tables/egresos_table.dart';
import 'tables/impuestos_table.dart';
import 'tables/ingresos_table.dart';
import 'tables/trabajadores_table.dart';
import 'tables/vehiculos_table.dart';
import 'tables/viajes_table.dart';

part 'app_database.g.dart';

/// Base de datos local de Falex: SQLite vía Drift, sin backend — vive
/// 100% en el teléfono, funciona igual con o sin señal (ver Ruta Falex,
/// secciones 01 y 05). Cada feature habla con esta base solo a través
/// de un repositorio (Fase 2+), nunca directo desde la UI.
@DriftDatabase(
  tables: [Trabajadores, Vehiculos, Viajes, Ingresos, Egresos, Impuestos],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Constructor para pruebas: permite inyectar un [QueryExecutor] en
  /// memoria en vez de tocar disco.
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        // Las migraciones de esquemas futuros (nuevas columnas/tablas)
        // se agregan aquí como pasos de onUpgrade — nunca se reescribe
        // onCreate una vez publicada la app.
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'falex.sqlite'));
    return NativeDatabase.createInBackground(
      file,
      setup: (rawDb) {
        rawDb.execute('PRAGMA foreign_keys = ON;');
      },
    );
  });
}
