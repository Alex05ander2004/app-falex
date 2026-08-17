import '../../../core/database/app_database.dart';

/// Un [Viaje] junto al trabajador y vehículo que le corresponden — para
/// no forzar a cada pantalla a resolver esas dos referencias por su
/// cuenta cada vez que muestra la lista.
class ViajeConDetalle {
  const ViajeConDetalle({
    required this.viaje,
    required this.trabajador,
    required this.vehiculo,
  });

  final Viaje viaje;
  final Trabajador trabajador;
  final Vehiculo vehiculo;
}
