import 'package:drift/drift.dart';

import '../enums.dart';
import 'vehiculos_table.dart';
import 'viajes_table.dart';

/// Combustible, peajes, viáticos, mantenimiento, multas y otros —
/// ligados o no a un viaje, y opcionalmente a un vehículo (mantenimiento
/// fuera de un viaje puntual).
class Egresos extends Table {
  IntColumn get id => integer().autoIncrement()();

  RealColumn get monto => real()();
  DateTimeColumn get fecha => dateTime()();
  IntColumn get categoria => intEnum<EgresoCategoria>()();
  TextColumn get descripcion => text().nullable()();

  IntColumn get viajeId =>
      integer().nullable().references(Viajes, #id)();
  IntColumn get vehiculoId =>
      integer().nullable().references(Vehiculos, #id)();

  TextColumn get comprobantePath => text().nullable()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => ['CHECK (monto > 0)'];
}
