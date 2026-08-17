import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/enum_labels.dart';
import '../../../../core/database/enums.dart';
import '../../../../core/errors/app_exceptions.dart';
import '../../../../core/finance/detraccion.dart';
import '../../../egresos/data/egresos_repository.dart';
import '../../../ingresos/data/ingresos_repository.dart';
import '../../application/viaje_detalle_providers.dart';

/// Registro rápido de un ingreso o egreso desde el detalle del viaje —
/// pensado para anotar el gasto en el momento, en ruta (Ruta Falex,
/// Fase 3).
Future<void> mostrarRegistrarIngresoDialog(BuildContext context, int viajeId) {
  return showDialog(
    context: context,
    builder: (_) => _RegistrarIngresoDialog(viajeId: viajeId),
  );
}

Future<void> mostrarRegistrarEgresoDialog(BuildContext context, int viajeId) {
  return showDialog(
    context: context,
    builder: (_) => _RegistrarEgresoDialog(viajeId: viajeId),
  );
}

class _RegistrarIngresoDialog extends ConsumerStatefulWidget {
  const _RegistrarIngresoDialog({required this.viajeId});
  final int viajeId;

  @override
  ConsumerState<_RegistrarIngresoDialog> createState() => _RegistrarIngresoDialogState();
}

class _RegistrarIngresoDialogState extends ConsumerState<_RegistrarIngresoDialog> {
  final _formKey = GlobalKey<FormState>();
  final _montoCtrl = TextEditingController();
  final _facturaCtrl = TextEditingController();
  IngresoConcepto _concepto = IngresoConcepto.flete;
  String? _destinoFlete;
  bool _guardando = false;
  String? _error;

  @override
  void initState() {
    super.initState();
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

  /// El destino principal del viaje, más cualquier provincia extra a la
  /// que se haya extendido — para saber a cuál de esos tramos corresponde
  /// este flete en particular.
  List<String> _opcionesDestino(WidgetRef ref, {required bool watch}) {
    final viaje = watch
        ? ref.watch(viajeProvider(widget.viajeId)).valueOrNull
        : ref.read(viajeProvider(widget.viajeId)).valueOrNull;
    final paradas = watch
        ? ref.watch(viajeParadasProvider(widget.viajeId)).valueOrNull
        : ref.read(viajeParadasProvider(widget.viajeId)).valueOrNull;
    return [
      if (viaje != null) etiquetaDestinoPrincipal(viaje.viaje.destinoPrincipal),
      ...?paradas?.map((p) => p.provincia),
    ];
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _guardando = true;
      _error = null;
    });
    final esFlete = _concepto == IngresoConcepto.flete;
    final opciones = _opcionesDestino(ref, watch: false);
    final destino = esFlete
        ? (_destinoFlete ?? (opciones.isNotEmpty ? opciones.first : null))
        : null;
    try {
      await ref.read(ingresosRepositoryProvider).crear(
            IngresosCompanion.insert(
              monto: double.parse(_montoCtrl.text.trim()),
              fecha: DateTime.now(),
              concepto: _concepto,
              numeroFactura: Value(
                _facturaCtrl.text.trim().isEmpty ? null : _facturaCtrl.text.trim(),
              ),
              destinoFlete: Value(destino),
              viajeId: Value(widget.viajeId),
            ),
          );
      if (!mounted) return;
      Navigator.of(context).pop();
    } on ValidacionNegocioException catch (e) {
      setState(() => _error = e.mensaje);
    } finally {
      if (mounted) setState(() => _guardando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final montoIngresado = double.tryParse(_montoCtrl.text.trim());
    final esFlete = _concepto == IngresoConcepto.flete;
    final opcionesDestino = _opcionesDestino(ref, watch: true);
    final destinoSeleccionado =
        (_destinoFlete != null && opcionesDestino.contains(_destinoFlete))
            ? _destinoFlete
            : (opcionesDestino.isNotEmpty ? opcionesDestino.first : null);

    return AlertDialog(
      title: const Text('Nuevo ingreso'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<IngresoConcepto>(
              initialValue: _concepto,
              decoration: const InputDecoration(labelText: 'Concepto'),
              items: IngresoConcepto.values
                  .map((c) => DropdownMenuItem(
                        value: c,
                        child: Text(etiquetaIngresoConcepto(c)),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _concepto = v ?? _concepto),
            ),
            if (esFlete && opcionesDestino.isNotEmpty) ...[
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: destinoSeleccionado,
                decoration: const InputDecoration(labelText: 'Destino del flete'),
                items: opcionesDestino
                    .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                    .toList(),
                onChanged: (v) => setState(() => _destinoFlete = v),
              ),
            ],
            const SizedBox(height: 12),
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
            ],
            const SizedBox(height: 12),
            TextFormField(
              controller: _facturaCtrl,
              decoration: const InputDecoration(labelText: 'N.º de factura (opcional)'),
            ),
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: _guardando ? null : _guardar,
          child: Text(_guardando ? 'Guardando…' : 'Guardar'),
        ),
      ],
    );
  }
}

class _RegistrarEgresoDialog extends ConsumerStatefulWidget {
  const _RegistrarEgresoDialog({required this.viajeId});
  final int viajeId;

  @override
  ConsumerState<_RegistrarEgresoDialog> createState() => _RegistrarEgresoDialogState();
}

class _RegistrarEgresoDialogState extends ConsumerState<_RegistrarEgresoDialog> {
  final _formKey = GlobalKey<FormState>();
  final _montoCtrl = TextEditingController();
  final _descripcionCtrl = TextEditingController();
  EgresoCategoria _categoria = EgresoCategoria.combustible;
  bool _guardando = false;
  String? _error;

  @override
  void dispose() {
    _montoCtrl.dispose();
    _descripcionCtrl.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _guardando = true;
      _error = null;
    });
    try {
      await ref.read(egresosRepositoryProvider).crear(
            EgresosCompanion.insert(
              monto: double.parse(_montoCtrl.text.trim()),
              fecha: DateTime.now(),
              categoria: _categoria,
              descripcion: Value(
                _descripcionCtrl.text.trim().isEmpty ? null : _descripcionCtrl.text.trim(),
              ),
              viajeId: Value(widget.viajeId),
            ),
          );
      if (!mounted) return;
      Navigator.of(context).pop();
    } on ValidacionNegocioException catch (e) {
      setState(() => _error = e.mensaje);
    } finally {
      if (mounted) setState(() => _guardando = false);
    }
  }

  String? _validarMonto(String? v) {
    final texto = v?.trim() ?? '';
    if (texto.isEmpty) return 'Ingresa el monto';
    final valor = double.tryParse(texto);
    if (valor == null || valor <= 0) return 'El monto debe ser mayor a 0';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nuevo gasto'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _montoCtrl,
              decoration: const InputDecoration(labelText: 'Monto (S/)'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
              validator: _validarMonto,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<EgresoCategoria>(
              initialValue: _categoria,
              decoration: const InputDecoration(labelText: 'Categoría'),
              items: EgresoCategoria.values
                  .map((c) => DropdownMenuItem(
                        value: c,
                        child: Text(etiquetaEgresoCategoria(c)),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _categoria = v ?? _categoria),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _descripcionCtrl,
              decoration: const InputDecoration(labelText: 'Descripción (opcional)'),
            ),
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: _guardando ? null : _guardar,
          child: Text(_guardando ? 'Guardando…' : 'Guardar'),
        ),
      ],
    );
  }
}
