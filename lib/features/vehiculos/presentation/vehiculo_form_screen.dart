import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/enums.dart';
import '../../../core/errors/app_exceptions.dart';
import '../data/vehiculos_repository.dart';
import 'widgets/vehiculo_color_picker.dart';
import 'widgets/vehiculo_display.dart';

/// Alta o edición de un vehículo. `vehiculo` nulo = alta.
class VehiculoFormScreen extends ConsumerStatefulWidget {
  const VehiculoFormScreen({super.key, this.vehiculo});

  final Vehiculo? vehiculo;

  @override
  ConsumerState<VehiculoFormScreen> createState() => _VehiculoFormScreenState();
}

class _VehiculoFormScreenState extends ConsumerState<VehiculoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _placaCtrl = TextEditingController(text: widget.vehiculo?.placa ?? '');
  late final _marcaCtrl = TextEditingController(text: widget.vehiculo?.marca ?? '');
  late final _modeloCtrl = TextEditingController(text: widget.vehiculo?.modelo ?? '');
  late final _anioCtrl =
      TextEditingController(text: widget.vehiculo?.anio?.toString() ?? '');
  late VehiculoTipo _tipo = widget.vehiculo?.tipo ?? VehiculoTipo.trailer;
  VehiculoColor? _color;
  DateTime? _soatVencimiento;
  DateTime? _revisionVencimiento;
  bool _guardando = false;

  bool get _esEdicion => widget.vehiculo != null;

  @override
  void initState() {
    super.initState();
    _color = widget.vehiculo?.color;
    _soatVencimiento = widget.vehiculo?.soatVencimiento;
    _revisionVencimiento = widget.vehiculo?.revisionTecnicaVencimiento;
  }

  @override
  void dispose() {
    _placaCtrl.dispose();
    _marcaCtrl.dispose();
    _modeloCtrl.dispose();
    _anioCtrl.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _guardando = true);
    final repo = ref.read(vehiculosRepositoryProvider);
    final anio = _anioCtrl.text.trim().isEmpty ? null : int.tryParse(_anioCtrl.text.trim());
    try {
      if (_esEdicion) {
        await repo.actualizar(
          widget.vehiculo!.id,
          VehiculosCompanion(
            placa: Value(_placaCtrl.text.trim().toUpperCase()),
            tipo: Value(_tipo),
            color: Value(_color),
            marca: Value(_marcaCtrl.text.trim().isEmpty ? null : _marcaCtrl.text.trim()),
            modelo: Value(_modeloCtrl.text.trim().isEmpty ? null : _modeloCtrl.text.trim()),
            anio: Value(anio),
            soatVencimiento: Value(_soatVencimiento),
            revisionTecnicaVencimiento: Value(_revisionVencimiento),
          ),
        );
      } else {
        await repo.crear(
          VehiculosCompanion.insert(
            placa: _placaCtrl.text.trim().toUpperCase(),
            tipo: _tipo,
            color: Value(_color),
            marca: Value(_marcaCtrl.text.trim().isEmpty ? null : _marcaCtrl.text.trim()),
            modelo: Value(_modeloCtrl.text.trim().isEmpty ? null : _modeloCtrl.text.trim()),
            anio: Value(anio),
            soatVencimiento: Value(_soatVencimiento),
            revisionTecnicaVencimiento: Value(_revisionVencimiento),
          ),
        );
      }
      if (!mounted) return;
      Navigator.of(context).pop();
    } on RegistroDuplicadoException catch (e) {
      _mostrarError(e.mensaje);
    } catch (e) {
      _mostrarError('No se pudo guardar: $e');
    } finally {
      if (mounted) setState(() => _guardando = false);
    }
  }

  Future<void> _cambiarEstado(VehiculoEstado estado) async {
    try {
      await ref
          .read(vehiculosRepositoryProvider)
          .cambiarEstado(widget.vehiculo!.id, estado);
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

  Future<void> _elegirFecha(DateTime? actual, ValueChanged<DateTime> onPick) async {
    final fecha = await showDatePicker(
      context: context,
      initialDate: actual ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (fecha != null) onPick(fecha);
  }

  String _formatearFecha(DateTime? fecha) =>
      fecha == null ? 'No especificada' : '${fecha.day}/${fecha.month}/${fecha.year}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_esEdicion ? 'Editar vehículo' : 'Nuevo vehículo'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _placaCtrl,
              decoration: const InputDecoration(
                labelText: 'Placa',
                counterText: '',
              ),
              textCapitalization: TextCapitalization.characters,
              inputFormatters: [
                UpperCaseTextFormatter(),
                LengthLimitingTextInputFormatter(6),
              ],
              maxLength: 6,
              validator: (v) {
                final placa = v?.trim() ?? '';
                if (placa.isEmpty) return 'Ingresa la placa';
                if (placa.length != 6) return 'La placa debe tener 6 caracteres';
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<VehiculoTipo>(
              initialValue: _tipo,
              decoration: const InputDecoration(labelText: 'Tipo'),
              items: VehiculoTipo.values
                  .map((t) => DropdownMenuItem(
                        value: t,
                        child: Text(etiquetaTipoVehiculo(t)),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _tipo = v ?? _tipo),
            ),
            const SizedBox(height: 20),
            VehiculoColorPicker(
              seleccionado: _color,
              onChanged: (c) => setState(() => _color = c),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _marcaCtrl,
                    decoration: const InputDecoration(labelText: 'Marca (opcional)'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _modeloCtrl,
                    decoration: const InputDecoration(labelText: 'Modelo (opcional)'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _anioCtrl,
              decoration: const InputDecoration(labelText: 'Año (opcional)'),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4),
              ],
            ),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Vencimiento SOAT'),
              subtitle: Text(_formatearFecha(_soatVencimiento)),
              trailing: const Icon(Icons.calendar_today_outlined),
              onTap: () => _elegirFecha(
                _soatVencimiento,
                (f) => setState(() => _soatVencimiento = f),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Vencimiento revisión técnica'),
              subtitle: Text(_formatearFecha(_revisionVencimiento)),
              trailing: const Icon(Icons.calendar_today_outlined),
              onTap: () => _elegirFecha(
                _revisionVencimiento,
                (f) => setState(() => _revisionVencimiento = f),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _guardando ? null : _guardar,
              child: Text(_guardando ? 'Guardando…' : 'Guardar'),
            ),
            if (_esEdicion) ...[
              const SizedBox(height: 12),
              const Text('Estado operativo'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: VehiculoEstado.values.map((estado) {
                  final seleccionado = widget.vehiculo!.estado == estado;
                  return ChoiceChip(
                    label: Text(estado.name),
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
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(text: newValue.text.toUpperCase());
  }
}
