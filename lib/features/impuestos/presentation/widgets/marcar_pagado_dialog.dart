import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/notifications/notification_service.dart';
import '../../../../core/widgets/comprobante_picker.dart';
import '../../data/impuestos_repository.dart';

/// Confirma el pago de un impuesto: fecha real de pago + comprobante —
/// Ruta Falex, Fase 5.
Future<void> mostrarMarcarPagadoDialog(BuildContext context, int impuestoId) {
  return showDialog(
    context: context,
    builder: (_) => _MarcarPagadoDialog(impuestoId: impuestoId),
  );
}

class _MarcarPagadoDialog extends ConsumerStatefulWidget {
  const _MarcarPagadoDialog({required this.impuestoId});
  final int impuestoId;

  @override
  ConsumerState<_MarcarPagadoDialog> createState() => _MarcarPagadoDialogState();
}

class _MarcarPagadoDialogState extends ConsumerState<_MarcarPagadoDialog> {
  DateTime _fechaPago = DateTime.now();
  String? _comprobantePath;
  bool _guardando = false;

  Future<void> _elegirFecha() async {
    final fecha = await showDatePicker(
      context: context,
      initialDate: _fechaPago,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (fecha != null) setState(() => _fechaPago = fecha);
  }

  Future<void> _confirmar() async {
    setState(() => _guardando = true);
    await ref.read(impuestosRepositoryProvider).marcarComoPagado(
          widget.impuestoId,
          fechaPago: _fechaPago,
          comprobantePath: _comprobantePath,
        );
    await ref.read(notificationServiceProvider).cancelarRecordatorio(widget.impuestoId);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Marcar como pagado'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Fecha de pago'),
              subtitle: Text('${_fechaPago.day}/${_fechaPago.month}/${_fechaPago.year}'),
              trailing: const Icon(Icons.calendar_today_outlined),
              onTap: _elegirFecha,
            ),
            const SizedBox(height: 8),
            ComprobantePicker(
              path: _comprobantePath,
              onChanged: (path) => setState(() => _comprobantePath = path),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: _guardando ? null : _confirmar,
          child: Text(_guardando ? 'Guardando…' : 'Confirmar pago'),
        ),
      ],
    );
  }
}
