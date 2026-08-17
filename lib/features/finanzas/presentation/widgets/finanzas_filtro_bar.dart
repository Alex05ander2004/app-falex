import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/finance/mes_label.dart';
import '../../../trabajadores/application/trabajadores_list_providers.dart';
import '../../../vehiculos/application/vehiculos_list_providers.dart';
import '../../application/finanzas_filtros_providers.dart';

String _nombreTrabajador(List<Trabajador> trabajadores, int id) {
  for (final t in trabajadores) {
    if (t.id == id) return t.nombre;
  }
  return 'Trabajador';
}

String _placaVehiculo(List<Vehiculo> vehiculos, int id) {
  for (final v in vehiculos) {
    if (v.id == id) return v.placa;
  }
  return 'Vehículo';
}

/// Filtro por mes, trabajador y vehículo sobre lo que se ve en Finanzas
/// (Ruta Falex, Fase 6). El trabajador solo tiene sentido si viene de
/// un viaje, así que filtra ingresos/egresos ligados a alguno.
class FinanzasFiltroBar extends ConsumerWidget {
  const FinanzasFiltroBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mes = ref.watch(finanzasMesFiltroProvider);
    final trabajadorId = ref.watch(finanzasTrabajadorFiltroProvider);
    final vehiculoId = ref.watch(finanzasVehiculoFiltroProvider);
    final mesesDisponibles = ref.watch(finanzasMesesDisponiblesProvider);
    final trabajadores = ref.watch(trabajadoresTodosProvider).valueOrNull ?? const [];
    final vehiculos = ref.watch(vehiculosTodosProvider).valueOrNull ?? const [];

    final hayFiltroActivo = mes != null || trabajadorId != null || vehiculoId != null;

    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        children: [
          _FiltroDropdown<DateTime?>(
            etiqueta: mes == null ? 'Todos los meses' : etiquetaMes(mes),
            valor: mes,
            opciones: [
              const DropdownMenuItem(value: null, child: Text('Todos los meses')),
              ...mesesDisponibles.map(
                (m) => DropdownMenuItem(value: m, child: Text(etiquetaMes(m))),
              ),
            ],
            onChanged: (v) => ref.read(finanzasMesFiltroProvider.notifier).state = v,
          ),
          const SizedBox(width: 8),
          _FiltroDropdown<int?>(
            etiqueta: trabajadorId == null
                ? 'Todos los trabajadores'
                : _nombreTrabajador(trabajadores, trabajadorId),
            valor: trabajadorId,
            opciones: [
              const DropdownMenuItem(value: null, child: Text('Todos los trabajadores')),
              ...trabajadores.map(
                (t) => DropdownMenuItem(value: t.id, child: Text(t.nombre)),
              ),
            ],
            onChanged: (v) =>
                ref.read(finanzasTrabajadorFiltroProvider.notifier).state = v,
          ),
          const SizedBox(width: 8),
          _FiltroDropdown<int?>(
            etiqueta: vehiculoId == null
                ? 'Todos los vehículos'
                : _placaVehiculo(vehiculos, vehiculoId),
            valor: vehiculoId,
            opciones: [
              const DropdownMenuItem(value: null, child: Text('Todos los vehículos')),
              ...vehiculos.map(
                (v) => DropdownMenuItem(value: v.id, child: Text(v.placa)),
              ),
            ],
            onChanged: (v) =>
                ref.read(finanzasVehiculoFiltroProvider.notifier).state = v,
          ),
          if (hayFiltroActivo) ...[
            const SizedBox(width: 8),
            ActionChip(
              avatar: const Icon(Icons.close, size: 16),
              label: const Text('Limpiar'),
              onPressed: () {
                ref.read(finanzasMesFiltroProvider.notifier).state = null;
                ref.read(finanzasTrabajadorFiltroProvider.notifier).state = null;
                ref.read(finanzasVehiculoFiltroProvider.notifier).state = null;
              },
            ),
          ],
        ],
      ),
    );
  }
}

class _FiltroDropdown<T> extends StatelessWidget {
  const _FiltroDropdown({
    required this.etiqueta,
    required this.valor,
    required this.opciones,
    required this.onChanged,
  });

  final String etiqueta;
  final T valor;
  final List<DropdownMenuItem<T>> opciones;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: valor,
          isDense: true,
          icon: const Icon(Icons.arrow_drop_down, size: 18),
          items: opciones,
          selectedItemBuilder: (context) => opciones
              .map((_) => Align(
                    alignment: Alignment.centerLeft,
                    child: Text(etiqueta, style: theme.textTheme.bodySmall),
                  ))
              .toList(),
          onChanged: (v) => onChanged(v as T),
        ),
      ),
    );
  }
}
