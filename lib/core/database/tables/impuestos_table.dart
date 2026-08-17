import 'package:drift/drift.dart';

import '../enums.dart';

/// Obligaciones tributarias por periodo — independiente de los viajes,
/// ver Ruta Falex, sección 04 (Impuesto queda fuera de la cadena Viaje).
class Impuestos extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get tipo => intEnum<ImpuestoTipo>()();
  TextColumn get periodo => text()(); // p.ej. "2026-08"
  RealColumn get monto => real()();

  DateTimeColumn get fechaVencimiento => dateTime()();
  DateTimeColumn get fechaPago => dateTime().nullable()();

  IntColumn get estado => intEnum<ImpuestoEstado>()
      .withDefault(Constant(ImpuestoEstado.pendiente.index))();

  TextColumn get comprobantePath => text().nullable()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => [
        'CHECK (monto > 0)',
        // El vencimiento debe quedar después de que se registra el impuesto,
        // para que el recordatorio de la Fase 5 tenga sentido.
        'CHECK (fecha_vencimiento > created_at)',
      ];
}
