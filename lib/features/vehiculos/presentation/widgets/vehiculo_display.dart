import 'package:flutter/material.dart';

import '../../../../core/database/enums.dart';

export '../../../../core/database/enum_labels.dart';

/// Color real para pintar el punto/swatch — no confundir con el color
/// del theme de la app. Vive en la UI (a diferencia de las etiquetas de
/// texto) porque [Color] es un tipo de Flutter, no de dominio.
Color pinturaColorVehiculo(VehiculoColor color) => switch (color) {
      VehiculoColor.blanco => const Color(0xFFF5F5F5),
      VehiculoColor.negro => const Color(0xFF1C1C1C),
      VehiculoColor.gris => const Color(0xFF9AA0A6),
      VehiculoColor.rojo => const Color(0xFFD32F2F),
      VehiculoColor.azul => const Color(0xFF1976D2),
      VehiculoColor.amarillo => const Color(0xFFFBC02D),
      VehiculoColor.verde => const Color(0xFF388E3C),
      VehiculoColor.naranja => const Color(0xFFF57C00),
      VehiculoColor.otro => const Color(0xFFB39DDB),
    };
