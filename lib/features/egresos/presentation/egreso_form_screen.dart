import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/enum_labels.dart';
import '../../../core/database/enums.dart';
import '../../../core/errors/app_exceptions.dart';
import '../../../core/finance/igv.dart';
import '../../../core/widgets/comprobante_picker.dart';
import '../../vehiculos/application/vehiculos_list_providers.dart';
import '../../viajes/application/viajes_list_providers.dart';
import '../data/egresos_repository.dart';

/// Alta o edición de un egreso general — ligado o no a un viaje, y
/// opcionalmente a un vehículo (mantenimiento fuera de un viaje puntual).
/// `egreso` nulo = alta.
class EgresoFormScreen extends ConsumerStatefulWidget {
  const EgresoFormScreen({super.key, this.egreso});

  final Egreso? egreso;

  @override
  ConsumerState<EgresoFormScreen> createState() => _EgresoFormScreenState();
}

class _EgresoFormScreenState extends ConsumerState<EgresoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _montoCtrl = TextEditingController();
  final _descripcionCtrl = TextEditingController();
  late EgresoCategoria _categoria = widget.egreso?.categoria ?? EgresoCategoria.combustible;
  late DateTime _fecha = widget.egreso?.fecha ?? DateTime.now();
  late int? _viajeId = widget.egreso?.viajeId;
  late int? _vehiculoId = widget.egreso?.vehiculoId;
  late bool _tieneFacturaConRuc = widget.egreso?.tieneFacturaConRuc ?? false;
  String? _comprobantePath;
  bool _guardando = false;
  String? _error;

  bool get _esEdicion => widget.egreso != null;

  @override
  void initState() {
    super.initState();
    _montoCtrl.text = widget.egreso?.monto.toStringAsFixed(2) ?? '';
    _descripcionCtrl.text = widget.egreso?.descripcion ?? '';
    _comprobantePath = widget.egreso?.comprobantePath;
    _montoCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _montoCtrl.dispose();
    _descripcionCtrl.dispose();
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
    try {
      final repo = ref.read(egresosRepositoryProvider);
      if (_esEdicion) {
        await repo.actualizar(
          widget.egreso!.id,
          EgresosCompanion(
            monto: Value(double.parse(_montoCtrl.text.trim())),
            fecha: Value(_fecha),
            categoria: Value(_categoria),
            descripcion: Value(
              _descripcionCtrl.text.trim().isEmpty ? null : _descripcionCtrl.text.trim(),
            ),
            viajeId: Value(_viajeId),
            vehiculoId: Value(_vehiculoId),
            tieneFacturaConRuc: Value(_tieneFacturaConRuc),
            comprobantePath: Value(_comprobantePath),
          ),
        );
      } else {
        await repo.crear(
          EgresosCompanion.insert(
            monto: double.parse(_montoCtrl.text.trim()),
            fecha: _fecha,
            categoria: _categoria,
            descripcion: Value(
              _descripcionCtrl.text.trim().isEmpty ? null : _descripcionCtrl.text.trim(),
            ),
            viajeId: Value(_viajeId),
            vehiculoId: Value(_vehiculoId),
            tieneFacturaConRuc: Value(_tieneFacturaConRuc),
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
    final vehiculosAsync = ref.watch(vehiculosTodosProvider);
    final viajes = viajesAsync.valueOrNull ?? const [];
    final vehiculos = vehiculosAsync.valueOrNull ?? const [];
    final montoIngresado = double.tryParse(_montoCtrl.text.trim());

    return Scaffold(
      appBar: AppBar(title: Text(_esEdicion ? 'Editar gasto' : 'Nuevo gasto')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _montoCtrl,
              decoration: const InputDecoration(labelText: 'Monto (S/)'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
              validator: _validarMonto,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<EgresoCategoria>(
              initialValue: _categoria,
              decoration: const InputDecoration(labelText: 'Categoría'),
              items: EgresoCategoria.values
                  .map((c) => DropdownMenuItem(value: c, child: Text(etiquetaEgresoCategoria(c))))
                  .toList(),
              onChanged: (v) => setState(() => _categoria = v ?? _categoria),
            ),
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
              onChanged: (v) => setState(() => _viajeId = v),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<int?>(
              initialValue: _vehiculoId,
              decoration: const InputDecoration(labelText: 'Vehículo relacionado (opcional)'),
              items: [
                const DropdownMenuItem<int?>(value: null, child: Text('Ninguno')),
                ...vehiculos.map((v) => DropdownMenuItem<int?>(value: v.id, child: Text(v.placa))),
              ],
              onChanged: (v) => setState(() => _vehiculoId = v),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descripcionCtrl,
              decoration: const InputDecoration(labelText: 'Descripción (opcional)'),
            ),
            const SizedBox(height: 8),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              value: _tieneFacturaConRuc,
              title: const Text('Tiene factura con RUC de Falex'),
              onChanged: (v) => setState(() => _tieneFacturaConRuc = v ?? false),
            ),
            if (_tieneFacturaConRuc && montoIngresado != null && montoIngresado > 0)
              Text(
                'Crédito fiscal (18%, reduce el IGV por pagar): '
                'S/ ${calcularIgv(montoIngresado).toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodySmall,
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
