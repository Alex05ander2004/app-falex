import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'finanzas_filtros_providers.dart';

/// Ingresos netos (ya con detracción descontada) menos egresos menos
/// impuestos — de lo que quede después de aplicar el filtro activo de
/// Finanzas (Fase 6: mes, trabajador o vehículo). Sin filtro, es el
/// balance de toda la empresa. El balance por viaje (Fase 3) es un
/// recorte de este a un solo recorrido.
///
/// Los impuestos cuentan aunque sigan "pendientes" de pago: el objetivo
/// de esta pantalla es la rentabilidad real de la empresa, y un
/// impuesto ya generado es un costo del periodo se haya pagado o no.
final balanceGeneralProvider = Provider.autoDispose<double?>((ref) {
  final ingresos = ref.watch(ingresosFiltradosProvider).valueOrNull;
  final egresos = ref.watch(egresosFiltradosProvider).valueOrNull;
  final impuestos = ref.watch(impuestosFiltradosProvider).valueOrNull;
  if (ingresos == null || egresos == null || impuestos == null) return null;
  final totalIngresosNetos =
      ingresos.fold<double>(0, (sum, i) => sum + (i.monto - i.detraccion));
  final totalEgresos = egresos.fold<double>(0, (sum, e) => sum + e.monto);
  final totalImpuestos = impuestos.fold<double>(0, (sum, i) => sum + i.monto);
  return totalIngresosNetos - totalEgresos - totalImpuestos;
});

/// IGV por pagar a SUNAT: débito fiscal (18% de cada flete) menos
/// crédito fiscal (18% de los gastos con factura con RUC) — ver
/// core/finance/igv.dart. Respeta el mismo filtro que [balanceGeneralProvider].
/// Puede dar negativo si el crédito acumulado supera al débito (crédito
/// a favor de la empresa).
final igvPorPagarProvider = Provider.autoDispose<double?>((ref) {
  final ingresos = ref.watch(ingresosFiltradosProvider).valueOrNull;
  final egresos = ref.watch(egresosFiltradosProvider).valueOrNull;
  if (ingresos == null || egresos == null) return null;
  final debito = ingresos.fold<double>(0, (sum, i) => sum + i.igvDebito);
  final credito = egresos.fold<double>(0, (sum, e) => sum + e.igvCredito);
  return debito - credito;
});
