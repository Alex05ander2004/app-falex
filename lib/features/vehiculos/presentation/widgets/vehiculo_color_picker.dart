import 'package:flutter/material.dart';

import '../../../../core/database/enums.dart';
import 'vehiculo_display.dart';

/// Selector visual de color: un círculo pintado por opción, más rápido
/// de reconocer que un dropdown con nombres — ver Ruta Falex, este
/// pedido busca identificar la unidad "de un vistazo".
class VehiculoColorPicker extends StatelessWidget {
  const VehiculoColorPicker({
    super.key,
    required this.seleccionado,
    required this.onChanged,
  });

  final VehiculoColor? seleccionado;
  final ValueChanged<VehiculoColor?> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Color (opcional)', style: theme.textTheme.bodyMedium),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: VehiculoColor.values.map((color) {
            final activo = seleccionado == color;
            return GestureDetector(
              onTap: () => onChanged(activo ? null : color),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: pinturaColorVehiculo(color),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: activo
                            ? theme.colorScheme.tertiary
                            : theme.colorScheme.outlineVariant,
                        width: activo ? 3 : 1,
                      ),
                    ),
                    child: activo
                        ? Icon(
                            Icons.check,
                            size: 16,
                            color: ThemeData.estimateBrightnessForColor(
                                        pinturaColorVehiculo(color)) ==
                                    Brightness.dark
                                ? Colors.white
                                : Colors.black87,
                          )
                        : null,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    etiquetaColorVehiculo(color),
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
