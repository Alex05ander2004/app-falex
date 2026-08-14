import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/errors/app_exceptions.dart';
import '../data/trabajadores_repository.dart';

/// Alta o edición de un trabajador. `trabajador` nulo = alta.
class TrabajadorFormScreen extends ConsumerStatefulWidget {
  const TrabajadorFormScreen({super.key, this.trabajador});

  final Trabajador? trabajador;

  @override
  ConsumerState<TrabajadorFormScreen> createState() =>
      _TrabajadorFormScreenState();
}

class _TrabajadorFormScreenState extends ConsumerState<TrabajadorFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _nombreCtrl =
      TextEditingController(text: widget.trabajador?.nombre ?? '');
  late final _dniCtrl =
      TextEditingController(text: widget.trabajador?.dni ?? '');
  late final _telefonoCtrl =
      TextEditingController(text: widget.trabajador?.telefono ?? '');
  late final _cargoCtrl = TextEditingController(
    text: widget.trabajador?.cargo ?? 'Chofer',
  );
  DateTime? _fechaIngreso;
  bool _guardando = false;

  bool get _esEdicion => widget.trabajador != null;

  @override
  void initState() {
    super.initState();
    _fechaIngreso = widget.trabajador?.fechaIngreso;
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _dniCtrl.dispose();
    _telefonoCtrl.dispose();
    _cargoCtrl.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _guardando = true);
    final repo = ref.read(trabajadoresRepositoryProvider);
    try {
      if (_esEdicion) {
        await repo.actualizar(
          widget.trabajador!.id,
          TrabajadoresCompanion(
            nombre: Value(_nombreCtrl.text.trim()),
            dni: Value(_dniCtrl.text.trim()),
            telefono: Value(
              _telefonoCtrl.text.trim().isEmpty ? null : _telefonoCtrl.text.trim(),
            ),
            cargo: Value(_cargoCtrl.text.trim()),
            fechaIngreso: Value(_fechaIngreso),
          ),
        );
      } else {
        await repo.crear(
          TrabajadoresCompanion.insert(
            nombre: _nombreCtrl.text.trim(),
            dni: _dniCtrl.text.trim(),
            telefono: Value(
              _telefonoCtrl.text.trim().isEmpty ? null : _telefonoCtrl.text.trim(),
            ),
            cargo: Value(_cargoCtrl.text.trim()),
            fechaIngreso: Value(_fechaIngreso),
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

  Future<void> _cambiarActivo(bool activo) async {
    if (!activo) {
      final confirmar = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('¿Dar de baja a este trabajador?'),
          content: const Text(
            'Queda marcado como inactivo y sale de la lista principal. '
            'No se borra su historial de viajes.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Dar de baja'),
            ),
          ],
        ),
      );
      if (confirmar != true) return;
    }
    try {
      await ref
          .read(trabajadoresRepositoryProvider)
          .cambiarActivo(widget.trabajador!.id, activo);
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

  Future<void> _elegirFecha() async {
    final fecha = await showDatePicker(
      context: context,
      initialDate: _fechaIngreso ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (fecha != null) setState(() => _fechaIngreso = fecha);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_esEdicion ? 'Editar trabajador' : 'Nuevo trabajador'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nombreCtrl,
              decoration: const InputDecoration(labelText: 'Nombre completo'),
              textCapitalization: TextCapitalization.words,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Ingresa el nombre' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _dniCtrl,
              decoration: const InputDecoration(labelText: 'DNI'),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(8),
              ],
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Ingresa el DNI';
                if (v.trim().length != 8) return 'El DNI debe tener 8 dígitos';
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _telefonoCtrl,
              decoration: const InputDecoration(labelText: 'Teléfono (opcional)'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _cargoCtrl,
              decoration: const InputDecoration(labelText: 'Cargo'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Ingresa el cargo' : null,
            ),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Fecha de ingreso'),
              subtitle: Text(
                _fechaIngreso == null
                    ? 'No especificada'
                    : '${_fechaIngreso!.day}/${_fechaIngreso!.month}/${_fechaIngreso!.year}',
              ),
              trailing: const Icon(Icons.calendar_today_outlined),
              onTap: _elegirFecha,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _guardando ? null : _guardar,
              child: Text(_guardando ? 'Guardando…' : 'Guardar'),
            ),
            if (_esEdicion) ...[
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => _cambiarActivo(!widget.trabajador!.activo),
                child: Text(
                  widget.trabajador!.activo
                      ? 'Dar de baja'
                      : 'Reactivar trabajador',
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
