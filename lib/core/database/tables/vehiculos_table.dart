import 'package:drift/drift.dart';

import '../enums.dart';

/// Trailers y semitrailers de Falex.
class Vehiculos extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Placa única, de 6 caracteres (formato peruano) — evita confundir
  /// dos unidades en un reporte.
  TextColumn get placa => text().withLength(min: 6, max: 6).unique()();

  IntColumn get tipo => intEnum<VehiculoTipo>()();
  TextColumn get marca => text().nullable()();
  TextColumn get modelo => text().nullable()();
  IntColumn get anio => integer().nullable()();

  /// N.º de inscripción en el Registro Nacional de Transporte (MTC).
  TextColumn get numeroMtc => text().nullable()();

  /// Ayuda a identificar la unidad de un vistazo — opcional porque no
  /// siempre se conoce al registrarla.
  IntColumn get color => intEnum<VehiculoColor>().nullable()();

  DateTimeColumn get soatVencimiento => dateTime().nullable()();
  DateTimeColumn get revisionTecnicaVencimiento => dateTime().nullable()();

  IntColumn get estado => intEnum<VehiculoEstado>()
      .withDefault(Constant(VehiculoEstado.activo.index))();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}
