import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../egresos/application/egresos_list_providers.dart';
import '../../impuestos/application/impuestos_list_providers.dart';
import '../../ingresos/application/ingresos_list_providers.dart';
import '../../viajes/application/viajes_list_providers.dart';
import '../../viajes/domain/viaje_con_detalle.dart';

/// `null` = todos los meses. Solo importan año y mes de este valor.
final finanzasMesFiltroProvider = StateProvider<DateTime?>((ref) => null);

/// `null` = todos los trabajadores.
final finanzasTrabajadorFiltroProvider = StateProvider<int?>((ref) => null);

/// `null` = todos los vehículos.
final finanzasVehiculoFiltroProvider = StateProvider<int?>((ref) => null);

bool _mismoMes(DateTime fecha, DateTime? mes) =>
    mes == null || (fecha.year == mes.year && fecha.month == mes.month);

/// Hay que resolver trabajador/vehículo a través del viaje ligado —
/// ingresos y egresos no guardan esos IDs directamente, salvo el
/// vehículo en egresos de mantenimiento. A esta escala de datos, cruzar
/// en Dart es más simple que armar el join en SQL.
Map<int, ViajeConDetalle> _mapaViajesPorId(List<ViajeConDetalle> viajes) => {
      for (final v in viajes) v.viaje.id: v,
    };

final ingresosFiltradosProvider =
    Provider.autoDispose<AsyncValue<List<Ingreso>>>((ref) {
  final ingresosAsync = ref.watch(ingresosGeneralesProvider);
  final viajes = ref.watch(viajesTodosProvider).valueOrNull ?? const [];
  final mapaViajes = _mapaViajesPorId(viajes);
  final mes = ref.watch(finanzasMesFiltroProvider);
  final trabajadorId = ref.watch(finanzasTrabajadorFiltroProvider);
  final vehiculoId = ref.watch(finanzasVehiculoFiltroProvider);

  return ingresosAsync.whenData((lista) {
    return lista.where((i) {
      if (!_mismoMes(i.fecha, mes)) return false;
      if (trabajadorId == null && vehiculoId == null) return true;
      final viaje = i.viajeId == null ? null : mapaViajes[i.viajeId]?.viaje;
      if (viaje == null) return false;
      if (trabajadorId != null && viaje.trabajadorId != trabajadorId) return false;
      if (vehiculoId != null && viaje.vehiculoId != vehiculoId) return false;
      return true;
    }).toList();
  });
});

final egresosFiltradosProvider =
    Provider.autoDispose<AsyncValue<List<Egreso>>>((ref) {
  final egresosAsync = ref.watch(egresosGeneralesProvider);
  final viajes = ref.watch(viajesTodosProvider).valueOrNull ?? const [];
  final mapaViajes = _mapaViajesPorId(viajes);
  final mes = ref.watch(finanzasMesFiltroProvider);
  final trabajadorId = ref.watch(finanzasTrabajadorFiltroProvider);
  final vehiculoId = ref.watch(finanzasVehiculoFiltroProvider);

  return egresosAsync.whenData((lista) {
    return lista.where((e) {
      if (!_mismoMes(e.fecha, mes)) return false;
      if (trabajadorId == null && vehiculoId == null) return true;
      final viaje = e.viajeId == null ? null : mapaViajes[e.viajeId]?.viaje;
      if (trabajadorId != null && viaje?.trabajadorId != trabajadorId) return false;
      if (vehiculoId != null &&
          e.vehiculoId != vehiculoId &&
          viaje?.vehiculoId != vehiculoId) {
        return false;
      }
      return true;
    }).toList();
  });
});

/// Los impuestos son un costo de toda la empresa, no de un viaje — si
/// hay filtro de trabajador o vehículo no hay forma honesta de
/// prorratearlos, así que quedan fuera de esa vista.
final impuestosFiltradosProvider =
    Provider.autoDispose<AsyncValue<List<Impuesto>>>((ref) {
  final impuestosAsync = ref.watch(impuestosProvider);
  final mes = ref.watch(finanzasMesFiltroProvider);
  final trabajadorId = ref.watch(finanzasTrabajadorFiltroProvider);
  final vehiculoId = ref.watch(finanzasVehiculoFiltroProvider);

  return impuestosAsync.whenData((lista) {
    if (trabajadorId != null || vehiculoId != null) return const [];
    return lista.where((i) => _mismoMes(i.fechaVencimiento, mes)).toList();
  });
});

/// Meses con al menos un movimiento registrado, del más reciente al más
/// antiguo — para no ofrecer meses vacíos en el filtro.
final finanzasMesesDisponiblesProvider =
    Provider.autoDispose<List<DateTime>>((ref) {
  final ingresos = ref.watch(ingresosGeneralesProvider).valueOrNull ?? const [];
  final egresos = ref.watch(egresosGeneralesProvider).valueOrNull ?? const [];
  final impuestos = ref.watch(impuestosProvider).valueOrNull ?? const [];

  final meses = <DateTime>{};
  for (final i in ingresos) {
    meses.add(DateTime(i.fecha.year, i.fecha.month));
  }
  for (final e in egresos) {
    meses.add(DateTime(e.fecha.year, e.fecha.month));
  }
  for (final i in impuestos) {
    meses.add(DateTime(i.fechaVencimiento.year, i.fechaVencimiento.month));
  }
  final lista = meses.toList()..sort((a, b) => b.compareTo(a));
  return lista;
});
