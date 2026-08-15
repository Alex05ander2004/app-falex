/// Traducciones de los enums de dominio a texto — sin depender de
/// Flutter, para que tanto la capa de datos/estado como la UI puedan
/// usarlas sin invertir la dirección de dependencias (UI → Providers →
/// Repositorios → Datos, ver Ruta Falex sección 05).
library;

import 'enums.dart';

String etiquetaTipoVehiculo(VehiculoTipo tipo) => switch (tipo) {
      VehiculoTipo.trailer => 'Trailer',
      VehiculoTipo.semitrailer => 'Semitrailer',
      VehiculoTipo.otro => 'Otro',
    };

String etiquetaColorVehiculo(VehiculoColor color) => switch (color) {
      VehiculoColor.blanco => 'Blanco',
      VehiculoColor.negro => 'Negro',
      VehiculoColor.gris => 'Gris',
      VehiculoColor.rojo => 'Rojo',
      VehiculoColor.azul => 'Azul',
      VehiculoColor.amarillo => 'Amarillo',
      VehiculoColor.verde => 'Verde',
      VehiculoColor.naranja => 'Naranja',
      VehiculoColor.otro => 'Otro',
    };
