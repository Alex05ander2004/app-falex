import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/app_exceptions.dart';
import '../../data/viajes_repository.dart';

/// Diálogo para extender un viaje a una provincia extra — caso
/// excepcional, por eso la provincia es texto libre (ver Ruta Falex,
/// respuesta del dueño sobre paradas extra).
Future<void> mostrarAgregarParadaDialog(
  BuildContext context,
  WidgetRef ref,
  int viajeId,
) {
  return showDialog(
    context: context,
    builder: (_) => _AgregarParadaDialog(viajeId: viajeId),
  );
}

class _AgregarParadaDialog extends ConsumerStatefulWidget {
  const _AgregarParadaDialog({required this.viajeId});
  final int viajeId;

  @override
  ConsumerState<_AgregarParadaDialog> createState() => _AgregarParadaDialogState();
}

class _AgregarParadaDialogState extends ConsumerState<_AgregarParadaDialog> {
  final _formKey = GlobalKey<FormState>();
  final _provinciaCtrl = TextEditingController();
  DateTime _fechaSalida = DateTime.now();
  bool _guardando = false;
  String? _error;

  @override
  void dispose() {
    _provinciaCtrl.dispose();
    super.dispose();
  }

  Future<void> _elegirFecha() async {
    final fecha = await showDatePicker(
      context: context,
      initialDate: _fechaSalida,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (fecha != null) setState(() => _fechaSalida = fecha);
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _guardando = true;
      _error = null;
    });
    try {
      await ref.read(viajesRepositoryProvider).agregarParada(
            viajeId: widget.viajeId,
            provincia: _provinciaCtrl.text.trim(),
            fechaSalida: _fechaSalida,
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
    return AlertDialog(
      title: const Text('Extender viaje a otra provincia'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _provinciaCtrl,
              decoration: const InputDecoration(labelText: 'Provincia'),
              textCapitalization: TextCapitalization.words,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Ingresa la provincia' : null,
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Fecha de salida hacia allá'),
              subtitle: Text('${_fechaSalida.day}/${_fechaSalida.month}/${_fechaSalida.year}'),
              trailing: const Icon(Icons.calendar_today_outlined),
              onTap: _elegirFecha,
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
          child: Text(_guardando ? 'Guardando…' : 'Agregar'),
        ),
      ],
    );
  }
}
