import 'package:drift/drift.dart';

import 'viajes_table.dart';

/// Fletes cobrados a KR y otros ingresos — ligados o no a un viaje puntual.
class Ingresos extends Table {
  IntColumn get id => integer().autoIncrement()();

  RealColumn get monto => real()();
  DateTimeColumn get fecha => dateTime()();
  TextColumn get concepto => text()();

  IntColumn get viajeId =>
      integer().nullable().references(Viajes, #id)();

  /// Ruta local a la foto de la boleta/factura, si se adjuntó una.
  TextColumn get comprobantePath => text().nullable()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => ['CHECK (monto > 0)'];
}
