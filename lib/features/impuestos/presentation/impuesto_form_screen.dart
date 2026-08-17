import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/enum_labels.dart';
import '../../../core/database/enums.dart';
import '../../../core/errors/app_exceptions.dart';
import '../../../core/notifications/notification_service.dart';
import '../../../core/widgets/confirm_delete_dialog.dart';
import '../../finanzas/application/balance_general_provider.dart';
import '../data/impuestos_repository.dart';
import 'widgets/marcar_pagado_dialog.dart';

/// Alta o edición de un impuesto. `impuesto` nulo = alta.
class ImpuestoFormScreen extends ConsumerStatefulWidget {
  const ImpuestoFormScreen({super.key, this.impuesto});

  final Impuesto? impuesto;

  @override
  ConsumerState<ImpuestoFormScreen> createState() => _ImpuestoFormScreenState();
}

class _ImpuestoFormScreenState extends ConsumerState<ImpuestoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _periodoCtrl = TextEditingController();
  final _montoCtrl = TextEditingController();
  late ImpuestoTipo _tipo = widget.impuesto?.tipo ?? ImpuestoTipo.igv;
  late DateTime _fechaVencimiento =
      widget.impuesto?.fechaVencimiento ?? DateTime.now().add(const Duration(days: 7));
  bool _guardando = false;
  String? _error;

  bool get _esEdicion => widget.impuesto != null;

  @override
  void initState() {
    super.initState();
    _periodoCtrl.text = widget.impuesto?.periodo ?? _periodoActual();
    if (widget.impuesto != null) {
      _montoCtrl.text = widget.impuesto!.monto.toStringAsFixed(2);
    } else if (_tipo == ImpuestoTipo.igv) {
      final igvPorPagar = ref.read(igvPorPagarProvider);
      if (igvPorPagar != null && igvPorPagar > 0) {
        _montoCtrl.text = igvPorPagar.toStringAsFixed(2);
      }
    }
  }

  String _periodoActual() {
    final ahora = DateTime.now();
    return '${ahora.year}-${ahora.month.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _periodoCtrl.dispose();
    _montoCtrl.dispose();
    super.dispose();
  }

  String? _validarMonto(String? v) {
    final texto = v?.trim() ?? '';
    if (texto.isEmpty) return 'Ingresa el monto';
    final valor = double.tryParse(texto);
    if (valor == null || valor <= 0) return 'El monto debe ser mayor a 0';
    return null;
  }

  Future<void> _elegirFechaVencimiento() async {
    final fecha = await showDatePicker(
      context: context,
      initialDate: _fechaVencimiento,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (fecha != null) setState(() => _fechaVencimiento = fecha);
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _guardando = true;
      _error = null;
    });
    final repo = ref.read(impuestosRepositoryProvider);
    try {
      int id;
      if (_esEdicion) {
        id = widget.impuesto!.id;
        await repo.actualizar(
          id,
          ImpuestosCompanion(
            tipo: Value(_tipo),
            periodo: Value(_periodoCtrl.text.trim()),
            monto: Value(double.parse(_montoCtrl.text.trim())),
            fechaVencimiento: Value(_fechaVencimiento),
          ),
        );
      } else {
        id = await repo.crear(
          ImpuestosCompanion.insert(
            tipo: _tipo,
            periodo: _periodoCtrl.text.trim(),
            monto: double.parse(_montoCtrl.text.trim()),
            fechaVencimiento: _fechaVencimiento,
          ),
        );
      }

      final estadoActual = widget.impuesto?.estado ?? ImpuestoEstado.pendiente;
      if (estadoActual == ImpuestoEstado.pendiente) {
        final notificaciones = ref.read(notificationServiceProvider);
        await notificaciones.solicitarPermiso();
        await notificaciones.programarRecordatorioImpuesto(
          impuestoId: id,
          tipoEtiqueta: etiquetaImpuestoTipo(_tipo),
          periodo: _periodoCtrl.text.trim(),
          fechaVencimiento: _fechaVencimiento,
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

  Future<void> _eliminar() async {
    final ok = await confirmarEliminar(
      context,
      'Se borrará este impuesto (${etiquetaImpuestoTipo(_tipo)} · ${_periodoCtrl.text}). '
      'Esta acción no se puede deshacer.',
    );
    if (!ok) return;
    await ref.read(impuestosRepositoryProvider).eliminar(widget.impuesto!.id);
    await ref.read(notificationServiceProvider).cancelarRecordatorio(widget.impuesto!.id);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final impuesto = widget.impuesto;

    return Scaffold(
      appBar: AppBar(title: Text(_esEdicion ? 'Editar impuesto' : 'Nuevo impuesto')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DropdownButtonFormField<ImpuestoTipo>(
              initialValue: _tipo,
              decoration: const InputDecoration(labelText: 'Tipo'),
              items: ImpuestoTipo.values
                  .map((t) => DropdownMenuItem(value: t, child: Text(etiquetaImpuestoTipo(t))))
                  .toList(),
              onChanged: (v) {
                setState(() => _tipo = v ?? _tipo);
                if (!_esEdicion && _tipo == ImpuestoTipo.igv && _montoCtrl.text.isEmpty) {
                  final igvPorPagar = ref.read(igvPorPagarProvider);
                  if (igvPorPagar != null && igvPorPagar > 0) {
                    _montoCtrl.text = igvPorPagar.toStringAsFixed(2);
                  }
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _periodoCtrl,
              decoration: const InputDecoration(
                labelText: 'Periodo',
                hintText: 'Ej. 2026-08',
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Ingresa el periodo' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _montoCtrl,
              decoration: const InputDecoration(labelText: 'Monto (S/)'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
              validator: _validarMonto,
            ),
            if (!_esEdicion && _tipo == ImpuestoTipo.igv)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  'Sugerido con el IGV por pagar acumulado a hoy en Finanzas — '
                  'ajústalo si el periodo a declarar es otro.',
                  style: theme.textTheme.bodySmall,
                ),
              ),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Fecha de vencimiento'),
              subtitle: Text(
                '${_fechaVencimiento.day}/${_fechaVencimiento.month}/${_fechaVencimiento.year}',
              ),
              trailing: const Icon(Icons.calendar_today_outlined),
              onTap: _elegirFechaVencimiento,
            ),
            Text(
              'Se avisa 3 días antes con una notificación.',
              style: theme.textTheme.bodySmall,
            ),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(_error!, style: TextStyle(color: theme.colorScheme.error)),
            ],
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _guardando ? null : _guardar,
              child: Text(_guardando ? 'Guardando…' : 'Guardar'),
            ),
            if (_esEdicion) ...[
              const SizedBox(height: 12),
              if (impuesto!.estado == ImpuestoEstado.pendiente)
                OutlinedButton(
                  onPressed: () => mostrarMarcarPagadoDialog(context, impuesto.id),
                  child: const Text('Marcar como pagado'),
                )
              else
                Text(
                  'Pagado el ${impuesto.fechaPago!.day}/${impuesto.fechaPago!.month}/'
                  '${impuesto.fechaPago!.year}'
                  '${impuesto.comprobantePath != null ? ' · con comprobante' : ''}',
                  style: theme.textTheme.bodyMedium,
                ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: _eliminar,
                style: TextButton.styleFrom(foregroundColor: theme.colorScheme.error),
                child: const Text('Eliminar definitivamente'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
