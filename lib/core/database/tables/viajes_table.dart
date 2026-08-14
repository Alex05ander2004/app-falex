import 'package:drift/drift.dart';

import '../enums.dart';
import 'trabajadores_table.dart';
import 'vehiculos_table.dart';

/// Entidad bisagra del modelo: conecta a quién manejó, en qué unidad,
/// y qué ingresos/egresos generó ese recorrido — ver Ruta Falex, sección 04.
class Viajes extends Table {
  IntColumn get id => integer().autoIncrement()();

  DateTimeColumn get fechaSalida => dateTime()();

  /// Nula mientras el viaje no haya terminado.
  DateTimeColumn get fechaLlegada => dateTime().nullable()();

  TextColumn get origen => text()();
  TextColumn get destino => text()();
  TextColumn get cliente => text().withDefault(const Constant('KR'))();
  TextColumn get carga => text().nullable()();
  RealColumn get kilometraje => real().nullable()();

  IntColumn get trabajadorId =>
      integer().references(Trabajadores, #id)();
  IntColumn get vehiculoId => integer().references(Vehiculos, #id)();

  IntColumn get estado => intEnum<ViajeEstado>()
      .withDefault(Constant(ViajeEstado.programado.index))();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => [
        // Si ya hay fecha de llegada, no puede ser anterior a la salida.
        'CHECK (fecha_llegada IS NULL OR fecha_llegada >= fecha_salida)',
      ];
}
