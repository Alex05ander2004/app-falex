/// Enums de dominio compartidos entre la base de datos y la UI.
/// Viven aquí (no dentro de cada feature) porque Drift los mapea
/// directamente a columnas — ver Ruta Falex, sección 04 (modelo de datos).
library;

/// Estado operativo de un [Vehiculo]. Un viaje no debería poder asignarse
/// a un vehículo que no esté `activo` (regla de negocio de la Fase 3).
enum VehiculoEstado { activo, mantenimiento, inactivo }

/// Estado de un [Viaje] a lo largo de su ciclo de vida.
enum ViajeEstado { programado, enCurso, finalizado, cancelado }

/// Categorías de egreso. Lista inicial acordada como punto de partida
/// razonable (combustible, peajes, viáticos, mantenimiento, multas, otros)
/// — ajustable con el dueño de Falex sin tocar el esquema, ya que es un
/// enum de aplicación, no una tabla separada.
enum EgresoCategoria { combustible, peajes, viaticos, mantenimiento, multas, otros }

/// Estado de pago de un [Impuesto].
enum ImpuestoEstado { pendiente, pagado }
