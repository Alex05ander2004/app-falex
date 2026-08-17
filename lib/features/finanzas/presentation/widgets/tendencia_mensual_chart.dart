import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/finance/mes_label.dart';
import '../../../egresos/application/egresos_list_providers.dart';
import '../../../impuestos/application/impuestos_list_providers.dart';
import '../../../ingresos/application/ingresos_list_providers.dart';

const _alturaGrafico = 110.0;

class _MesResumen {
  const _MesResumen({
    required this.mes,
    required this.ingresos,
    required this.gastos,
    required this.utilidad,
  });

  final DateTime mes;
  final double ingresos;
  final double gastos; // egresos + impuestos
  final double utilidad;
}

/// Ingresos, gastos (egresos + impuestos) y utilidad de los últimos 6
/// meses — Ruta Falex, Fase 6. Siempre a nivel de toda la empresa: no
/// respeta el filtro de trabajador/vehículo porque comparar varios
/// meses ya es, en sí, una vista distinta a la de un recorte puntual.
class TendenciaMensualChart extends ConsumerWidget {
  const TendenciaMensualChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ingresos = ref.watch(ingresosGeneralesProvider).valueOrNull;
    final egresos = ref.watch(egresosGeneralesProvider).valueOrNull;
    final impuestos = ref.watch(impuestosProvider).valueOrNull;
    final theme = Theme.of(context);

    if (ingresos == null || egresos == null || impuestos == null) {
      return const SizedBox(
        height: _alturaGrafico,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final ahora = DateTime.now();
    final meses = List.generate(
      6,
      (i) => DateTime(ahora.year, ahora.month - (5 - i)),
    );

    final datos = meses.map((mes) {
      final ingresosMes = ingresos
          .where((i) => i.fecha.year == mes.year && i.fecha.month == mes.month)
          .fold<double>(0, (sum, i) => sum + (i.monto - i.detraccion));
      final egresosMes = egresos
          .where((e) => e.fecha.year == mes.year && e.fecha.month == mes.month)
          .fold<double>(0, (sum, e) => sum + e.monto);
      final impuestosMes = impuestos
          .where((i) =>
              i.fechaVencimiento.year == mes.year && i.fechaVencimiento.month == mes.month)
          .fold<double>(0, (sum, i) => sum + i.monto);
      final gastosMes = egresosMes + impuestosMes;
      return _MesResumen(
        mes: mes,
        ingresos: ingresosMes,
        gastos: gastosMes,
        utilidad: ingresosMes - gastosMes,
      );
    }).toList();

    var maxValor = 1.0;
    for (final d in datos) {
      for (final v in [d.ingresos.abs(), d.gastos.abs(), d.utilidad.abs()]) {
        if (v > maxValor) maxValor = v;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _leyenda(theme, theme.colorScheme.tertiary, 'Ingresos'),
            const SizedBox(width: 12),
            _leyenda(theme, theme.colorScheme.error, 'Gastos'),
            const SizedBox(width: 12),
            _leyenda(theme, theme.colorScheme.primary, 'Utilidad'),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: _alturaGrafico,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: datos
                .map((d) => Expanded(child: _barraDelMes(theme, d, maxValor)))
                .toList(),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: datos
              .map(
                (d) => Expanded(
                  child: Text(
                    etiquetaMesCorta(d.mes),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelMedium,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _leyenda(ThemeData theme, Color color, String texto) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 8, height: 8, color: color),
        const SizedBox(width: 4),
        Text(texto, style: theme.textTheme.labelMedium),
      ],
    );
  }

  Widget _barraDelMes(ThemeData theme, _MesResumen d, double maxValor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _barra(d.ingresos, maxValor, theme.colorScheme.tertiary),
        const SizedBox(width: 2),
        _barra(d.gastos, maxValor, theme.colorScheme.error),
        const SizedBox(width: 2),
        _barra(
          d.utilidad,
          maxValor,
          d.utilidad < 0 ? theme.colorScheme.error : theme.colorScheme.primary,
        ),
      ],
    );
  }

  Widget _barra(double valor, double maxValor, Color color) {
    final alturaProporcional = (valor.abs() / maxValor) * (_alturaGrafico - 8);
    return Container(
      width: 8,
      height: alturaProporcional.clamp(1.0, _alturaGrafico - 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(2)),
      ),
    );
  }
}
