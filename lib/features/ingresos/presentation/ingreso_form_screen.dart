import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/enum_labels.dart';
import '../../../core/database/enums.dart';
import '../../../core/errors/app_exceptions.dart';
import '../../../core/finance/detraccion.dart';
import '../../../core/finance/igv.dart';
import '../../../core/widgets/comprobante_picker.dart';
import '../../viajes/application/viaje_detalle_providers.dart';
import '../../viajes/application/viajes_list_providers.dart';
import '../data/ingresos_repository.dart';

/// Alta o edición de un ingreso general — ligado o no a un viaje.
/// `ingreso` nulo = alta.
class IngresoFormScreen extends ConsumerStatefulWidget {
  const IngresoFormScreen({super.key, this.ingreso});

  final Ingreso? ingreso;

  @override
  ConsumerState<IngresoFormScreen> createState() => _IngresoFormScreenState();
}

class _IngresoFormScreenState extends ConsumerState<IngresoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _montoCtrl = TextEditingController();
  final _facturaCtrl = TextEditingController();
  late IngresoConcepto _concepto = widget.ingreso?.concepto ?? IngresoConcepto.otro;
  late DateTime _fecha = widget.ingreso?.fecha ?? DateTime.now();
  late int? _viajeId = widget.ingreso?.viajeId;
  String? _destinoFlete;
  String? _comprobantePath;
  bool _guardando = false;
  String? _error;

  bool get _esEdicion => widget.ingreso != null;

  @override
  void initState() {
    super.initState();
    _montoCtrl.text = widget.ingreso?.monto.toStringAsFixed(2) ?? '';
    _facturaCtrl.text = widget.ingreso?.numeroFactura ?? '';
    _destinoFlete = widget.ingreso?.destinoFlete;
    _comprobantePath = widget.ingreso?.comprobantePath;
    _montoCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _montoCtrl.dispose();
    _facturaCtrl.dispose();
    super.dispose();
  }

  String? _validarMonto(String? v) {
    final texto = v?.trim() ?? '';
    if (texto.isEmpty) return 'Ingresa el monto';
    final valor = double.tryParse(texto);
    if (valor == null || valor <= 0) return 'El monto debe ser mayor a 0';
    return null;
  }

  Future<void> _elegirFecha() async {
    final fecha = await showDatePicker(
      context: context,
      initialDate: _fecha,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (fecha != null) setState(() => _fecha = fecha);
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _guardando = true;
      _error = null;
    });
    final esFlete = _concepto == IngresoConcepto.flete;
    try {
      final repo = ref.read(ingresosRepositoryProvider);
      if (_esEdicion) {
        await repo.actualizar(
          widget.ingreso!.id,
          IngresosCompanion(
            monto: Value(double.parse(_montoCtrl.text.trim())),
            fecha: Value(_fecha),
            concepto: Value(_concepto),
            numeroFactura: Value(
              _facturaCtrl.text.trim().isEmpty ? null : _facturaCtrl.text.trim(),
            ),
            destinoFlete: Value(esFlete ? _destinoFlete : null),
            viajeId: Value(_viajeId),
            comprobantePath: Value(_comprobantePath),
          ),
        );
      } else {
        await repo.crear(
          IngresosCompanion.insert(
            monto: double.parse(_montoCtrl.text.trim()),
            fecha: _fecha,
            concepto: _concepto,
            numeroFactura: Value(
              _facturaCtrl.text.trim().isEmpty ? null : _facturaCtrl.text.trim(),
            ),
            destinoFlete: Value(esFlete ? _destinoFlete : null),
            viajeId: Value(_viajeId),
            comprobantePath: Value(_comprobantePath),
          ),
        );
      }
      if (!mounted) return;
      Navigator.of(context).pop();
    } on ValidacionNegocioException catch (e) {
      setState(() => _error = e.mensaje);
    } catch (e) {
      setState(() => _error = 'No se pudo guardar: $e');
    } finally {
      if (mounted) setState(() => _guardando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viajesAsync = ref.watch(viajesTodosProvider);
    final montoIngresado = double.tryParse(_montoCtrl.text.trim());
    final esFlete = _concepto == IngresoConcepto.flete;
    final viajes = viajesAsync.valueOrNull ?? const [];

    final opcionesDestino = <String>[];
    if (_viajeId != null) {
      final coincidencias = viajes.where((v) => v.viaje.id == _viajeId);
      final viajeSeleccionado = coincidencias.isEmpty ? null : coincidencias.first;
      if (viajeSeleccionado != null) {
        opcionesDestino.add(etiquetaDestinoPrincipal(viajeSeleccionado.viaje.destinoPrincipal));
      }
      final paradas = ref.watch(viajeParadasProvider(_viajeId!)).valueOrNull ?? const [];
      opcionesDestino.addAll(paradas.map((p) => p.provincia));
    }
    final destinoSeleccionado =
        (_destinoFlete != null && opcionesDestino.contains(_destinoFlete))
            ? _destinoFlete
            : (opcionesDestino.isNotEmpty ? opcionesDestino.first : null);

    return Scaffold(
      appBar: AppBar(title: Text(_esEdicion ? 'Editar ingreso' : 'Nuevo ingreso')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DropdownButtonFormField<IngresoConcepto>(
              initialValue: _concepto,
              decoration: const InputDecoration(labelText: 'Concepto'),
              items: IngresoConcepto.values
                  .map((c) => DropdownMenuItem(value: c, child: Text(etiquetaIngresoConcepto(c))))
                  .toList(),
              onChanged: (v) => setState(() => _concepto = v ?? _concepto),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _montoCtrl,
              decoration: const InputDecoration(labelText: 'Monto (S/)'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
              validator: _validarMonto,
            ),
            if (esFlete && montoIngresado != null && montoIngresado > 0) ...[
              const SizedBox(height: 8),
              Text(
                'Detracción (4%): S/ ${calcularDetraccion(montoIngresado).toStringAsFixed(2)} · '
                'Recibes S/ ${(montoIngresado - calcularDetraccion(montoIngresado)).toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                'IGV débito (18%, se acumula como impuesto por pagar): '
                'S/ ${calcularIgv(montoIngresado).toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Fecha'),
              subtitle: Text('${_fecha.day}/${_fecha.month}/${_fecha.year}'),
              trailing: const Icon(Icons.calendar_today_outlined),
              onTap: _elegirFecha,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<int?>(
              initialValue: _viajeId,
              decoration: const InputDecoration(labelText: 'Viaje relacionado (opcional)'),
              items: [
                const DropdownMenuItem<int?>(value: null, child: Text('Ninguno')),
                ...viajes.map((v) => DropdownMenuItem<int?>(
                      value: v.viaje.id,
                      child: Text(
                        '${v.viaje.origen} → ${etiquetaDestinoPrincipal(v.viaje.destinoPrincipal)} '
                        '(${v.viaje.fechaSalida.day}/${v.viaje.fechaSalida.month})',
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
              ],
              onChanged: (v) => setState(() {
                _viajeId = v;
                _destinoFlete = null;
              }),
            ),
            if (esFlete && opcionesDestino.isNotEmpty) ...[
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: destinoSeleccionado,
                decoration: const InputDecoration(labelText: 'Destino del flete'),
                items: opcionesDestino
                    .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                    .toList(),
                onChanged: (v) => setState(() => _destinoFlete = v),
              ),
            ],
            const SizedBox(height: 16),
            TextFormField(
              controller: _facturaCtrl,
              decoration: const InputDecoration(labelText: 'N.º de factura (opcional)'),
            ),
            const SizedBox(height: 16),
            ComprobantePicker(
              path: _comprobantePath,
              onChanged: (path) => setState(() => _comprobantePath = path),
            ),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
            ],
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _guardando ? null : _guardar,
              child: Text(_guardando ? 'Guardando…' : 'Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
