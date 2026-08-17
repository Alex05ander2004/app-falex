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

String etiquetaDestinoPrincipal(DestinoPrincipal destino) => switch (destino) {
      DestinoPrincipal.cuzco => 'Cuzco',
      DestinoPrincipal.juliaca => 'Juliaca',
      DestinoPrincipal.mollendo => 'Mollendo',
      DestinoPrincipal.camana => 'Camaná',
      DestinoPrincipal.pedregal => 'Pedregal',
      DestinoPrincipal.ilo => 'Ilo',
      DestinoPrincipal.moquegua => 'Moquegua',
      DestinoPrincipal.tacna => 'Tacna',
    };

String etiquetaViajeEstado(ViajeEstado estado) => switch (estado) {
      ViajeEstado.programado => 'Programado',
      ViajeEstado.enCurso => 'En curso',
      ViajeEstado.finalizado => 'Finalizado',
      ViajeEstado.cancelado => 'Cancelado',
    };

String etiquetaIngresoConcepto(IngresoConcepto concepto) => switch (concepto) {
      IngresoConcepto.flete => 'Flete',
      IngresoConcepto.otro => 'Otro',
    };

String etiquetaEgresoCategoria(EgresoCategoria categoria) => switch (categoria) {
      EgresoCategoria.combustible => 'Combustible',
      EgresoCategoria.peajes => 'Peajes',
      EgresoCategoria.viaticos => 'Viáticos',
      EgresoCategoria.mantenimiento => 'Mantenimiento',
      EgresoCategoria.multas => 'Multas',
      EgresoCategoria.otros => 'Otros',
    };

String etiquetaImpuestoTipo(ImpuestoTipo tipo) => switch (tipo) {
      ImpuestoTipo.igv => 'IGV',
      ImpuestoTipo.renta5taCategoria => 'Renta 5ta categoría',
      ImpuestoTipo.essalud => 'ESSALUD',
      ImpuestoTipo.scrt => 'Seguro SCRT',
      ImpuestoTipo.seguroVida => 'Seguro Vida',
      ImpuestoTipo.afp => 'AFP',
      ImpuestoTipo.otro => 'Otro',
    };

String etiquetaImpuestoEstado(ImpuestoEstado estado) => switch (estado) {
      ImpuestoEstado.pendiente => 'Pendiente',
      ImpuestoEstado.pagado => 'Pagado',
    };
