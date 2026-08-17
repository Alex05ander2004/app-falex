import 'package:drift/drift.dart';

import '../enums.dart';
import 'viajes_table.dart';

/// Fletes cobrados a KR y otros ingresos — ligados o no a un viaje puntual.
class Ingresos extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Monto bruto, el que figura en la factura — no lo que realmente
  /// entra a la cuenta si es un flete (ver [detraccion]).
  RealColumn get monto => real()();
  DateTimeColumn get fecha => dateTime()();
  IntColumn get concepto => intEnum<IngresoConcepto>()();

  /// Se va directo a la cuenta de detracciones, nunca a la cuenta
  /// corriente. 0 salvo que [concepto] sea `flete` — ver
  /// core/finance/detraccion.dart.
  RealColumn get detraccion =>
      real().withDefault(const Constant(0))();

  /// Débito fiscal de IGV (18% de un flete) — se acumula como IGV por
  /// pagar a SUNAT. 0 salvo que [concepto] sea `flete` — ver
  /// core/finance/igv.dart.
  RealColumn get igvDebito => real().withDefault(const Constant(0))();

  /// Número de factura del flete, para ubicarla físicamente después.
  TextColumn get numeroFactura => text().nullable()();

  /// A qué destino corresponde este flete: el destino principal del
  /// viaje o una de sus paradas extra — un viaje puede cobrar un flete
  /// distinto por cada tramo. Solo aplica cuando [concepto] es `flete`.
  TextColumn get destinoFlete => text().nullable()();

  IntColumn get viajeId =>
      integer().nullable().references(Viajes, #id)();

  /// Ruta local a la foto de la boleta/factura, si se adjuntó una.
  TextColumn get comprobantePath => text().nullable()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => [
        'CHECK (monto > 0)',
        'CHECK (detraccion >= 0 AND detraccion <= monto)',
        'CHECK (igv_debito >= 0)',
      ];
}
