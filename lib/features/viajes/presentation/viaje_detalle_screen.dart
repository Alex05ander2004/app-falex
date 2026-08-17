import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/enum_labels.dart';
import '../../../core/widgets/confirm_delete_dialog.dart';
import '../../../core/widgets/empty_state.dart';
import '../../egresos/data/egresos_repository.dart';
import '../../ingresos/data/ingresos_repository.dart';
import '../application/viaje_detalle_providers.dart';
import '../data/viajes_repository.dart';
import 'viaje_form_screen.dart';
import 'widgets/agregar_parada_dialog.dart';
import 'widgets/registrar_movimiento_dialog.dart';
import 'widgets/viaje_estado_chip.dart';

Future<void> _eliminarViaje(
  BuildContext context,
  WidgetRef ref,
  int viajeId,
) async {
  final repo = ref.read(viajesRepositoryProvider);
  final dependientes = await repo.contarDependientes(viajeId);

  final partes = <String>[];
  if (dependientes.ingresos > 0) partes.add('${dependientes.ingresos} ingreso(s)');
  if (dependientes.egresos > 0) partes.add('${dependientes.egresos} gasto(s)');
  if (dependientes.paradas > 0) partes.add('${dependientes.paradas} parada(s) extra');

  final mensaje = partes.isEmpty
      ? 'Esta acción no se puede deshacer.'
      : 'También se borrarán ${partes.join(', ')} de este viaje. Esta '
          'acción no se puede deshacer.';

  if (!context.mounted) return;
  final ok = await confirmarEliminar(context, mensaje);
  if (!ok) return;

  await repo.eliminar(viajeId);
  if (context.mounted) Navigator.of(context).pop();
}

class ViajeDetalleScreen extends ConsumerWidget {
  const ViajeDetalleScreen({super.key, required this.viajeId});
  final int viajeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(viajeProvider(viajeId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del viaje'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Editar',
            onPressed: () {
              final item = async.valueOrNull;
              if (item == null) return;
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ViajeFormScreen(viaje: item.viaje),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Eliminar viaje',
            onPressed: () => _eliminarViaje(context, ref, viajeId),
          ),
        ],
      ),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => EmptyState(
          icon: Icons.error_outline,
          title: 'No se pudo cargar el viaje',
          message: '$e',
        ),
        data: (item) {
          if (item == null) {
            return const EmptyState(
              icon: Icons.search_off,
              title: 'Este viaje ya no existe',
              message: '',
            );
          }
          final viaje = item.viaje;
          final balance = ref.watch(viajeBalanceProvider(viajeId));

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${viaje.origen} → ${etiquetaDestinoPrincipal(viaje.destinoPrincipal)}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  ViajeEstadoChip(estado: viaje.estado),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                '${item.trabajador.nombre} · ${item.vehiculo.placa} · Cliente: ${viaje.cliente}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (viaje.carga != null) ...[
                const SizedBox(height: 2),
                Text('Carga: ${viaje.carga}', style: Theme.of(context).textTheme.bodySmall),
              ],
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Balance del viaje', style: Theme.of(context).textTheme.titleMedium),
                      Text(
                        balance == null ? '…' : 'S/ ${balance.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: (balance ?? 0) < 0
                                  ? Theme.of(context).colorScheme.error
                                  : Theme.of(context).colorScheme.tertiary,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _SeccionParadas(viajeId: viajeId, fechaSalidaViaje: viaje.fechaSalida),
              const SizedBox(height: 24),
              _SeccionIngresos(viajeId: viajeId),
              const SizedBox(height: 24),
              _SeccionEgresos(viajeId: viajeId),
            ],
          );
        },
      ),
    );
  }
}

class _SeccionTitulo extends StatelessWidget {
  const _SeccionTitulo({required this.titulo, required this.onAgregar, required this.textoBoton});
  final String titulo;
  final VoidCallback onAgregar;
  final String textoBoton;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(titulo, style: Theme.of(context).textTheme.titleMedium),
        TextButton.icon(
          onPressed: onAgregar,
          icon: const Icon(Icons.add, size: 18),
          label: Text(textoBoton),
        ),
      ],
    );
  }
}

class _SeccionParadas extends ConsumerWidget {
  const _SeccionParadas({required this.viajeId, required this.fechaSalidaViaje});
  final int viajeId;
  final DateTime fechaSalidaViaje;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paradas = ref.watch(viajeParadasProvider(viajeId));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SeccionTitulo(
          titulo: 'Paradas extra',
          textoBoton: 'Extender viaje',
          onAgregar: () => mostrarAgregarParadaDialog(context, ref, viajeId),
        ),
        const SizedBox(height: 8),
        paradas.when(
          loading: () => const LinearProgressIndicator(),
          error: (e, _) => Text('$e'),
          data: (lista) {
            if (lista.isEmpty) {
              return Text(
                'Este viaje no se ha extendido a otra provincia.',
                style: Theme.of(context).textTheme.bodySmall,
              );
            }
            return Column(
              children: lista
                  .map((p) => Card(
                        child: ListTile(
                          leading: const Icon(Icons.alt_route),
                          title: Text(p.provincia),
                          subtitle: Text(
                            'Salió el ${p.fechaSalida.day}/${p.fechaSalida.month}/${p.fechaSalida.year}',
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () async {
                              final ok = await confirmarEliminar(
                                context,
                                'Se quitará la parada en ${p.provincia}.',
                              );
                              if (ok) {
                                await ref
                                    .read(viajesRepositoryProvider)
                                    .eliminarParada(p.id);
                              }
                            },
                          ),
                        ),
                      ))
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}

/// "S/" y la cifra van con espacio irrompible: si el monto no separara,
/// el texto podía partirse justo entre "S/" y el número.
String _formatoMonto(double monto) => 'S/ ${monto.toStringAsFixed(2)}';

class _SeccionIngresos extends ConsumerWidget {
  const _SeccionIngresos({required this.viajeId});
  final int viajeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ingresos = ref.watch(viajeIngresosProvider(viajeId));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SeccionTitulo(
          titulo: 'Ingresos',
          textoBoton: 'Nuevo ingreso',
          onAgregar: () => mostrarRegistrarIngresoDialog(context, viajeId),
        ),
        const SizedBox(height: 8),
        ingresos.when(
          loading: () => const LinearProgressIndicator(),
          error: (e, _) => Text('$e'),
          data: (lista) {
            if (lista.isEmpty) {
              return Text(
                'Aún no hay ingresos registrados para este viaje.',
                style: Theme.of(context).textTheme.bodySmall,
              );
            }
            final theme = Theme.of(context);
            return Column(
              children: lista.map((i) {
                final neto = i.monto - i.detraccion;
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 8, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.trending_up, size: 20),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                i.destinoFlete == null
                                    ? etiquetaIngresoConcepto(i.concepto)
                                    : '${etiquetaIngresoConcepto(i.concepto)} · ${i.destinoFlete}',
                                style: theme.textTheme.titleMedium,
                              ),
                            ),
                            Text(_formatoMonto(neto), style: theme.textTheme.titleMedium),
                            IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () async {
                                final ok = await confirmarEliminar(
                                  context,
                                  'Se quitará el ingreso de '
                                  '"${etiquetaIngresoConcepto(i.concepto)}" por '
                                  '${_formatoMonto(i.monto)}.',
                                );
                                if (ok) {
                                  await ref
                                      .read(ingresosRepositoryProvider)
                                      .eliminar(i.id);
                                }
                              },
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${i.fecha.day}/${i.fecha.month}/${i.fecha.year}',
                                style: theme.textTheme.bodySmall,
                              ),
                              if (i.detraccion > 0)
                                Text(
                                  'Bruto ${_formatoMonto(i.monto)} · Detracción ${_formatoMonto(i.detraccion)}',
                                  style: theme.textTheme.bodySmall,
                                ),
                              if (i.numeroFactura != null)
                                Text(
                                  'Factura ${i.numeroFactura}',
                                  style: theme.textTheme.bodySmall,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}

class _SeccionEgresos extends ConsumerWidget {
  const _SeccionEgresos({required this.viajeId});
  final int viajeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final egresos = ref.watch(viajeEgresosProvider(viajeId));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SeccionTitulo(
          titulo: 'Egresos',
          textoBoton: 'Nuevo gasto',
          onAgregar: () => mostrarRegistrarEgresoDialog(context, viajeId),
        ),
        const SizedBox(height: 8),
        egresos.when(
          loading: () => const LinearProgressIndicator(),
          error: (e, _) => Text('$e'),
          data: (lista) {
            if (lista.isEmpty) {
              return Text(
                'Aún no hay gastos registrados para este viaje.',
                style: Theme.of(context).textTheme.bodySmall,
              );
            }
            return Column(
              children: lista
                  .map((e) => Card(
                        child: ListTile(
                          leading: const Icon(Icons.trending_down),
                          title: Text(etiquetaEgresoCategoria(e.categoria)),
                          subtitle: Text('${e.fecha.day}/${e.fecha.month}/${e.fecha.year}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'S/ ${e.monto.toStringAsFixed(2)}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () async {
                                  final ok = await confirmarEliminar(
                                    context,
                                    'Se quitará el gasto de "${etiquetaEgresoCategoria(e.categoria)}" por S/ ${e.monto.toStringAsFixed(2)}.',
                                  );
                                  if (ok) {
                                    await ref
                                        .read(egresosRepositoryProvider)
                                        .eliminar(e.id);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}
