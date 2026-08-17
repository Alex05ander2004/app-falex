/// Enums de dominio compartidos entre la base de datos y la UI.
/// Viven aquí (no dentro de cada feature) porque Drift los mapea
/// directamente a columnas — ver Ruta Falex, sección 04 (modelo de datos).
library;

/// Estado operativo de un [Vehiculo]. Un viaje no debería poder asignarse
/// a un vehículo que no esté `activo` (regla de negocio de la Fase 3).
enum VehiculoEstado { activo, mantenimiento, inactivo }

/// Tipo de unidad remolcada. Falex solo opera trailers y semitrailers
/// por ahora — `otro` cubre cualquier caso futuro sin forzar un valor
/// que no aplica.
enum VehiculoTipo { trailer, semitrailer, otro }

/// Color de la unidad — ayuda a identificarla de un vistazo en la lista
/// y en el patio, más rápido que leer la placa letra por letra.
enum VehiculoColor {
  blanco,
  negro,
  gris,
  rojo,
  azul,
  amarillo,
  verde,
  naranja,
  otro,
}

/// Estado de un [Viaje] a lo largo de su ciclo de vida.
enum ViajeEstado { programado, enCurso, finalizado, cancelado }

/// Destinos principales que opera Falex. Un viaje siempre apunta a uno
/// de estos; si en el camino se extiende a otra provincia, eso se
/// registra aparte como una parada extra (texto libre, ver
/// `ViajeParadas`) porque es un caso excepcional, no parte de la ruta
/// habitual.
enum DestinoPrincipal {
  cuzco,
  juliaca,
  mollendo,
  camana,
  pedregal,
  ilo,
  moquegua,
  tacna,
}

/// Concepto de un ingreso. `flete` es el pago que hace KR por un viaje y
/// lleva descuento de detracción (4%, ver core/finance/detraccion.dart);
/// `otro` es cualquier ingreso que no sea flete y no lleva detracción.
enum IngresoConcepto { flete, otro }

/// Categorías de egreso. Lista inicial acordada como punto de partida
/// razonable (combustible, peajes, viáticos, mantenimiento, multas, otros)
/// — ajustable con el dueño de Falex sin tocar el esquema, ya que es un
/// enum de aplicación, no una tabla separada.
enum EgresoCategoria { combustible, peajes, viaticos, mantenimiento, multas, otros }

/// Estado de pago de un [Impuesto].
enum ImpuestoEstado { pendiente, pagado }
