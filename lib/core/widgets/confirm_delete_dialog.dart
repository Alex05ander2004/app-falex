import 'package:flutter/material.dart';

/// Confirmación antes de borrar — ver Ruta Falex, "Validaciones y manejo
/// de errores": ninguna acción destructiva se ejecuta sin avisar.
Future<bool> confirmarEliminar(BuildContext context, String mensaje) async {
  final confirmado = await showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('¿Eliminar?'),
      content: Text(mensaje),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Eliminar'),
        ),
      ],
    ),
  );
  return confirmado ?? false;
}
