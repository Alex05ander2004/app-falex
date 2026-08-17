import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../egresos/application/egresos_list_providers.dart';
import '../../ingresos/application/ingresos_list_providers.dart';

/// Todo el dinero de la empresa: ingresos netos (ya con detracción
/// descontada) de todos los viajes y movimientos generales, menos todos
/// los egresos. El balance por viaje (Fase 3) es un recorte de este.
final balanceGeneralProvider = Provider.autoDispose<double?>((ref) {
  final ingresos = ref.watch(ingresosGeneralesProvider).valueOrNull;
  final egresos = ref.watch(egresosGeneralesProvider).valueOrNull;
  if (ingresos == null || egresos == null) return null;
  final totalIngresosNetos =
      ingresos.fold<double>(0, (sum, i) => sum + (i.monto - i.detraccion));
  final totalEgresos = egresos.fold<double>(0, (sum, e) => sum + e.monto);
  return totalIngresosNetos - totalEgresos;
});

/// IGV por pagar a SUNAT: débito fiscal (18% de cada flete) menos
/// crédito fiscal (18% de los gastos con factura con RUC) — ver
/// core/finance/igv.dart. Puede dar negativo si el crédito acumulado
/// supera al débito (crédito a favor de la empresa).
final igvPorPagarProvider = Provider.autoDispose<double?>((ref) {
  final ingresos = ref.watch(ingresosGeneralesProvider).valueOrNull;
  final egresos = ref.watch(egresosGeneralesProvider).valueOrNull;
  if (ingresos == null || egresos == null) return null;
  final debito = ingresos.fold<double>(0, (sum, i) => sum + i.igvDebito);
  final credito = egresos.fold<double>(0, (sum, e) => sum + e.igvCredito);
  return debito - credito;
});
