import 'package:drift/drift.dart';

import '../enums.dart';

/// Tractocamiones y remolques/trailers de Falex.
class Vehiculos extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Placa única — evita confundir dos unidades en un reporte.
  TextColumn get placa => text().withLength(min: 5, max: 10).unique()();

  TextColumn get tipo => text()(); // p.ej. "Tractocamión", "Remolque"
  TextColumn get marca => text().nullable()();
  TextColumn get modelo => text().nullable()();
  IntColumn get anio => integer().nullable()();

  DateTimeColumn get soatVencimiento => dateTime().nullable()();
  DateTimeColumn get revisionTecnicaVencimiento => dateTime().nullable()();

  IntColumn get estado => intEnum<VehiculoEstado>()
      .withDefault(Constant(VehiculoEstado.activo.index))();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}
