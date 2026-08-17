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

  /// Si el gasto tiene factura con el RUC de Falex, genera crédito
  /// fiscal de IGV — un gasto en efectivo sin comprobante válido no
  /// califica ante SUNAT, así que no lo genera.
  BoolColumn get tieneFacturaConRuc =>
      boolean().withDefault(const Constant(false))();

  /// Crédito fiscal de IGV (18% del gasto) — reduce el IGV por pagar.
  /// 0 salvo que [tieneFacturaConRuc] sea verdadero — ver
  /// core/finance/igv.dart.
  RealColumn get igvCredito => real().withDefault(const Constant(0))();

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
  List<String> get customConstraints => [
        'CHECK (monto > 0)',
        'CHECK (igv_credito >= 0)',
      ];
}
