import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/enum_labels.dart';
import '../../../core/database/enums.dart';
import '../../../core/errors/app_exceptions.dart';
import '../../trabajadores/application/trabajadores_list_providers.dart';
import '../../vehiculos/application/vehiculos_list_providers.dart';
import '../data/viajes_repository.dart';

/// Alta o edición de un viaje. `viaje` nulo = alta.
class ViajeFormScreen extends ConsumerStatefulWidget {
  const ViajeFormScreen({super.key, this.viaje});

  final Viaje? viaje;

  @override
  ConsumerState<ViajeFormScreen> createState() => _ViajeFormScreenState();
}

class _ViajeFormScreenState extends ConsumerState<ViajeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _origenCtrl =
      TextEditingController(text: widget.viaje?.origen ?? 'Arequipa');
  late final _clienteCtrl =
      TextEditingController(text: widget.viaje?.cliente ?? 'KR');
  late final _cargaCtrl = TextEditingController(text: widget.viaje?.carga ?? '');
  late final _kilometrajeCtrl = TextEditingController(
    text: widget.viaje?.kilometraje?.toStringAsFixed(0) ?? '',
  );
  late DestinoPrincipal _destino =
      widget.viaje?.destinoPrincipal ?? DestinoPrincipal.cuzco;
  late DateTime _fechaSalida = widget.viaje?.fechaSalida ?? DateTime.now();
  late int? _trabajadorId = widget.viaje?.trabajadorId;
  late int? _vehiculoId = widget.viaje?.vehiculoId;
  bool _guardando = false;

  bool get _esEdicion => widget.viaje != null;

  @override
  void dispose() {
    _origenCtrl.dispose();
    _clienteCtrl.dispose();
    _cargaCtrl.dispose();
    _kilometrajeCtrl.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;
    if (_trabajadorId == null || _vehiculoId == null) {
      _mostrarError('Elige un trabajador y un vehículo activos.');
      return;
    }
    setState(() => _guardando = true);
    final repo = ref.read(viajesRepositoryProvider);
    final kilometraje = _kilometrajeCtrl.text.trim().isEmpty
        ? null
        : double.tryParse(_kilometrajeCtrl.text.trim());
    try {
      if (_esEdicion) {
        await repo.actualizar(
          widget.viaje!.id,
          ViajesCompanion(
            fechaSalida: Value(_fechaSalida),
            origen: Value(_origenCtrl.text.trim()),
            destinoPrincipal: Value(_destino),
            cliente: Value(_clienteCtrl.text.trim()),
            carga: Value(_cargaCtrl.text.trim().isEmpty ? null : _cargaCtrl.text.trim()),
            kilometraje: Value(kilometraje),
            trabajadorId: Value(_trabajadorId!),
            vehiculoId: Value(_vehiculoId!),
          ),
        );
      } else {
        await repo.crear(
          ViajesCompanion.insert(
            fechaSalida: _fechaSalida,
            origen: Value(_origenCtrl.text.trim()),
            destinoPrincipal: _destino,
            cliente: Value(_clienteCtrl.text.trim()),
            carga: Value(_cargaCtrl.text.trim().isEmpty ? null : _cargaCtrl.text.trim()),
            kilometraje: Value(kilometraje),
            trabajadorId: _trabajadorId!,
            vehiculoId: _vehiculoId!,
          ),
        );
      }
      if (!mounted) return;
      Navigator.of(context).pop();
    } on ValidacionNegocioException catch (e) {
      _mostrarError(e.mensaje);
    } catch (e) {
      _mostrarError('No se pudo guardar: $e');
    } finally {
      if (mounted) setState(() => _guardando = false);
    }
  }

  Future<void> _cambiarEstado(ViajeEstado estado) async {
    DateTime? fechaLlegada;
    if (estado == ViajeEstado.finalizado) {
      fechaLlegada = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: widget.viaje!.fechaSalida,
        lastDate: DateTime(2100),
      );
      if (fechaLlegada == null) return; // canceló el picker
    }
    try {
      await ref
          .read(viajesRepositoryProvider)
          .cambiarEstado(widget.viaje!.id, estado, fechaLlegada: fechaLlegada);
      if (!mounted) return;
      Navigator.of(context).pop();
    } on ValidacionNegocioException catch (e) {
      _mostrarError(e.mensaje);
    }
  }

  void _mostrarError(String mensaje) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(mensaje)));
  }

  Future<void> _elegirFechaSalida() async {
    final fecha = await showDatePicker(
      context: context,
      initialDate: _fechaSalida,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (fecha != null) setState(() => _fechaSalida = fecha);
  }

  @override
  Widget build(BuildContext context) {
    final trabajadoresAsync = ref.watch(trabajadoresActivosProvider);
    final vehiculosAsync = ref.watch(vehiculosActivosProvider);

    return Scaffold(
      appBar: AppBar(title: Text(_esEdicion ? 'Editar viaje' : 'Nuevo viaje')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Fecha de salida'),
              subtitle: Text(_formatearFecha(_fechaSalida)),
              trailing: const Icon(Icons.calendar_today_outlined),
              onTap: _elegirFechaSalida,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _origenCtrl,
              decoration: const InputDecoration(labelText: 'Origen'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Ingresa el origen' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<DestinoPrincipal>(
              initialValue: _destino,
              decoration: const InputDecoration(labelText: 'Destino principal'),
              items: DestinoPrincipal.values
                  .map((d) => DropdownMenuItem(
                        value: d,
                        child: Text(etiquetaDestinoPrincipal(d)),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _destino = v ?? _destino),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _clienteCtrl,
              decoration: const InputDecoration(labelText: 'Cliente'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Ingresa el cliente' : null,
            ),
            const SizedBox(height: 16),
            _SelectorTrabajador(
              async: trabajadoresAsync,
              seleccionado: _trabajadorId,
              onChanged: (id) => setState(() => _trabajadorId = id),
            ),
            const SizedBox(height: 16),
            _SelectorVehiculo(
              async: vehiculosAsync,
              seleccionado: _vehiculoId,
              onChanged: (id) => setState(() => _vehiculoId = id),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _cargaCtrl,
              decoration: const InputDecoration(labelText: 'Carga (opcional)'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _kilometrajeCtrl,
              decoration: const InputDecoration(labelText: 'Kilometraje (opcional)'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _guardando ? null : _guardar,
              child: Text(_guardando ? 'Guardando…' : 'Guardar'),
            ),
            if (_esEdicion) ...[
              const SizedBox(height: 12),
              const Text('Estado del viaje'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: ViajeEstado.values.map((estado) {
                  final seleccionado = widget.viaje!.estado == estado;
                  return ChoiceChip(
                    label: Text(etiquetaViajeEstado(estado)),
                    selected: seleccionado,
                    onSelected: (_) => _cambiarEstado(estado),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatearFecha(DateTime fecha) =>
      '${fecha.day}/${fecha.month}/${fecha.year}';
}

class _SelectorTrabajador extends StatelessWidget {
  const _SelectorTrabajador({
    required this.async,
    required this.seleccionado,
    required this.onChanged,
  });

  final AsyncValue<List<Trabajador>> async;
  final int? seleccionado;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    return async.when(
      loading: () => const LinearProgressIndicator(),
      error: (e, _) => Text('No se pudo cargar trabajadores: $e'),
      data: (trabajadores) {
        if (trabajadores.isEmpty) {
          return const Text(
            'No hay trabajadores activos — da de alta uno primero en la pestaña Trabajadores.',
          );
        }
        return DropdownButtonFormField<int>(
          initialValue: trabajadores.any((t) => t.id == seleccionado) ? seleccionado : null,
          decoration: const InputDecoration(labelText: 'Trabajador'),
          items: trabajadores
              .map((t) => DropdownMenuItem(value: t.id, child: Text(t.nombre)))
              .toList(),
          onChanged: onChanged,
          validator: (v) => v == null ? 'Elige un trabajador' : null,
        );
      },
    );
  }
}

class _SelectorVehiculo extends StatelessWidget {
  const _SelectorVehiculo({
    required this.async,
    required this.seleccionado,
    required this.onChanged,
  });

  final AsyncValue<List<Vehiculo>> async;
  final int? seleccionado;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    return async.when(
      loading: () => const LinearProgressIndicator(),
      error: (e, _) => Text('No se pudo cargar vehículos: $e'),
      data: (vehiculos) {
        if (vehiculos.isEmpty) {
          return const Text(
            'No hay vehículos activos — da de alta uno primero en la pestaña Flota.',
          );
        }
        return DropdownButtonFormField<int>(
          initialValue: vehiculos.any((v) => v.id == seleccionado) ? seleccionado : null,
          decoration: const InputDecoration(labelText: 'Vehículo'),
          items: vehiculos
              .map((v) => DropdownMenuItem(value: v.id, child: Text(v.placa)))
              .toList(),
          onChanged: onChanged,
          validator: (v) => v == null ? 'Elige un vehículo' : null,
        );
      },
    );
  }
}
