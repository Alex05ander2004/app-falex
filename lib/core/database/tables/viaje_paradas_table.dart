import 'package:drift/drift.dart';

import 'viajes_table.dart';

/// Provincia extra a la que se extiende un viaje ya en curso, más allá
/// de su [Viajes.destinoPrincipal] — caso excepcional, por eso la
/// provincia es texto libre y no está restringida a la lista principal.
class ViajeParadas extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get viajeId => integer().references(Viajes, #id)();

  TextColumn get provincia => text().withLength(min: 1, max: 120)();

  /// Día en que el viaje partió hacia esta provincia extra, desde el
  /// destino principal.
  DateTimeColumn get fechaSalida => dateTime()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}
