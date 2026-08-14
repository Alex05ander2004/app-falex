import 'package:drift/drift.dart';

/// Choferes y personal de Falex. Nunca se borra físicamente — ver
/// "Validaciones y manejo de errores" del plan — porque tiene historial
/// de viajes ligado; se da de baja con [activo] = false.
class Trabajadores extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get nombre => text().withLength(min: 1, max: 120)();

  /// DNI de 8 dígitos, único — evita duplicados y datos mal tipeados.
  TextColumn get dni => text().withLength(min: 8, max: 8).unique()();

  TextColumn get telefono => text().nullable()();

  TextColumn get cargo => text().withDefault(const Constant('Chofer'))();

  DateTimeColumn get fechaIngreso => dateTime().nullable()();

  BoolColumn get activo => boolean().withDefault(const Constant(true))();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}
