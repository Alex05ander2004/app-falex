import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Foto de boleta/factura por cámara o galería — Ruta Falex, Fase 4.
/// La imagen se copia a la carpeta de la app (comprobantes/) y solo esa
/// ruta local se guarda en la base; nunca se sube a ningún lado.
class ComprobantePicker extends StatelessWidget {
  const ComprobantePicker({
    super.key,
    required this.path,
    required this.onChanged,
  });

  final String? path;
  final ValueChanged<String?> onChanged;

  Future<void> _elegir(BuildContext context) async {
    final origen = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: const Text('Tomar foto'),
              onTap: () => Navigator.of(context).pop(ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Elegir de la galería'),
              onTap: () => Navigator.of(context).pop(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
    if (origen == null) return;

    final foto = await ImagePicker().pickImage(source: origen, imageQuality: 80);
    if (foto == null) return;

    final carpetaDocs = await getApplicationDocumentsDirectory();
    final carpetaComprobantes = Directory(p.join(carpetaDocs.path, 'comprobantes'));
    await carpetaComprobantes.create(recursive: true);
    final nombreArchivo =
        'comprobante_${DateTime.now().millisecondsSinceEpoch}${p.extension(foto.path)}';
    final destino = p.join(carpetaComprobantes.path, nombreArchivo);
    await File(foto.path).copy(destino);

    onChanged(destino);
  }

  @override
  Widget build(BuildContext context) {
    if (path == null) {
      return OutlinedButton.icon(
        onPressed: () => _elegir(context),
        icon: const Icon(Icons.attach_file),
        label: const Text('Adjuntar comprobante (opcional)'),
      );
    }
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(File(path!), width: 56, height: 56, fit: BoxFit.cover),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'Comprobante adjunto',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        TextButton(
          onPressed: () => _elegir(context),
          child: const Text('Cambiar'),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          tooltip: 'Quitar',
          onPressed: () => onChanged(null),
        ),
      ],
    );
  }
}
